// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract AdminOnly {   
    address public owner;
    uint256 public treasureAmount;
    mapping(address => uint256) public withdrawalAllowance;
    mapping(address => bool) public hasWithdrawn;
    
    // 设置合约拥有者
    constructor() {
        owner = msg.sender;
    }
    
    // 通过修饰符实现可复用的访问控制
    modifier onlyOwner() {
        require(msg.sender == owner, "Access denied: Only the owner can perform this action");
        _;
    }
    
    // 往宝箱中添加宝物
    function addTreasure(uint256 amount) public onlyOwner {
        treasureAmount += amount;
    }
    
    // 授权ta人取宝    
    function approveWithdrawal(address recipient, uint256 amount) public onlyOwner {
        require(amount <= treasureAmount, "Not enough treasure available");
        withdrawalAllowance[recipient] = amount;
    }
    
    
    // 取宝过程
    function withdrawTreasure(uint256 amount) public {
        //拥有者自己取
        if(msg.sender == owner){
            require(amount <= treasureAmount, "Not enough treasury available for this action.");
            treasureAmount -= amount;
            return;
        }
        //普通用户取
        uint256 allowance = withdrawalAllowance[msg.sender];
        require(allowance > 0, "You don't have any treasure allowance");
        require(!hasWithdrawn[msg.sender], "You have already withdrawn your treasure");
        require(allowance <= treasureAmount, "Not enough treasure in the chest");
        
        //完成取宝
        hasWithdrawn[msg.sender] = true;
        treasureAmount -= allowance;
        withdrawalAllowance[msg.sender] = 0;
        
    }
    
    // 重置用户的提取状态
    function resetWithdrawalStatus(address user) public onlyOwner {
        hasWithdrawn[user] = false;
    }
    
    //转移合约拥有权
    function transferOwnership(address newOwner) public onlyOwner {
        require(newOwner != address(0), "Invalid address");
        owner = newOwner;
    }
    
    //查看宝箱信息（仅限拥有者）
    function getTreasureDetails() public view onlyOwner returns (uint256) {
        return treasureAmount;
    }
}