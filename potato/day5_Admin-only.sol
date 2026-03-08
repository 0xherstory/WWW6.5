// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract AdminOnly {
    address public owner; 
    uint256 public treasureAmount; 
    
    mapping(address => uint256) public withdrawalAllowance;
    mapping(address => bool) public hasWithdrawn;
    
    constructor() {
        // 1. 谁部署合约，谁就是初始管理员（获取当前调用者地址）
        owner = msg.sender;
    }
    
    // 2. 声明一个修饰符 (关键字是什么？)
    modifier  onlyOwner() {
        require(msg.sender == owner, "Not the owner");
        // 3. 填入特殊符号：它代表“安检通过，回到原函数继续执行剩下的代码”
        _;
    }
    
    // 4. 挂载修饰符：限制只有管理员能添加宝藏
    function addTreasure(uint256 amount) public onlyOwner {
        treasureAmount += amount;
    }
    
    function approveWithdrawal(address recipient, uint256 amount) public onlyOwner {
        // 5. 更新映射：将参数 recipient 对应的允许额度设置为 amount
        withdrawalAllowance[recipient] = amount;
    }
    
    function withdrawTreasure(uint256 amount) public {
        // 6. 权限检查：确保“当前来提款的人”申请的金额，小于等于他的额度
        require(amount <= withdrawalAllowance[msg.sender], "Insufficient allowance");
        require(!hasWithdrawn[msg.sender], "Already withdrawn");
        
        hasWithdrawn[msg.sender] = true;
        withdrawalAllowance[msg.sender] -= amount;
    }

    // 只有owner能重置提取状态
    function resetWithdrawalStatus(address user) public onlyOwner {
        hasWithdrawn[user] = false;
    }
    
    // 只有owner能转移所有权
    function transferOwnership(address newOwner) public onlyOwner {
        owner = newOwner;
    }

    // 只有owner能查看宝藏详情
    function getTreasureDetails() public view onlyOwner returns (uint256) {
        return treasureAmount;
    }

    // 目标：编写一个名为 revokeWithdrawal 的函数（撤销某个人的提取资格）
    // 指南：
    // a. 函数可见性应设为 public。
    // b. 必须挂载修饰符，确保只有管理员能调用它。
    // c. 需要接收一个参数：被撤销人的地址 (比如叫 address user)。
    // d. 在函数体内，将该 user 的提取额度 (withdrawalAllowance) 清零。
    // e. 在函数体内，将该 user 的已提取状态 (hasWithdrawn) 设为 true (让他永远无法满足提取条件)。
    
    function revokeWithdrawal(address recipient) public onlyOwner {
        withdrawalAllowance[recipient] = 0;
        hasWithdrawn[recipient] = true;
    }
}