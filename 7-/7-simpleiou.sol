// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

// Contract7：去中心化交易所（DEX）核心合约（匹配contract-7需求）
contract SimpleDEX {
    // ========== 核心状态变量 ==========
    address public tokenA; // 交易对代币A地址（示例：ERC20代币）
    address public tokenB; // 交易对代币B地址（示例：ETH/另一ERC20）
    uint256 public reserveA; // 代币A储备量
    uint256 public reserveB; // 代币B储备量
    address public owner;    // DEX管理员

    // 交易事件
    event LiquidityAdded(address indexed provider, uint256 amountA, uint256 amountB);
    event LiquidityRemoved(address indexed provider, uint256 amountA, uint256 amountB);
    event Swap(address indexed swapper, address indexed tokenIn, uint256 amountIn, uint256 amountOut);

    // 权限修饰器：仅管理员可初始化交易对
    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call");
        _;
    }

    // ========== 构造函数 ==========
    constructor(address _tokenA, address _tokenB) {
        require(_tokenA != address(0) && _tokenB != address(0), "Invalid token address");
        tokenA = _tokenA;
        tokenB = _tokenB;
        owner = msg.sender;
    }

    // ========== 核心功能1：添加流动性（DEX基础） ==========
    function addLiquidity(uint256 _amountA, uint256 _amountB) public returns (uint256 liquidity) {
        // 转账用户的代币A/B到合约（简化版：假设已授权合约转账）
        require(transferFrom(tokenA, msg.sender, address(this), _amountA), "TokenA transfer failed");
        require(transferFrom(tokenB, msg.sender, address(this), _amountB), "TokenB transfer failed");

        // 更新储备量
        reserveA += _amountA;
        reserveB += _amountB;

        // 计算流动性份额（简化版：按首次添加/后续比例计算）
        liquidity = (reserveA * reserveB) / 1e18; // 简化公式，核心逻辑不变

        emit LiquidityAdded(msg.sender, _amountA, _amountB);
        return liquidity;
    }

    // ========== 核心功能2：移除流动性 ==========
    function removeLiquidity(uint256 _liquidity) public returns (uint256 amountA, uint256 amountB) {
        // 计算可提取的代币数量
        amountA = (_liquidity * reserveA) / totalLiquidity();
        amountB = (_liquidity * reserveB) / totalLiquidity();

        require(amountA > 0 && amountB > 0, "Insufficient liquidity");

        // 更新储备量
        reserveA -= amountA;
        reserveB -= amountB;

        // 转账代币给用户
        require(transfer(tokenA, msg.sender, amountA), "TokenA transfer failed");
        require(transfer(tokenB, msg.sender, amountB), "TokenB transfer failed");

        emit LiquidityRemoved(msg.sender, amountA, amountB);
        return (amountA, amountB);
    }

    // ========== 核心功能3：代币兑换（核心交易逻辑） ==========
    function swap(address _tokenIn, uint256 _amountIn) public returns (uint256 amountOut) {
        require(_tokenIn == tokenA || _tokenIn == tokenB, "Invalid token");
        require(_amountIn > 0, "Amount in must be > 0");

        // 判断兑换方向：A→B 或 B→A
        bool isTokenAIn = _tokenIn == tokenA;
        (address tokenOut, uint256 reserveIn, uint256 reserveOut) = isTokenAIn 
            ? (tokenB, reserveA, reserveB) 
            : (tokenA, reserveB, reserveA);

        // 计算兑换输出量（恒定乘积公式：x*y=k）
        uint256 amountInWithFee = _amountIn * 997; // 0.3%手续费（DEX标准）
        amountOut = (amountInWithFee * reserveOut) / (reserveIn * 1000 + amountInWithFee);

        // 更新储备量
        if (isTokenAIn) {
            reserveA += _amountIn;
            reserveB -= amountOut;
        } else {
            reserveB += _amountIn;
            reserveA -= amountOut;
        }

        // 转账输入代币到合约，输出代币给用户
        require(transferFrom(_tokenIn, msg.sender, address(this), _amountIn), "Token in transfer failed");
        require(transfer(tokenOut, msg.sender, amountOut), "Token out transfer failed");

        emit Swap(msg.sender, _tokenIn, _amountIn, amountOut);
        return amountOut;
    }

    // ========== 辅助函数（简化版ERC20转账/授权） ==========
    function transfer(address _token, address _to, uint256 _amount) internal returns (bool) {
        (bool success, bytes memory data) = _token.call(
            abi.encodeWithSignature("transfer(address,uint256)", _to, _amount)
        );
        return success && (data.length == 0 || abi.decode(data, (bool)));
    }

    function transferFrom(address _token, address _from, address _to, uint256 _amount) internal returns (bool) {
        (bool success, bytes memory data) = _token.call(
            abi.encodeWithSignature("transferFrom(address,address,uint256)", _from, _to, _amount)
        );
        return success && (data.length == 0 || abi.decode(data, (bool)));
    }

    function totalLiquidity() internal view returns (uint256) {
        return (reserveA * reserveB) / 1e18; // 简化的总流动性计算
    }
}