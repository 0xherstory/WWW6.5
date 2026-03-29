// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";

/**
 * @title SimpleLending
 * @notice 简化版 DeFi 借贷协议
 * 核心功能：存款、借款、还款、清算
 */
contract SimpleLending is ReentrancyGuard {
    
    // ============ 数据结构 ============
    
    struct UserAccount {
        uint256 deposited;      // 用户存入的抵押品数量
        uint256 borrowed;       // 用户借出的资产数量
        uint256 borrowTime;     // 借款时间（用于计算利息）
    }
    
    struct AssetPool {
        IERC20 token;           // 资产合约地址
        uint256 totalDeposited; // 总存款量
        uint256 totalBorrowed;  // 总借款量
        uint256 borrowRate;     // 借款利率（年化，基点 10000 = 100%）
        uint256 collateralFactor; // 抵押率（最大可借比例，如 7500 = 75%）
        bool isActive;          // 是否激活
    }
    
    // ============ 状态变量 ============
    
    // 资产池: 资产符号 => 池子信息
    mapping(string => AssetPool) public pools;
    string[] public poolSymbols;
    
    // 用户账户: 用户地址 => 资产符号 => 账户信息
    mapping(address => mapping(string => UserAccount)) public accounts;
    
    // 价格预言机（简化版，实际应用使用 Chainlink）
    mapping(string => uint256) public assetPrices; // 价格，以 USD 为单位，8位小数
    
    // 清算参数
    uint256 public constant LIQUIDATION_THRESHOLD = 8000; // 80%，低于此比例可被清算
    uint256 public constant LIQUIDATION_BONUS = 500;      // 5% 清算奖励
    uint256 public constant PRICE_PRECISION = 1e8;
    uint256 public constant RATE_PRECISION = 10000;
    
    // ============ 事件 ============
    
    event Deposit(address indexed user, string symbol, uint256 amount);
    event Withdraw(address indexed user, string symbol, uint256 amount);
    event Borrow(address indexed user, string symbol, uint256 amount);
    event Repay(address indexed user, string symbol, uint256 amount);
    event Liquidate(
        address indexed liquidator,
        address indexed borrower,
        string symbol,
        uint256 repayAmount,
        uint256 seizeAmount
    );
    
    // ============ 修饰器 ============
    
    modifier poolExists(string memory symbol) {
        require(pools[symbol].isActive, "Pool not exist");
        _;
    }
    
    // ============ 管理员功能 ============
    
    /**
     * @notice 添加资产池
     */
    function addPool(
        string memory symbol,
        address token,
        uint256 borrowRate,
        uint256 collateralFactor
    ) external {
        require(!pools[symbol].isActive, "Pool already exists");
        require(collateralFactor <= 8000, "Collateral factor too high");
        
        pools[symbol] = AssetPool({
            token: IERC20(token),
            totalDeposited: 0,
            totalBorrowed: 0,
            borrowRate: borrowRate,
            collateralFactor: collateralFactor,
            isActive: true
        });
        
        poolSymbols.push(symbol);
    }
    
    /**
     * @notice 更新价格（实际应用中使用 Chainlink）
     */
    function updatePrice(string memory symbol, uint256 price) external {
        assetPrices[symbol] = price;
    }
    
    // ============ 核心功能 ============
    
    /**
     * @notice 存入抵押品
     */
    function deposit(string memory symbol, uint256 amount) 
        external 
        nonReentrant 
        poolExists(symbol) 
    {
        require(amount > 0, "Amount must be > 0");
        
        AssetPool storage pool = pools[symbol];
        UserAccount storage account = accounts[msg.sender][symbol];
        
        // 转账
        require(
            pool.token.transferFrom(msg.sender, address(this), amount),
            "Transfer failed"
        );
        
        // 更新状态
        account.deposited += amount;
        pool.totalDeposited += amount;
        
        emit Deposit(msg.sender, symbol, amount);
    }
    
    /**
     * @notice 提取存款
     */
    function withdraw(string memory symbol, uint256 amount) 
        external 
        nonReentrant 
        poolExists(symbol) 
    {
        UserAccount storage account = accounts[msg.sender][symbol];
        AssetPool storage pool = pools[symbol];
        
        require(amount > 0, "Amount must be > 0");
        require(account.deposited >= amount, "Insufficient deposit");
        
        // 检查提取后是否会导致清算
        account.deposited -= amount;
        require(!isLiquidatable(msg.sender), "Withdraw would liquidate");
        
        pool.totalDeposited -= amount;
        
        require(pool.token.transfer(msg.sender, amount), "Transfer failed");
        
        emit Withdraw(msg.sender, symbol, amount);
    }
    
    /**
     * @notice 借款
     */
    function borrow(string memory symbol, uint256 amount) 
        external 
        nonReentrant 
        poolExists(symbol) 
    {
        require(amount > 0, "Amount must be > 0");
        
        AssetPool storage pool = pools[symbol];
        UserAccount storage account = accounts[msg.sender][symbol];
        
        // 检查借款额度
        uint256 maxBorrow = getMaxBorrowAmount(msg.sender, symbol);
        uint256 newBorrow = account.borrowed + getInterest(msg.sender, symbol) + amount;
        
        require(newBorrow <= maxBorrow, "Insufficient collateral");
        require(newBorrow <= pool.totalDeposited - pool.totalBorrowed, "Insufficient liquidity");
        
        // 首次借款记录时间
        if (account.borrowed == 0) {
            account.borrowTime = block.timestamp;
        } else {
            // 累积利息到本金
            account.borrowed = newBorrow - amount;
            account.borrowTime = block.timestamp;
        }
        
        account.borrowed += amount;
        pool.totalBorrowed += amount;
        
        // 转账给用户
        require(pool.token.transfer(msg.sender, amount), "Transfer failed");
        
        emit Borrow(msg.sender, symbol, amount);
    }
    
    /**
     * @notice 还款
     */
    function repay(string memory symbol, uint256 amount) 
        external 
        nonReentrant 
        poolExists(symbol) 
    {
        UserAccount storage account = accounts[msg.sender][symbol];
        AssetPool storage pool = pools[symbol];
        
        uint256 totalDebt = account.borrowed + getInterest(msg.sender, symbol);
        require(totalDebt > 0, "No debt to repay");
        
        // 不能超过总债务
        if (amount > totalDebt) {
            amount = totalDebt;
        }
        
        // 转账还款
        require(pool.token.transferFrom(msg.sender, address(this), amount), "Transfer failed");
        
        // 更新债务
        account.borrowed = totalDebt - amount;
        account.borrowTime = block.timestamp;
        pool.totalBorrowed -= amount;
        
        emit Repay(msg.sender, symbol, amount);
    }
    
    /**
     * @notice 清算功能
     * @param borrower 被清算的借款人
     * @param symbol 资产符号
     * @param repayAmount 清算人帮还的金额
     */
    function liquidate(
        address borrower,
        string memory symbol,
        uint256 repayAmount
    ) external nonReentrant poolExists(symbol) {
        require(isLiquidatable(borrower), "Borrower not liquidatable");
        
        AssetPool storage pool = pools[symbol];
        UserAccount storage account = accounts[borrower][symbol];
        
        uint256 totalDebt = account.borrowed + getInterest(borrower, symbol);
        require(repayAmount <= totalDebt, "Repay amount exceeds debt");
        
        // 计算可获得的抵押品（包含奖励）
        // seizeAmount = repayAmount * (1 + liquidationBonus)
        uint256 seizeAmount = (repayAmount * (RATE_PRECISION + LIQUIDATION_BONUS)) / RATE_PRECISION;
        require(seizeAmount <= account.deposited, "Seize amount exceeds collateral");
        
        // 清算人还款
        require(
            pool.token.transferFrom(msg.sender, address(this), repayAmount),
            "Repay transfer failed"
        );
        
        // 更新账户
        account.borrowed = totalDebt - repayAmount;
        account.borrowTime = block.timestamp;
        account.deposited -= seizeAmount;
        pool.totalBorrowed -= repayAmount;
        pool.totalDeposited -= seizeAmount;
        
        // 转移抵押品给清算人
        require(pool.token.transfer(msg.sender, seizeAmount), "Seize transfer failed");
        
        emit Liquidate(msg.sender, borrower, symbol, repayAmount, seizeAmount);
    }
    
    // ============ 查询函数 ============
    
    /**
     * @notice 计算利息
     */
    function getInterest(address user, string memory symbol) 
        public 
        view 
        returns (uint256) 
    {
        UserAccount memory account = accounts[user][symbol];
        if (account.borrowed == 0 || account.borrowTime == 0) {
            return 0;
        }
        
        uint256 timeElapsed = block.timestamp - account.borrowTime;
        uint256 interest = (account.borrowed * pools[symbol].borrowRate * timeElapsed) 
            / (365 days) / RATE_PRECISION;
        
        return interest;
    }
    
    /**
     * @notice 获取最大可借金额
     */
    function getMaxBorrowAmount(address user, string memory symbol) 
        public 
        view 
        returns (uint256) 
    {
        // 简化版：只考虑同种资产的抵押
        // 实际协议会计算所有资产的交叉抵押
        
        UserAccount memory account = accounts[user][symbol];
        AssetPool memory pool = pools[symbol];
        
        // 抵押价值 * 抵押率
        uint256 collateralValue = account.deposited * pool.collateralFactor / RATE_PRECISION;
        
        return collateralValue;
    }
    
    /**
     * @notice 检查是否需要清算
     */
    function isLiquidatable(address user) public view returns (bool) {
        // 检查用户的所有资产池
        for (uint i = 0; i < poolSymbols.length; i++) {
            string memory symbol = poolSymbols[i];
            UserAccount memory account = accounts[user][symbol];
            
            if (account.borrowed == 0) continue;
            
            uint256 totalDebt = account.borrowed + getInterest(user, symbol);
            uint256 collateralValue = account.deposited;
            
            // 债务 / 抵押品 > 清算阈值
            if (totalDebt * RATE_PRECISION > collateralValue * LIQUIDATION_THRESHOLD) {
                return true;
            }
        }
        return false;
    }
    
    /**
     * @notice 获取账户健康因子（大于1表示健康）
     */
    function getHealthFactor(address user) external view returns (uint256) {
        uint256 totalCollateral = 0;
        uint256 totalDebt = 0;
        
        for (uint i = 0; i < poolSymbols.length; i++) {
            string memory symbol = poolSymbols[i];
            UserAccount memory account = accounts[user][symbol];
            
            totalCollateral += account.deposited * pools[symbol].collateralFactor / RATE_PRECISION;
            totalDebt += account.borrowed + getInterest(user, symbol);
        }
        
        if (totalDebt == 0) return type(uint256).max;
        
        return (totalCollateral * 1e18) / totalDebt;
    }
    
    /**
     * @notice 获取池子数量
     */
    function getPoolCount() external view returns (uint256) {
        return poolSymbols.length;
    }
}