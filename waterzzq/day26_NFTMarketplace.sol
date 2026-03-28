// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// 导入OpenZeppelin的ERC721标准接口（母合约，兼容所有NFT）
import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
// 导入OpenZeppelin的重入防护母合约（防重入攻击，安全核心）
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";

/// @title NFTMarketplace - 去中心化NFT交易市场（链上版OpenSea，带版税、手续费、重入防护）
contract NFTMarketplace is ReentrancyGuard {
    // ==================== 状态变量：存储市场核心数据 ====================
    address public owner; // 市场所有者（部署合约的人）
    // 市场手续费（基点制：100 = 1%，最高10% = 1000基点）
    uint256 public marketplaceFeePercent;
    address public feeRecipient; // 手续费接收地址（市场运营方钱包）

    // ==================== 挂单结构体：存储每一个NFT的挂单信息 ====================
    struct Listing {
        address seller;        // 卖家地址
        address nftAddress;    // NFT合约地址
        uint256 tokenId;       // NFT的唯一身份证号（tokenId）
        uint256 price;         // 挂单价格（单位：wei）
        address royaltyReceiver; // 创作者地址（拿版税的人）
        uint256 royaltyPercent; // 版税比例（基点制，最高10% = 1000基点）
        bool isListed;         // 是否正在挂单（true=挂单中，false=已成交/取消）
    }

    // 存储所有挂单：NFT合约地址 => tokenId => 挂单详情
    mapping(address => mapping(uint256 => Listing)) public listings;

    // ==================== 事件：记录所有操作，链上可查、全程透明 ====================
    event Listed(
        address indexed seller,
        address indexed nftAddress,
        uint256 indexed tokenId,
        uint256 price,
        address royaltyReceiver,
        uint256 royaltyPercent
    ); // 卖家挂单成功

    event Purchase(
        address indexed buyer,
        address indexed nftAddress,
        uint256 indexed tokenId,
        uint256 price,
        address seller,
        address royaltyReceiver,
        uint256 royaltyAmount,
        uint256 marketplaceFeeAmount
    ); // 买家购买成功

    event Unlisted(
        address indexed seller,
        address indexed nftAddress,
        uint256 indexed tokenId
    ); // 卖家取消挂单

    event FeeUpdated(
        uint256 newMarketplaceFee,
        address newFeeRecipient
    ); // 市场手续费/接收地址更新

    // ==================== 权限修饰器：只有市场所有者能调用 ====================
    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this function");
        _;
    }

    // ==================== 构造函数：部署合约时初始化 ====================
    constructor(uint256 _marketplaceFeePercent, address _feeRecipient) {
        // 市场手续费最高10%（1000基点），防止乱收费
        require(_marketplaceFeePercent <= 1000, "Marketplace fee too high (max 10%)");
        // 手续费接收地址不能是零地址（防止丢钱）
        require(_feeRecipient != address(0), "Fee recipient cannot be zero");

        owner = msg.sender;
        marketplaceFeePercent = _marketplaceFeePercent;
        feeRecipient = _feeRecipient;
    }

    // ==================== 功能1：卖家挂NFT卖（核心功能） ====================
    function listNFT(
        address nftAddress,
        uint256 tokenId,
        uint256 price,
        address royaltyReceiver,
        uint256 royaltyPercent
    ) external {
        // 挂单价格必须大于0
        require(price > 0, "Price must be above zero");
        // 版税最高10%（1000基点），保护买家
        require(royaltyPercent <= 1000, "Max 10% royalty allowed");
        // NFT不能已经挂单，防止重复挂单
        require(!listings[nftAddress][tokenId].isListed, "Already listed");

        // 实例化NFT合约，验证权限
        IERC721 nft = IERC721(nftAddress);
        // 调用者必须是NFT的所有者
        require(nft.ownerOf(tokenId) == msg.sender, "Not the owner");
        // 市场必须被授权操作这个NFT（卖家要先给市场授权）
        require(
            nft.getApproved(tokenId) == address(this) || nft.isApprovedForAll(msg.sender, address(this)),
            "Marketplace not approved"
        );

        // 把挂单信息存入链上
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

    // ==================== 功能2：买家买NFT（核心功能，防重入） ====================
    function buyNFT(address nftAddress, uint256 tokenId) external payable nonReentrant {
        // 获取挂单详情
        Listing memory item = listings[nftAddress][tokenId];
        // 必须是挂单状态才能购买
        require(item.isListed, "Not listed");
        // 买家付的钱必须等于挂单价格，防止少付钱
        require(msg.value == item.price, "Incorrect ETH sent");

        // 计算分账金额
        uint256 feeAmount = (msg.value * marketplaceFeePercent) / 10000; // 市场手续费：总价 × 手续费% / 10000
        uint256 royaltyAmount = (msg.value * item.royaltyPercent) / 10000; // 版税：总价 × 版税% / 10000
        uint256 sellerAmount = msg.value - feeAmount - royaltyAmount; // 卖家最终拿到的钱

        // 安全检查：版税+手续费总和不能超过100%
        require(
            item.royaltyPercent + marketplaceFeePercent <= 10000,
            "Combined fees exceed 100%"
        );

        // 1. 转市场手续费给手续费接收方（用call替代弃用的transfer，加require保证成功）
        if (feeAmount > 0) {
            (bool successFee, ) = payable(feeRecipient).call{value: feeAmount}("");
            require(successFee, "Failed to send fee to recipient");
        }

        // 2. 转版税给创作者（用call替代弃用的transfer，加require保证成功）
        if (royaltyAmount > 0 && item.royaltyReceiver != address(0)) {
            (bool successRoyalty, ) = payable(item.royaltyReceiver).call{value: royaltyAmount}("");
            require(successRoyalty, "Failed to send royalty to creator");
        }

        // 3. 转钱给卖家（用call替代弃用的transfer，加require保证成功）
        (bool successSeller, ) = payable(item.seller).call{value: sellerAmount}("");
        require(successSeller, "Failed to send ETH to seller");

        // 4. 把NFT从卖家安全转给买家（ERC721标准安全转账）
        IERC721(item.nftAddress).safeTransferFrom(item.seller, msg.sender, item.tokenId);

        // 5. 删除挂单，交易完成
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

    // ==================== 功能3：卖家取消挂单 ====================
    function cancelListing(address nftAddress, uint256 tokenId) external {
        // 获取挂单详情
        Listing memory item = listings[nftAddress][tokenId];
        // 必须是挂单状态才能取消
        require(item.isListed, "Not listed");
        // 只有卖家能取消自己的挂单
        require(item.seller == msg.sender, "Not the seller");

        // 删除挂单
        delete listings[nftAddress][tokenId];
        emit Unlisted(msg.sender, nftAddress, tokenId);
    }

    // ==================== 功能4：所有者更新市场手续费（最高10%） ====================
    function setMarketplaceFeePercent(uint256 _newFee) external onlyOwner {
        require(_newFee <= 1000, "Marketplace fee too high");
        marketplaceFeePercent = _newFee;
        emit FeeUpdated(_newFee, feeRecipient);
    }

    // ==================== 功能5：所有者更新手续费接收地址 ====================
    function setFeeRecipient(address _newRecipient) external onlyOwner {
        require(_newRecipient != address(0), "Invalid fee recipient");
        feeRecipient = _newRecipient;
        emit FeeUpdated(marketplaceFeePercent, _newRecipient);
    }

    // ==================== 功能6：查询挂单详情（外部查看用） ====================
    function getListing(address nftAddress, uint256 tokenId) external view returns (Listing memory) {
        return listings[nftAddress][tokenId];
    }

    // ==================== 禁止直接转账：防止乱打钱到合约 ====================
    receive() external payable {
        revert("Direct ETH not accepted");
    }

    // ==================== fallback：处理未知函数调用，防止误操作 ====================
    fallback() external payable {
        revert("Unknown function");
    }
}