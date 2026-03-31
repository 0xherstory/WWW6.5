// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// ✅ 权限控制（管理员）
import "https://raw.githubusercontent.com/OpenZeppelin/openzeppelin-contracts/v4.9.0/contracts/access/Ownable.sol";

// ✅ 引入你自己的交易对合约（注意文件名要一致）
import "./Day30-MiniDexPair.sol";

// 👉 工厂合约（负责创建交易对）
contract MiniDexFactory is Ownable {

    // ===== 事件 =====
    // 每创建一个交易对就记录
    event PairCreated(
        address indexed tokenA,   // 代币A
        address indexed tokenB,   // 代币B
        address pairAddress,      // 交易对地址
        uint index                // 在数组中的位置
    );
    
    // ===== 存储结构 =====
    
    // 👉 查找交易对
    // tokenA + tokenB → pair地址
    mapping(address => mapping(address => address)) public getPair;
    
    // 👉 所有交易对列表
    address[] public allPairs;
    
    // ===== 构造函数 =====
    // 设置管理员（一般就是你自己）
    constructor(address _owner)  {}
    
    // ===== 创建交易对（核心功能🔥）=====
    function createPair(address _tokenA, address _tokenB)
        external
        onlyOwner   // 只有管理员可以创建
        returns (address pair)
    {
        // ❗检查地址是否合法
        require(_tokenA != address(0) && _tokenB != address(0), "Invalid token address");
        
        // ❗不能是同一个代币
        require(_tokenA != _tokenB, "Identical tokens");
        
        // ❗不能重复创建
        require(getPair[_tokenA][_tokenB] == address(0), "Pair already exists");
        
        // ===== 排序（非常重要）=====
        // 👉 防止 (A,B) 和 (B,A) 被当成两个池子
        (address token0, address token1) =
            _tokenA < _tokenB ? (_tokenA, _tokenB) : (_tokenB, _tokenA);
        
        // ===== 创建交易对合约 =====
        pair = address(new MiniDexPair(token0, token1));
        
        // ===== 记录映射（双向）=====
        getPair[token0][token1] = pair;
        getPair[token1][token0] = pair;
        
        // ===== 加入列表 =====
        allPairs.push(pair);
        
        // ===== 触发事件 =====
        emit PairCreated(token0, token1, pair, allPairs.length - 1);
    }
    
    // ===== 获取交易对数量 =====
    function allPairsLength() external view returns (uint) {
        return allPairs.length;
    }
}
