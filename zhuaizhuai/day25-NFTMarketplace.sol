// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
// ReentrancyGuard = 防重入攻击！之前学过的 😊

contract NFTMarketplace is ReentrancyGuard {
    
    address public owner;
    uint256 public marketplaceFeePercent; // 平台手续费（基点，100=1%）
    address public feeRecipient;          // 手续费收款地址

    // NFT上架信息
    struct Listing {
        address seller;           // 卖家地址
        address nftAddress;       // NFT合约地址
        uint256 tokenId;          // NFT编号
        uint256 price;            // 售价（wei）
        address royaltyReceiver;  // 版税收款地址（通常是创作者）
        uint256 royaltyPercent;   // 版税比例（基点，100=1%）
        bool isListed;            // 是否在售
    }

    // NFT合约地址 → tokenId → 上架信息
    mapping(address => mapping(uint256 => Listing)) public listings;

    // 事件记录
    event Listed(        // 上架NFT
        address indexed seller,
        address indexed nftAddress,
        uint256 indexed tokenId,
        uint256 price,
        address royaltyReceiver,
        uint256 royaltyPercent
    );

    event Purchase(      // 购买NFT
        address indexed buyer,
        address indexed nftAddress,
        uint256 indexed tokenId,
        uint256 price,
        address seller,
        address royaltyReceiver,
        uint256 royaltyAmount,        // 版税金额
        uint256 marketplaceFeeAmount  // 平台手续费金额
    );

    event Unlisted(      // 下架NFT
        address indexed seller,
        address indexed nftAddress,
        uint256 indexed tokenId
    );

    event FeeUpdated(    // 手续费更新
        uint256 newMarketplaceFee,
        address newFeeRecipient
    );

    // 部署时设置平台手续费和收款地址
    constructor(uint256 _marketplaceFeePercent, address _feeRecipient) {
        require(_marketplaceFeePercent <= 1000, "Marketplace fee too high (max 10%)");
        // 手续费最高10%（1000基点）
        require(_feeRecipient != address(0), "Fee recipient cannot be zero");

        owner = msg.sender;
        marketplaceFeePercent = _marketplaceFeePercent;
        feeRecipient = _feeRecipient;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner");
        _;
    }

    // 修改平台手续费
    function setMarketplaceFeePercent(uint256 _newFee) external onlyOwner {
        require(_newFee <= 1000, "Marketplace fee too high");
        marketplaceFeePercent = _newFee;
        emit FeeUpdated(_newFee, feeRecipient);
    }

    // 修改手续费收款地址
    function setFeeRecipient(address _newRecipient) external onlyOwner {
        require(_newRecipient != address(0), "Invalid fee recipient");
        feeRecipient = _newRecipient;
        emit FeeUpdated(marketplaceFeePercent, _newRecipient);
    }

    // 上架NFT
    function listNFT(
        address nftAddress,       // NFT合约地址
        uint256 tokenId,          // NFT编号
        uint256 price,            // 售价
        address royaltyReceiver,  // 版税收款人
        uint256 royaltyPercent    // 版税比例
    ) external {
        require(price > 0, "Price must be above zero");
        require(royaltyPercent <= 1000, "Max 10% royalty allowed");  // 版税最高10%
        require(!listings[nftAddress][tokenId].isListed, "Already listed");  // 没有重复上架

        IERC721 nft = IERC721(nftAddress);
        require(nft.ownerOf(tokenId) == msg.sender, "Not the owner");
        // 必须是NFT的拥有者才能上架

        require(
            nft.getApproved(tokenId) == address(this) ||
            nft.isApprovedForAll(msg.sender, address(this)),
            "Marketplace not approved"
        );
        // 必须先授权市场合约可以转移这个NFT！

        // 记录上架信息
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

    // 购买NFT
    // nonReentrant = 防止重入攻击！
    function buyNFT(address nftAddress, uint256 tokenId) external payable nonReentrant {
        Listing memory item = listings[nftAddress][tokenId];
        require(item.isListed, "Not listed");               // 必须在售
        require(msg.value == item.price, "Incorrect ETH sent");  // 必须付对价格
        require(
            item.royaltyPercent + marketplaceFeePercent <= 10000,
            "Combined fees exceed 100%"
        );

        // 计算各方金额
        uint256 feeAmount = (msg.value * marketplaceFeePercent) / 10000;    // 平台手续费
        uint256 royaltyAmount = (msg.value * item.royaltyPercent) / 10000;  // 创作者版税
        uint256 sellerAmount = msg.value - feeAmount - royaltyAmount;        // 卖家实收

        // 比如：NFT售价100ETH，手续费2%，版税5%
        // 平台收：2ETH
        // 创作者收：5ETH
        // 卖家收：93ETH

        // 转给平台
        if (feeAmount > 0) {
            payable(feeRecipient).transfer(feeAmount);
        }

        // 转给创作者（版税）
        if (royaltyAmount > 0 && item.royaltyReceiver != address(0)) {
            payable(item.royaltyReceiver).transfer(royaltyAmount);
        }

        // 转给卖家
        payable(item.seller).transfer(sellerAmount);

        // 把NFT转给买家
        IERC721(item.nftAddress).safeTransferFrom(item.seller, msg.sender, item.tokenId);

        // 删除上架记录
        delete listings[nftAddress][tokenId];

        emit Purchase(
            msg.sender, nftAddress, tokenId, msg.value,
            item.seller, item.royaltyReceiver, royaltyAmount, feeAmount
        );
    }

    // 下架NFT
    function cancelListing(address nftAddress, uint256 tokenId) external {
        Listing memory item = listings[nftAddress][tokenId];
        require(item.isListed, "Not listed");
        require(item.seller == msg.sender, "Not the seller");  // 只有卖家能下架

        delete listings[nftAddress][tokenId];  // 删除上架记录
        emit Unlisted(msg.sender, nftAddress, tokenId);
    }

    // 查询上架信息
    function getListing(address nftAddress, uint256 tokenId) external view returns (Listing memory) {
        return listings[nftAddress][tokenId];
    }

    // 拒绝直接转ETH
    receive() external payable {
        revert("Direct ETH not accepted");
    }

    // 拒绝未知函数调用
    fallback() external payable {
        revert("Unknown function");
    }
}
