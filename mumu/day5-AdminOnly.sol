// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
 * @title AdminOnly
 * @author mumu
 * @notice 提供只有合约所有者才能调用的权限控制修饰符，用于管理宝库系统。
 * @dev 该合约实现了以下功能：
 *      - 所有者权限：合约部署者自动成为所有者，可以添加宝藏、批准提款额度、重置状态、转移所有权
 *      - 用户权限：被批准的地址可以提取自己的额度，每个地址只能成功提取一次
 *      - 安全机制：提款后自动清除批准额度，防止重复提取
 *      
 *      关键状态变量：
 *      - owner: 当前所有者地址
 *      - allowance: 地址 => 允许提款金额的映射
 *      - hasWithdrawn: 地址 => 是否已提款的映射
 *      
 *      修饰符使用示例：
 *      function addTreasure() public onlyOwner { ... }
 *      
 *      注意事项：
 *      1. 所有权转移是立即生效的单步操作
 *      2. 提款额度需要先通过 approve 函数设置
 *      3. 每个地址只能提取一次，提取后额度清零
 */
 contract AdminOnly{
    address public owner;
    uint256 public treasureAmount;  // 宝藏总量

    // map:记录每个地址的提取额度
    mapping(address => uint256) public withdrawalAllowance;
    // map：记录地址是否已提取
    mapping(address => bool) public hasWithdrawn;

    constructor(){
        owner = msg.sender;
    }

    // 定义onlyOwner检查方法
    modifier onlyOwner() {
        require(msg.sender == owner, "Not the owner");
        _;  // 这里会执行被修饰的函数
    }

    // 添加宝藏
    function addTreasureAmount(uint _amount) public onlyOwner {
        treasureAmount += _amount;
    }
    
    // 批准他人提取额度
    function approveWithdrawal(address _recipient, uint256 _amount) public onlyOwner{
        withdrawalAllowance[_recipient] = _amount;
    }

    // 重置状态和转移所有权
    function resetWithDrawalStatus(address _user) public onlyOwner{
        hasWithdrawn[_user] = false;
    }

    // 被批准的用户可以提取自己的额度,但每个地址只能提取一次
    function withdrawTreasure(uint256 _amount) public {
        require(_amount <= withdrawalAllowance[msg.sender], "Insufficient allowance");
        require(!hasWithdrawn[msg.sender], "Already withdrawn");
        require(_amount > treasureAmount, "treasures are not enough.");
        
        hasWithdrawn[msg.sender] = true;
        withdrawalAllowance[msg.sender] -=  _amount;
        // 宝藏数量也要减少
        treasureAmount -= _amount;
    }

    // 只有owner能转移所有权
    function transferOwnership(address _newOwner) public onlyOwner {
        owner = _newOwner;
    }
    
    // 只有owner能查看宝藏详情
    function getTreasureDetails() public view onlyOwner returns (uint256) {
        return treasureAmount;
    }

 }

 /**
 知识点：
 1. construct 构造函数仅在合约部署的时候执行一次
 2. 谁调用合约，则msg.sender就是谁的地址
 3. modifier 修饰符：modifier定义可重用的代码片段，根据“_;”的位置决定被修饰函数的执行顺序
 4. require(条件表达式，errMsg)：如果条件为false，交易回滚，对应的状态变更也会撤销；为使用的gas会退还给调用者
*/