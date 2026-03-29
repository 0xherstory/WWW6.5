// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";

/**
 * @title NFTMarketplace
 * @notice 完整的链上 NFT 交易市场
 * 支持挂单、购买、版税与手续费分配
 */
contract NFTMarketplace is ReentrancyGuard {
    
    // ============ 状态变量 ============
    
    address public owner;
    uint256 public marketplaceFeePercent;  // 以基点为单位 (100 = 1%)
    address public feeRecipient;
    
    // ============ 数据结构 ============
    
    struct Listing {
        address seller;
        address nftAddress;
        uint256 tokenId;
        uint256 price;
        address royaltyReceiver;
        uint256 royaltyPercent;  // 以基点为单位
        bool isListed;
    }
    
    // 嵌套映射：NFT合约地址 => TokenID => 挂单信息
    mapping(address => mapping(uint256 => Listing)) public listings;
    
    // ============ 事件 ============
    
    event Listed(
        address indexed seller,
        address indexed nftAddress,
        uint256 indexed tokenId,
        uint256 price,
        address royaltyReceiver,
        uint256 royaltyPercent
    );
    
    event Purchase(
        address indexed buyer,
        address indexed nftAddress,
        uint256 indexed tokenId,
        uint256 price,
        address seller,
        address royaltyReceiver,
        uint256 royaltyAmount,
        uint256 marketplaceFeeAmount
    );
    
    event Unlisted(
        address indexed seller,
        address indexed nftAddress,
        uint256 indexed tokenId
    );
    
    event FeeUpdated(
        uint256 newMarketplaceFee,
        address newFeeRecipient
    );
    
    // ============ 修饰符 ============
    
    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner");
        _;
    }
    
    // ============ 构造函数 ============
    
    constructor(uint256 _marketplaceFeePercent, address _feeRecipient) {
        require(_marketplaceFeePercent <= 1000, "Marketplace fee too high (max 10%)");
        require(_feeRecipient != address(0), "Fee recipient cannot be zero");
        
        owner = msg.sender;
        marketplaceFeePercent = _marketplaceFeePercent;
        feeRecipient = _feeRecipient;
    }
    
    // ============ 管理员功能 ============
    
    /**
     * @notice 更新市场手续费比例
     */
    function setMarketplaceFeePercent(uint256 _newFee) external onlyOwner {
        require(_newFee <= 1000, "Marketplace fee too high");
        marketplaceFeePercent = _newFee;
        emit FeeUpdated(_newFee, feeRecipient);
    }
    
    /**
     * @notice 更新手续费接收地址
     */
    function setFeeRecipient(address _newRecipient) external onlyOwner {
        require(_newRecipient != address(0), "Invalid fee recipient");
        feeRecipient = _newRecipient;
        emit FeeUpdated(marketplaceFeePercent, _newRecipient);
    }
    
    // ============ 核心功能 ============
    
    /**
     * @notice 挂单 NFT
     * @param nftAddress NFT 合约地址
     * @param tokenId NFT 的 Token ID
     * @param price 售价（以 wei 为单位）
     * @param royaltyReceiver 版税接收地址
     * @param royaltyPercent 版税比例（基点，如 500 = 5%）
     */
    function listNFT(
        address nftAddress,
        uint256 tokenId,
        uint256 price,
        address royaltyReceiver,
        uint256 royaltyPercent
    ) external {
        require(price > 0, "Price must be above zero");
        require(royaltyPercent <= 1000, "Max 10% royalty allowed");
        require(!listings[nftAddress][tokenId].isListed, "Already listed");
        
        IERC721 nft = IERC721(nftAddress);
        require(nft.ownerOf(tokenId) == msg.sender, "Not the owner");
        require(
            nft.getApproved(tokenId) == address(this) || 
            nft.isApprovedForAll(msg.sender, address(this)),
            "Marketplace not approved"
        );
        
        listings[nftAddress][tokenId] = Listing({
            seller: msg.sender,
            nftAddress: nftAddress,
            tokenId: tokenId,
            price: price,
            royaltyReceiver: royaltyReceiver,
            royaltyPercent: royaltyPercent,
            isListed: true
        });
        
        emit Listed(msg.sender, nftAddress, tokenId, price, royaltyReceiver, royaltyPercent);
    }
    
    /**
     * @notice 购买 NFT
     */
    function buyNFT(address nftAddress, uint256 tokenId) 
        external 
        payable 
        nonReentrant 
    {
        Listing memory item = listings[nftAddress][tokenId];
        require(item.isListed, "Not listed");
        require(msg.value == item.price, "Incorrect ETH sent");
        require(
            item.royaltyPercent + marketplaceFeePercent <= 10000,
            "Combined fees exceed 100%"
        );
        
        // 计算费用分配
        uint256 feeAmount = (msg.value * marketplaceFeePercent) / 10000;
        uint256 royaltyAmount = (msg.value * item.royaltyPercent) / 10000;
        uint256 sellerAmount = msg.value - feeAmount - royaltyAmount;
        
        // 市场手续费
        if (feeAmount > 0) {
            payable(feeRecipient).transfer(feeAmount);
        }
        
        // 创作者版税
        if (royaltyAmount > 0 && item.royaltyReceiver != address(0)) {
            payable(item.royaltyReceiver).transfer(royaltyAmount);
        }
        
        // 卖家收益
        payable(item.seller).transfer(sellerAmount);
        
        // 转移 NFT 给买家
        IERC721(item.nftAddress).safeTransferFrom(
            item.seller, 
            msg.sender, 
            item.tokenId
        );
        
        // 删除挂单
        delete listings[nftAddress][tokenId];
        
        emit Purchase(
            msg.sender,
            nftAddress,
            tokenId,
            msg.value,
            item.seller,
            item.royaltyReceiver,
            royaltyAmount,
            feeAmount
        );
    }
    
    /**
     * @notice 取消挂单
     */
    function cancelListing(address nftAddress, uint256 tokenId) external {
        Listing memory item = listings[nftAddress][tokenId];
        require(item.isListed, "Not listed");
        require(item.seller == msg.sender, "Not the seller");
        
        delete listings[nftAddress][tokenId];
        emit Unlisted(msg.sender, nftAddress, tokenId);
    }
    
    /**
     * @notice 查询挂单信息
     */
    function getListing(address nftAddress, uint256 tokenId) 
        external 
        view 
        returns (Listing memory) 
    {
        return listings[nftAddress][tokenId];
    }
    
    // ============ 安全防护 ============
    
    /**
     * @notice 拒绝直接 ETH 转账
     */
    receive() external payable {
        revert("Direct ETH not accepted");
    }
    
    /**
     * @notice 拒绝未知函数调用
     */
    fallback() external payable {
        revert("Unknown function");
    }
}