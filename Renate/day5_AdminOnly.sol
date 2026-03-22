// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract AdminOnly {
    // State variables
    // owner: 合约所有者地址，拥有最高管理权限
    address public owner;
    // treasureAmount: 资金池中的总金额（单位wei，但仅为数字记录，不代表真实转账）
    uint256 public treasureAmount;
    // withdrawalAllowance: 映射，记录每个地址被批准的提款额度（金额）
    mapping(address => uint256) public withdrawalAllowance;
    // hasWithdrawn: 映射，记录每个地址是否已经提取过资金（true=已提取，false=未提取）
    mapping(address => bool) public hasWithdrawn;
    
    // Constructor sets the contract creator as the owner
    // 构造函数：部署合约时自动执行，将部署者地址设置为owner
    constructor() {
        owner = msg.sender;
    }
    
    // Modifier for owner-only functions
    // onlyOwner 修饰器：检查调用者是否为owner，若不是则回退交易并显示错误信息
    modifier onlyOwner() {
        require(msg.sender == owner, "Access denied: Only the owner can perform this action");
        _;  // 占位符，表示被修饰函数的代码将在检查通过后执行
    }
    
    // Only the owner can add treasure
    // addTreasure: 只有所有者可以调用，向资金池增加指定金额
    function addTreasure(uint256 amount) public onlyOwner {
        treasureAmount += amount;  // 将amount累加到资金池总额
    }
    
    // Only the owner can approve withdrawals
    // approveWithdrawal: 只有所有者可以调用，为指定地址批准提款额度
    function approveWithdrawal(address recipient, uint256 amount) public onlyOwner {
        require(amount <= treasureAmount, "Not enough treasure available");  // 确保额度不超过当前资金池总额
        withdrawalAllowance[recipient] = amount;  // 设置该地址的提款额度
    }
    
    
    // Anyone can attempt to withdraw, but only those with allowance will succeed
    // withdrawTreasure: 提款函数，任何人都可以调用，但根据调用者身份执行不同逻辑
    function withdrawTreasure(uint256 amount) public {
        // 如果调用者是所有者，直接提取（不经过额度检查）
        if(msg.sender == owner){
            require(amount <= treasureAmount, "Not enough treasury available for this action.");
            treasureAmount -= amount;  // 资金池减少amount
            return;  // 所有者处理完后立即退出函数
        }
        // 以下为普通用户提款逻辑
        uint256 allowance = withdrawalAllowance[msg.sender];  // 获取调用者的批准额度
        
        // Check if user has an allowance and hasn't withdrawn yet
        require(allowance > 0, "You don't have any treasure allowance");  // 必须有额度
        require(!hasWithdrawn[msg.sender], "You have already withdrawn your treasure");  // 必须未提过款
        require(allowance <= treasureAmount, "Not enough treasure in the chest");  // 额度不能超过资金池总额
        require(allowance >= amount, "Cannot withdraw more than you are allowed"); // 用户请求提取的金额不能超过其额度
        
        // Mark as withdrawn and reduce treasure
        hasWithdrawn[msg.sender] = true;  // 标记该用户已提款
        treasureAmount -= allowance;       // 资金池扣除该用户的全部额度（注意：这里扣除的是allowance，而不是amount）
        withdrawalAllowance[msg.sender] = 0;  // 清空额度
    }
    
    // Only the owner can reset someone's withdrawal status
    // resetWithdrawalStatus: 只有所有者可以调用，将指定用户的“已提款”状态重置为false（允许再次提款）
    function resetWithdrawalStatus(address user) public onlyOwner {
        hasWithdrawn[user] = false;
    }
    
    // Only the owner can transfer ownership
    // transferOwnership: 只有所有者可以调用，将合约所有权转移给新地址
    function transferOwnership(address newOwner) public onlyOwner {
        require(newOwner != address(0), "Invalid address");  // 新地址不能是零地址
        owner = newOwner;  // 更新所有者
    }
    
    // 这是一个公开函数，仅所有者可调用，只读模式，返回一个无符号整数（即资金池总额）。
    function getTreasureDetails() public view onlyOwner returns (uint256) {
        return treasureAmount;  // 返回当前资金池的总额
    }
}