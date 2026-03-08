// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract AdminOnly {
    // 状态变量
    address public owner;
    uint256 public treasureAmount;
    mapping(address => uint256) public withdrawalAllowance;
    mapping(address => bool) public hasWithdrawn;
    
    // 构造函数：将合约部署者设置为 owner
    constructor() {
        owner = msg.sender;
    }
    
    // 仅限 owner 调用的修饰器
    modifier onlyOwner() {
        require(msg.sender == owner, "Access denied: Only the owner can perform this action");
        _;
    }
    
    // 只有 owner 才能向宝库中增加资金
    function addTreasure(uint256 amount) public onlyOwner {
        treasureAmount += amount;
    }
    
    // 只有 owner 才能批准某个地址的提款额度
    function approveWithdrawal(address recipient, uint256 amount) public onlyOwner {
        require(amount <= treasureAmount, "Not enough treasure available");
        withdrawalAllowance[recipient] = amount;
    }
    
    
    // 任何人都可以尝试提款，但只有获得授权的人才能成功
    function withdrawTreasure(uint256 amount) public {

        // 如果调用者是 owner，则可以直接从宝库中取钱
        if(msg.sender == owner){
            require(amount <= treasureAmount, "Not enough treasury available for this action.");
            treasureAmount-= amount;

            return;
        }

        uint256 allowance = withdrawalAllowance[msg.sender];
        
        // 检查用户是否有提款额度，并且之前没有提款过
        require(allowance > 0, "You don't have any treasure allowance");
        require(!hasWithdrawn[msg.sender], "You have already withdrawn your treasure");
        require(allowance <= treasureAmount, "Not enough treasure in the chest");
        require(allowance >= amount, "Cannot withdraw more than you are allowed"); // 检查用户是否尝试提取超过额度的金额
        
        // 标记为已提款，并减少宝库金额
        hasWithdrawn[msg.sender] = true;
        treasureAmount -= allowance;
        withdrawalAllowance[msg.sender] = 0;
        
    }
    
    // 只有 owner 可以重置某个用户的提款状态
    function resetWithdrawalStatus(address user) public onlyOwner {
        hasWithdrawn[user] = false;
    }
    
    // 只有 owner 可以转移合约所有权
    function transferOwnership(address newOwner) public onlyOwner {
        require(newOwner != address(0), "Invalid address");
        owner = newOwner;
    }
    
    // 只有 owner 可以查看当前宝库金额
    function getTreasureDetails() public view onlyOwner returns (uint256) {
        return treasureAmount;
    }
}
