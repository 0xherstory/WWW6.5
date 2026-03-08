// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract AdminOnly {
    // State variables
    address public owner; //宝藏所有人的地址
    uint256 public treasureAmount; //合约中宝藏的数量
    mapping(address => uint256) public withdrawalAllowance; //记录某地址娶了多少的宝藏
    mapping(address => bool) public hasWithdrawn; //记录某地址是否取了宝藏
    
    // 设置合约部署者成为 owner
    constructor() {
        owner = msg.sender;
    }
    
    //函数修饰符，不是函数
    modifier onlyOwner() {
        require(msg.sender == owner, "Access denied: Only the owner can perform this action");
        _; 
        //"_"这是一个特殊的占位符，表示“这里原本放函数的内容”
        //换句话说，modifier 在函数执行前插入自己的逻辑，然后再执行 _ 处的函数体
    }
    
    //一个叫做addtreature的函数，接收一个参数，没有返回值，且调用函数之前必须经过onlyowner（函数修饰符）的检查
    function addTreasure(uint256 amount) public onlyOwner {
        treasureAmount += amount;
    }
    //
    
    // Only the owner can approve withdrawals
    function approveWithdrawal(address recipient, uint256 amount) public onlyOwner {
        require(amount <= treasureAmount, "Not enough treasure available");
        withdrawalAllowance[recipient] = amount;
    }
    
    
    // Anyone can attempt to withdraw, but only those with allowance will succeed
    function withdrawTreasure(uint256 amount) public {

        if(msg.sender == owner){
            require(amount <= treasureAmount, "Not enough treasury available for this action.");
            treasureAmount-= amount;

            return;
        }
        uint256 allowance = withdrawalAllowance[msg.sender];
        
        // Check if user has an allowance and hasn't withdrawn yet
        require(allowance > 0, "You don't have any treasure allowance");
        require(!hasWithdrawn[msg.sender], "You have already withdrawn your treasure");
        require(allowance <= treasureAmount, "Not enough treasure in the chest");
        require(allowance >= amount, "Cannot withdraw more than you are allowed"); // condition to check if user is withdrawing more than allowed
        
        // Mark as withdrawn and reduce treasure
        hasWithdrawn[msg.sender] = true;
        treasureAmount -= allowance;
        withdrawalAllowance[msg.sender] = 0;
        
    }
    
    // Only the owner can reset someone's withdrawal status
    function resetWithdrawalStatus(address user) public onlyOwner {
        hasWithdrawn[user] = false;
    }
    
    // Only the owner can transfer ownership
    function transferOwnership(address newOwner) public onlyOwner {
        require(newOwner != address(0), "Invalid address");
        owner = newOwner;
    }
    
    function getTreasureDetails() public view onlyOwner returns (uint256) {
        return treasureAmount;
    }
}