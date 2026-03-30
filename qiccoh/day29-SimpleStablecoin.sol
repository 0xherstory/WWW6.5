// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";//供了所有标准代币功能
import "@openzeppelin/contracts/access/Ownable.sol";//只由合约所有者更改
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";//保护函数免受攻击
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";//SafeERC20 是处理其他 ERC-20 代币的安全网
import "@openzeppelin/contracts/access/AccessControl.sol";//允许合约定义自定义角色
import "@openzeppelin/contracts/interfaces/IERC20Metadata.sol";//取关于抵押代币的额外信息
import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";//看到抵押代币的真实世界价格


/**
- **ERC20**——这为我们的稳定币提供了所有基本的代币行为，如转账代币、批准支出者和检查余额。
- **Ownable**——添加一个简单的所有权模型，所以我们可以控制谁有权执行敏感操作，如更新系统设置。
- **ReentrancyGuard**——保护关键函数免受重入攻击，使铸造和赎回等操作更加安全。
- **AccessControl**——允许我们定义自定义角色（如价格源管理器），并精细控制谁可以调用某些函数。
**/

contract SimpleStablecoin is ERC20, Ownable, ReentrancyGuard, AccessControl {
    
    using SafeERC20 for IERC20;//我们与之交互的所有 IERC20 代币激活 SafeERC20

    bytes32 public constant PRICE_FEED_MANAGER_ROLE = keccak256("PRICE_FEED_MANAGER_ROLE");//它控制谁可以更新价格源
    IERC20 public immutable collateralToken;//用户必须作为抵押品存入的 ERC-20 代币的地址
    uint8 public immutable collateralDecimals;//不同的 ERC-20 代币可以有不同数量的小数
    AggregatorV3Interface public priceFeed;// Chainlink 价格源 合约
    uint256 public collateralizationRatio = 150; // 以百分比表示（150 = 150%）
//铸造新稳定币时，就会触发此事件
    event Minted(address indexed user, uint256 amount, uint256 collateralDeposited);
    // 将稳定币赎回为抵押品时
    event Redeemed(address indexed user, uint256 amount, uint256 collateralReturned);
    // 价格源地址已更新
    event PriceFeedUpdated(address newPriceFeed);
    // 抵押率被更改
    event CollateralizationRatioUpdated(uint256 newRatio);
// 自定义错误
    error InvalidCollateralTokenAddress();//如果有人试图用无效（零）抵押代币地址部署合约，就会抛出此错误
    error InvalidPriceFeedAddress();//提供的价格源地址无效
    error MintAmountIsZero();//用户试图铸造零稳定币
    error InsufficientStablecoinBalance();//用户试图赎回比他们实际余额更多的稳定币
    error CollateralizationRatioTooLow();//试图将抵押率设置为低于 100%

    constructor(
        /**
        - **抵押代币**的地址（像 USDC、WETH 等 ERC-20）
        - **初始所有者**的地址（管理员）
        - **Chainlink 价格源**的地址（获取实时抵押品价格
        **/
        address _collateralToken,
        address _initialOwner,
        address _priceFeed
    ) ERC20("Simple USD Stablecoin", "sUSD") Ownable(_initialOwner) {
        // 调用 OpenZeppelin 的 ERC-20 构造函数——
        // 给我们的代币一个**名称**（"Simple USD Stablecoin"）和一个**符号**（"sUSD"）
        if (_collateralToken == address(0)) revert InvalidCollateralTokenAddress();
        if (_priceFeed == address(0)) revert InvalidPriceFeedAddress();

        collateralToken = IERC20(_collateralToken);//保存抵押代币的地址
        collateralDecimals = IERC20Metadata(_collateralToken).decimals();//获取并存储抵押代币的小数
        priceFeed = AggregatorV3Interface(_priceFeed);

        _grantRole(DEFAULT_ADMIN_ROLE, _initialOwner);
        _grantRole(PRICE_FEED_MANAGER_ROLE, _initialOwner);
/**
- **DEFAULT_ADMIN_ROLE**——让所有者完全控制合约的角色系统
- **PRICE_FEED_MANAGER_ROLE**——让所有者在将来需要时更新价格源
**/

    }
// 公共视图函数——任何人都可以调用它来获取最新价格，并且它不会改变任何状态
    function getCurrentPrice() public view returns (uint256) {
        (, int256 price, , , ) = priceFeed.latestRoundData();
        require(price > 0, "Invalid price feed response");
        return uint256(price);
    }

// 铸造稳定币
    function mint(uint256 amount) external nonReentrant {
        if (amount == 0) revert MintAmountIsZero();

        uint256 collateralPrice = getCurrentPrice();
        uint256 requiredCollateralValueUSD = amount * (10 ** decimals()); // 假设 sUSD 为 18 位小数
        uint256 requiredCollateral = (requiredCollateralValueUSD * collateralizationRatio) / (100 * collateralPrice);
        uint256 adjustedRequiredCollateral = (requiredCollateral * (10 ** collateralDecimals)) / (10 ** priceFeed.decimals());

        collateralToken.safeTransferFrom(msg.sender, address(this), adjustedRequiredCollateral);
        _mint(msg.sender, amount);

        emit Minted(msg.sender, amount, adjustedRequiredCollateral);
    }
// 赎回稳定币
    function redeem(uint256 amount) external nonReentrant {
        if (amount == 0) revert MintAmountIsZero();
        if (balanceOf(msg.sender) < amount) revert InsufficientStablecoinBalance();

        uint256 collateralPrice = getCurrentPrice();
        uint256 stablecoinValueUSD = amount * (10 ** decimals());
        uint256 collateralToReturn = (stablecoinValueUSD * 100) / (collateralizationRatio * collateralPrice);
        uint256 adjustedCollateralToReturn = (collateralToReturn * (10 ** collateralDecimals)) / (10 ** priceFeed.decimals());

        _burn(msg.sender, amount);
        collateralToken.safeTransfer(msg.sender, adjustedCollateralToReturn);

        emit Redeemed(msg.sender, amount, adjustedCollateralToReturn);
    }
// 更新抵押率
    function setCollateralizationRatio(uint256 newRatio) external onlyOwner {
        if (newRatio < 100) revert CollateralizationRatioTooLow();
        collateralizationRatio = newRatio;
        emit CollateralizationRatioUpdated(newRatio);
    }

    function setPriceFeedContract(address _newPriceFeed) external onlyRole(PRICE_FEED_MANAGER_ROLE) {
        if (_newPriceFeed == address(0)) revert InvalidPriceFeedAddress();
        priceFeed = AggregatorV3Interface(_newPriceFeed);
        emit PriceFeedUpdated(_newPriceFeed);
    }
//预览所需抵押品
    function getRequiredCollateralForMint(uint256 amount) public view returns (uint256) {
        if (amount == 0) return 0;

        uint256 collateralPrice = getCurrentPrice();
        uint256 requiredCollateralValueUSD = amount * (10 ** decimals());
        uint256 requiredCollateral = (requiredCollateralValueUSD * collateralizationRatio) / (100 * collateralPrice);
        uint256 adjustedRequiredCollateral = (requiredCollateral * (10 ** collateralDecimals)) / (10 ** priceFeed.decimals());

        return adjustedRequiredCollateral;
    }
//预览赎回时返回的抵押品
    function getCollateralForRedeem(uint256 amount) public view returns (uint256) {
        if (amount == 0) return 0;

        uint256 collateralPrice = getCurrentPrice();
        uint256 stablecoinValueUSD = amount * (10 ** decimals());
        uint256 collateralToReturn = (stablecoinValueUSD * 100) / (collateralizationRatio * collateralPrice);
        uint256 adjustedCollateralToReturn = (collateralToReturn * (10 ** collateralDecimals)) / (10 ** priceFeed.decimals());

        return adjustedCollateralToReturn;
    }

}

