// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract AdminOnly {
    // === 状态变量 ===
    address public owner;
    uint256 public treasureAmount;
    mapping(address => uint256) public withdrawalAllowance;
    mapping(address => bool) public hasWithdrawn;

    // === 修饰器 ===
    modifier onlyOwner() {
        require(msg.sender == owner, "Access denied: Only the owner can perform this action");
        _;
    }

    // === 初始化 (构造函数) ===
    constructor() {
        owner = msg.sender;
    }

    // === 管理员功能 ===
    
    // 添加宝藏金额
    function addTreasure(uint256 amount) public onlyOwner {
        treasureAmount += amount;
    }

    // 批准用户提取
    function approveWithdrawal(address recipient, uint256 amount) public onlyOwner {
        require(amount <= treasureAmount, "Not enough treasure available");
        withdrawalAllowance[recipient] = amount;
    }

    // 重置用户提取状态
    function resetWithdrawalStatus(address user) public onlyOwner {
        hasWithdrawn[user] = false;
    }

    // 转移合约所有权
    function transferOwnership(address newOwner) public onlyOwner {
        require(newOwner != address(0), "Invalid address");
        owner = newOwner;
    }

    // 查看宝藏详情
    function getTreasureDetails() public view onlyOwner returns (uint256) {
        return treasureAmount;
    }

    // === 用户功能 ===

    // 提取宝藏
    function withdrawTreasure(uint256 amount) public {
        // 逻辑分支：检查身份
        if (msg.sender == owner) {
            // 直接提取
            require(amount <= treasureAmount, "Not enough treasury available");
            treasureAmount -= amount;
        } else {
            // 普通用户：验证提取条件
            require(withdrawalAllowance[msg.sender] > 0, "You don't have any treasure allowance");
            require(!hasWithdrawn[msg.sender], "You have already withdrawn your treasure");
            require(amount <= treasureAmount, "Not enough treasure in the chest");
            require(amount <= withdrawalAllowance[msg.sender], "Cannot withdraw more than you are allowed");

            // 执行提取并更新状态
            hasWithdrawn[msg.sender] = true;
            treasureAmount -= amount;
        }
    }
}
