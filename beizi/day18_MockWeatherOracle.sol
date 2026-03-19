//模拟 Chainlink 风格的预言机，随机生成降雨值
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";
// 这个文件就是一套“标准沟通协议”。只要你的合约遵守这个协议，就能轻松地从 Chainlink 获取各种现实世界的数据，而不需要为每一种数据都写一套全新的对接代码
import "@openzeppelin/contracts/access/Ownable.sol";
//Ownable.sol 就像是给合约装上了一把管理员锁。它让开发者可以非常方便地定义“谁是老大”，并确保只有老大才能执行特定的指令


contract MockWeatherOracle is AggregatorV3Interface, Ownable {
    uint8 private _decimals;//定义数据的精度
    string private _description;//一个“自我介绍”，告诉任何查看该合约的人或程序这个预言机到底在提供什么信息
    uint80 private _roundId;//用于模拟不同的数据更新周期
    uint256 private _timestamp;//记录上次更新发生的时间
    uint256 private _lastUpdateBlock;//记录下天气数据最后一次更新是在哪一个区块

    constructor() Ownable(msg.sender) {
        _decimals = 0; // 降雨不需要小数
        _description = "MOCK/RAINFALL/USD";//只是一个可读的标签
        _roundId = 1;//从第 1 轮开始
        _timestamp = block.timestamp;//它记录了天气数据（如降雨量）最后一次更新的具体时间
        _lastUpdateBlock = block.number;//它记录了数据是在哪一个区块被更新的
    }
//告诉外面的人，这个预言机提供的数据有多少位小数
    function decimals() external view override returns (uint8) {
        return _decimals;
    }//decimals()：函数的名字，意为“小数位数；override：接口（Interface）”想象成一张填空题试卷，override 就像是你在横线上写下答案的过程

//模拟天气预言机（Mock Weather Oracle）向外界返回这个数据源的“名字”或“人类可读的描述
    function description() external view override returns (string memory) {
        return _description;
    }

//真实的 Chainlink 价格喂价或数据源合约都有一套标准的接口函数（如 decimals、description 和 version）。为了让我们写的“假”预言机能像“真”的 Chainlink 预言机一样工作，必须包含这些函数
    function version() external pure override returns (uint256) {
        return 1;
    }//version()：函数名，意为“版本”

//回溯查询
    function getRoundData(uint80 _roundId_)//roundId 代表预言机数据的更新轮次 ID，每一轮新的数据读取（比如新的一次降雨量记录）都会被分配一个唯一的、递增的 ID
        external
        view
        override  //int256 answer（答案/数值）： 这是预言机返回的核心数据结果
                  //uint80 answeredInRound（完成轮次）： 指答案实际被计算出来的轮次 ID
        returns (uint80 roundId, int256 answer, uint256 startedAt, uint256 updatedAt, uint80 answeredInRound)
    {
        return (_roundId_, _rainfall(), _timestamp, _timestamp, _roundId_);
    }
//_rainfall() 就是一个 “随机数生成器”。它的存在是为了让模拟预言机能够产生不断变化的降雨数据，从而让开发者在没有连接真实 Chainlink 数据源的情况下，也能测试保险合约的自动化理赔功能
    
    //应用程序使用它来获取最新数据
    function latestRoundData()
        external
        view
        override
        returns (uint80 roundId, int256 answer, uint256 startedAt, uint256 updatedAt, uint80 answeredInRound)
    {
        return (_roundId, _rainfall(), _timestamp, _timestamp, _roundId);
    }

    // 模拟降雨发生器
    
    function _rainfall() public view returns (int256) {
        
        uint256 blocksSinceLastUpdate = block.number - _lastUpdateBlock;
        //blocksSinceLastUpdate：自上次更新以来的区块数”，它的作用是暂时存储计算出来的差值
        //block.number：这是一个 Solidity 的全局变量，代表当前区块的编号
        //_lastUpdateBlock：它记录了天气数据上一次被更新时的区块编号
        uint256 randomFactor = uint256(keccak256(abi.encodePacked(
            //randomFactor：这是开发者定义的变量名称，意为“随机因子”，存储这一系列复杂运算后得出的最终数值。
            //keccak256(...)：这是以太坊内置的一个加密哈希函数，在区块链上，它常被用来生成伪随机数
            //abi.encodePacked(...)它的作用像是一个“打包机”，把括号里的多个变量紧密地连接在一起，变成一段连续的二进制数据，以便交给 keccak256 进行哈希运算
            //这整行代码的作用是：把几个不断变化的区块链数据打包（abi.encodePacked），投进碎纸机（keccak256）搅碎成一串乱码，最后再把乱码翻译成数字（uint256）
            block.timestamp,
            block.coinbase,////block.coinbase — 矿工地址
            blocksSinceLastUpdate
        ))) % 1000; 

        // Return random rainfall between 0 and 999mm
        return int256(randomFactor);
    }

    // 增加轮数和记录新数据的创建时间
    function _updateRandomRainfall() private {
        _roundId++;
        _timestamp = block.timestamp;
        _lastUpdateBlock = block.number;//天气数据最后一次被更新时的“区块号”  block.number：代表当前区块的编号
    }
    // Function to force update rainfall (anyone can call)
    function updateRandomRainfall() external {
        _updateRandomRainfall();
    }

}
