// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// ERC20接口（用来转账）
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v4.9.0/contracts/security/ReentrancyGuard.sol";

// 👉 交易对合约（核心池子）
contract MiniDexPair is ReentrancyGuard {

    // 两种交易代币（比如 ETH / USDC）
    address public immutable tokenA;
    address public immutable tokenB;
    
    // 当前池子里的余额（储备）
    uint256 public reserveA;
    uint256 public reserveB;
    
    // LP代币总量（流动性凭证）
    uint256 public totalLPSupply;
    
    // 每个人的LP余额
    mapping(address => uint256) public lpBalances;
    
    // ===== 事件 =====
    event LiquidityAdded(address indexed provider, uint256 amountA, uint256 amountB, uint256 lpMinted);
    event LiquidityRemoved(address indexed provider, uint256 amountA, uint256 amountB, uint256 lpBurned);
    event Swapped(address indexed user, address inputToken, uint256 inputAmount, address outputToken, uint256 outputAmount);
    
    // ===== 构造函数 =====
    constructor(address _tokenA, address _tokenB) {
        require(_tokenA != _tokenB, "Identical tokens"); // 不能是同一个币
        require(_tokenA != address(0) && _tokenB != address(0), "Zero address"); // 不能是空地址
        
        tokenA = _tokenA;
        tokenB = _tokenB;
    }
    
    // ===== 添加流动性（存钱进池子）=====
    function addLiquidity(uint256 amountA, uint256 amountB) external nonReentrant {
        
        require(amountA > 0 && amountB > 0, "Invalid amounts");
        
        // 把用户的钱转进池子
        IERC20(tokenA).transferFrom(msg.sender, address(this), amountA);
        IERC20(tokenB).transferFrom(msg.sender, address(this), amountB);
        
        uint256 lpToMint;
        
        // 🧠 第一次添加流动性
        if (totalLPSupply == 0) {
            // 开平方（Uniswap逻辑）
            lpToMint = sqrt(amountA * amountB);
        } else {
            // 按比例计算LP
            lpToMint = min(
                (amountA * totalLPSupply) / reserveA,
                (amountB * totalLPSupply) / reserveB
            );
        }
        
        require(lpToMint > 0, "Zero LP minted");
        
        // 记录LP
        lpBalances[msg.sender] += lpToMint;
        totalLPSupply += lpToMint;
        
        // 更新池子余额
        _updateReserves();
        
        emit LiquidityAdded(msg.sender, amountA, amountB, lpToMint);
    }
    
    // ===== 移除流动性（取回钱）=====
    function removeLiquidity(uint256 lpAmount) external nonReentrant {
        
        require(lpAmount > 0 && lpAmount <= lpBalances[msg.sender], "Invalid LP amount");
        
        // 按比例计算能拿回多少
        uint256 amountA = (lpAmount * reserveA) / totalLPSupply;
        uint256 amountB = (lpAmount * reserveB) / totalLPSupply;
        
        // 销毁LP
        lpBalances[msg.sender] -= lpAmount;
        totalLPSupply -= lpAmount;
        
        // 把钱还给用户
        IERC20(tokenA).transfer(msg.sender, amountA);
        IERC20(tokenB).transfer(msg.sender, amountB);
        
        _updateReserves();
        
        emit LiquidityRemoved(msg.sender, amountA, amountB, lpAmount);
    }
    
    // ===== 交换（核心功能🔥）=====
    function swap(uint256 inputAmount, address inputToken) external nonReentrant {
        
        require(inputAmount > 0, "Zero input");
        require(inputToken == tokenA || inputToken == tokenB, "Invalid token");
        
        // 判断输出币种
        address outputToken = inputToken == tokenA ? tokenB : tokenA;
        
        // 计算能换多少
        uint256 outputAmount = getAmountOut(inputAmount, inputToken);
        
        require(outputAmount > 0, "Insufficient output");
        
        // 用户给钱
        IERC20(inputToken).transferFrom(msg.sender, address(this), inputAmount);
        
        // 合约给用户币
        IERC20(outputToken).transfer(msg.sender, outputAmount);
        
        _updateReserves();
        
        emit Swapped(msg.sender, inputToken, inputAmount, outputToken, outputAmount);
    }
    
    // ===== 计算兑换数量（核心数学🔥）=====
    function getAmountOut(uint256 inputAmount, address inputToken) public view returns (uint256 outputAmount) {
        
        require(inputToken == tokenA || inputToken == tokenB, "Invalid input token");
        
        bool isTokenA = inputToken == tokenA;
        
        // 获取储备
        (uint256 inputReserve, uint256 outputReserve) = 
            isTokenA ? (reserveA, reserveB) : (reserveB, reserveA);
        
        // 手续费（0.3%）
        uint256 inputWithFee = inputAmount * 997;
        
        // AMM公式
        uint256 numerator = inputWithFee * outputReserve;
        uint256 denominator = (inputReserve * 1000) + inputWithFee;
        
        outputAmount = numerator / denominator;
    }
    
    // ===== 更新池子余额 =====
    function _updateReserves() private {
        reserveA = IERC20(tokenA).balanceOf(address(this));
        reserveB = IERC20(tokenB).balanceOf(address(this));
    }
    
    // 开平方（数学工具）
    function sqrt(uint y) internal pure returns (uint z) {
        if (y > 3) {
            z = y;
            uint x = y / 2 + 1;
            while (x < z) {
                z = x;
                x = (y / x + x) / 2;
            }
        } else if (y != 0) {
            z = 1;
        }
    }
    
    // 取最小值
    function min(uint256 a, uint256 b) internal pure returns (uint256) {
        return a < b ? a : b;
    }
}
