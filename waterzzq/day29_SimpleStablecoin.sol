// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// 导入OpenZeppelin的母合约：
// 1. ERC20：稳定币本身是ERC20代币（母合约，标准ERC20）
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
// 2. Ownable：权限控制（母合约，只有所有者能操作）
import "@openzeppelin/contracts/access/Ownable.sol";
// 3. ReentrancyGuard：重入防护（母合约，防重入攻击，安全核心）
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
// 4. AccessControl：权限控制（母合约，分角色）
import "@openzeppelin/contracts/access/AccessControl.sol";
// 5. SafeERC20：安全ERC20转账（母合约，防溢出、防重入）
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
// 6. IERC20Metadata：获取ERC20元数据（小数位，母合约）
import "@openzeppelin/contracts/token/ERC20/extensions/IERC20Metadata.sol";
// 7. Chainlink AggregatorV3Interface：价格喂价接口（母合约，获取实时价格）
import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

/// @title SimpleStablecoin - 抵押型稳定币（类似DAI/sUSD，带Chainlink喂价、抵押率、重入防护）
contract SimpleStablecoin is ERC20, Ownable, ReentrancyGuard, AccessControl {
    using SafeERC20 for IERC20; // 使用SafeERC20进行安全转账，防溢出

    // ==================== 角色定义：权限控制（AccessControl母合约） ====================
    bytes32 public constant PRICE_FEED_MANAGER_ROLE = keccak256("PRICE_FEED_MANAGER_ROLE");

    // ==================== 状态变量：存储稳定币核心数据 ====================
    IERC20 public immutable collateralToken;    // 抵押品代币（比如WETH，不可改）
    uint8 public immutable collateralDecimals;  // 抵押品代币的小数位数（自动获取，不可改）
    AggregatorV3Interface public priceFeed;     // Chainlink价格喂价合约

    uint256 public collateralizationRatio = 150; // 抵押率（百分比，150 = 150%，最低100%）

    // ==================== 事件：记录所有操作，链上可查、透明 ====================
    event Minted(address indexed user, uint256 amount, uint256 collateralDeposited); // 铸造成功
    event Redeemed(address indexed user, uint256 amount, uint256 collateralReturned); // 赎回成功
    event PriceFeedUpdated(address newPriceFeed); // 价格喂价更新
    event CollateralizationRatioUpdated(uint256 newRatio); // 抵押率更新

    // ==================== 自定义错误：更省gas，清晰提示 ====================
    error InvalidCollateralTokenAddress();
    error InvalidPriceFeedAddress();
    error MintAmountIsZero();
    error InsufficientStablecoinBalance();
    error CollateralizationRatioTooLow();

    // ==================== 构造函数：部署合约时初始化 ====================
    constructor(
        address _collateralToken,    // 抵押品代币合约地址
        address _initialOwner,       // 初始所有者（管理员）
        address _priceFeed           // Chainlink价格喂价合约地址
    ) ERC20("Simple USD Stablecoin", "sUSD") Ownable(_initialOwner) {
        // 校验参数：地址不能为零
        require(_collateralToken != address(0), InvalidCollateralTokenAddress());
        require(_priceFeed != address(0), InvalidPriceFeedAddress());

        // 初始化抵押品、喂价
        collateralToken = IERC20(_collateralToken);
        // 自动获取抵押品小数位，兼容不同ERC20
        collateralDecimals = IERC20Metadata(_collateralToken).decimals();
        priceFeed = AggregatorV3Interface(_priceFeed);

        // 给初始所有者授予管理员、价格喂价管理员角色
        _grantRole(DEFAULT_ADMIN_ROLE, _initialOwner);
        _grantRole(PRICE_FEED_MANAGER_ROLE, _initialOwner);
    }

    // ==================== 功能1：用户铸造稳定币（核心功能，防重入） ====================
    function mint(uint256 amount) external nonReentrant {
        require(amount > 0, MintAmountIsZero()); // 铸造数量必须>0

        // 1. 获取当前抵押品价格（Chainlink喂价）
        uint256 collateralPrice = getCurrentPrice();
        // 2. 计算稳定币对应的美元价值（sUSD为18位小数，1 sUSD = 1e18 wei）
        uint256 requiredCollateralValueUSD = amount * (10 ** decimals());
        // 3. 计算需要的抵押品：稳定币价值 × 抵押率 / (100 × 抵押品价格)
        uint256 requiredCollateral = (requiredCollateralValueUSD * collateralizationRatio) / (100 * collateralPrice);
        // 4. 精度适配：抵押品小数位、喂价小数位
        uint256 adjustedRequiredCollateral = (requiredCollateral * (10 ** collateralDecimals)) / (10 ** priceFeed.decimals());

        // 把用户的抵押品转到合约（SafeERC20安全转账）
        collateralToken.safeTransferFrom(msg.sender, address(this), adjustedRequiredCollateral);
        // 给用户铸造稳定币（母合约ERC20的_mint）
        _mint(msg.sender, amount);

        emit Minted(msg.sender, amount, adjustedRequiredCollateral);
    }

    // ==================== 功能2：用户赎回抵押品，销毁稳定币（核心功能，防重入） ====================
    function redeem(uint256 amount) external nonReentrant {
        require(amount > 0, MintAmountIsZero()); // 赎回数量必须>0
        require(balanceOf(msg.sender) >= amount, InsufficientStablecoinBalance()); // 稳定币余额足够

        // 1. 获取当前抵押品价格
        uint256 collateralPrice = getCurrentPrice();
        // 2. 计算稳定币对应的美元价值
        uint256 stablecoinValueUSD = amount * (10 ** decimals());
        // 3. 计算能拿回的抵押品：稳定币价值 × 100 / (抵押率 × 抵押品价格)
        uint256 collateralToReturn = (stablecoinValueUSD * 100) / (collateralizationRatio * collateralPrice);
        // 4. 精度适配
        uint256 adjustedCollateralToReturn = (collateralToReturn * (10 ** collateralDecimals)) / (10 ** priceFeed.decimals());

        // 销毁用户的稳定币（母合约ERC20的_burn）
        _burn(msg.sender, amount);

        // ✅ 用call替代弃用的transfer，加require保证成功（零警告）
        (bool success, ) = payable(msg.sender).call{value: adjustedCollateralToReturn}("");
        require(success, "Failed to return collateral to user");

        emit Redeemed(msg.sender, amount, adjustedCollateralToReturn);
    }

    // ==================== 功能3：管理员更新抵押率（最低100%） ====================
    function setCollateralizationRatio(uint256 newRatio) external onlyOwner {
        if (newRatio < 100) revert CollateralizationRatioTooLow(); // 抵押率最低100%
        collateralizationRatio = newRatio;
        emit CollateralizationRatioUpdated(newRatio);
    }

    // ==================== 功能4：价格喂价管理员更新喂价地址 ====================
    function setPriceFeedContract(address _newPriceFeed) external onlyRole(PRICE_FEED_MANAGER_ROLE) {
        require(_newPriceFeed != address(0), InvalidPriceFeedAddress());
        priceFeed = AggregatorV3Interface(_newPriceFeed);
        emit PriceFeedUpdated(_newPriceFeed);
    }

    // ==================== 功能5：查询铸造指定数量需要的抵押品 ====================
    function getRequiredCollateralForMint(uint256 amount) public view returns (uint256) {
        if (amount == 0) return 0;

        uint256 collateralPrice = getCurrentPrice();
        uint256 requiredCollateralValueUSD = amount * (10 ** decimals());
        uint256 requiredCollateral = (requiredCollateralValueUSD * collateralizationRatio) / (100 * collateralPrice);
        uint256 adjustedRequiredCollateral = (requiredCollateral * (10 ** collateralDecimals)) / (10 ** priceFeed.decimals());

        return adjustedRequiredCollateral;
    }

    // ==================== 功能6：查询赎回指定数量能拿回的抵押品 ====================
    function getCollateralForRedeem(uint256 amount) public view returns (uint256) {
        if (amount == 0) return 0;

        uint256 collateralPrice = getCurrentPrice();
        uint256 stablecoinValueUSD = amount * (10 ** decimals());
        uint256 collateralToReturn = (stablecoinValueUSD * 100) / (collateralizationRatio * collateralPrice);
        uint256 adjustedCollateralToReturn = (collateralToReturn * (10 ** collateralDecimals)) / (10 ** priceFeed.decimals());

        return adjustedCollateralToReturn;
    }

    // ==================== 内部函数：获取当前抵押品价格（Chainlink喂价） ====================
    function getCurrentPrice() public view returns (uint256) {
        (, int256 price, , , ) = priceFeed.latestRoundData();
        require(price > 0, "Invalid price feed response"); // 价格必须>0
        return uint256(price);
    }

    // ==================== 功能7：查询抵押品小数位数 ====================
    function getCollateralDecimals() external view returns (uint8) {
        return collateralDecimals;
    }
}