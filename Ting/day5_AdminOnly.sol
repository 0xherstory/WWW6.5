// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract AdminOnly{
    // State variables
    address public owner;
    uint256 private treasureAmount;
    mapping (address => uint256) public withdrawalAllowance;
    mapping (address => bool) public hasWithdrawn;

    // New freezingtime
    uint256 public cooldown = 1 minutes;
    mapping (address => uint256) public lastWithdrawTime;
    
    // New user max withdrawlimit
    mapping(address => uint256) public maxWithdrawLimit;

    // Event
    event TreasureAdded(uint256 amount);
    event TreasureWithdrawn(address user, uint256 amount);
    event OwnershipTransferred(address oldOwner, address newOwner);

    // Constructor sets the contract creastor as the owmer
    constructor() {
        owner = msg.sender;
    }

    // Modifier for owner-only functions
    modifier onlyOwner() {
        require(msg.sender == owner, "Access denied: Only the owner can perform this action");
        _;
    }

    // Only the owner can add treasure
    function addTreasure(uint256 amount) public onlyOwner{
        treasureAmount += amount;
        emit TreasureAdded(amount);
    }

    // Only the owner can approve withdrawals
    function approveWithdrawal(address recipient, uint256 amount) public onlyOwner{
        require(amount <= treasureAmount, "Not enough treasury available for this action");
        withdrawalAllowance[recipient] = amount;
        maxWithdrawLimit[recipient] = amount;
    }

    // Anyone can attempt to withdraw, but only those with allowance will succed
    function withdrawTreasure(uint256 amount) public {
        require(
            block.timestamp >= lastWithdrawTime[msg.sender] + cooldown,
            "Withdrawal cooldown not finishied"
        );

        if(msg.sender == owner){
            require(amount <= treasureAmount, "Not enough treasury availavle for this action.");
            treasureAmount -= amount;
            lastWithdrawTime[msg.sender] = block.timestamp;
            emit TreasureWithdrawn(msg.sender, amount);
            return ;
        }

        uint256 allowance = withdrawalAllowance[msg.sender];
        
        // Check if user has an allowance and hasn't withdrawn yet
        require(allowance>0, "You don't have any treasure allowance.");
        require(!hasWithdrawn[msg.sender], "You have already withdrawn your treasure.");
        require(allowance <= treasureAmount, "Not enough treasure in the chest.");
        require(allowance >= amount, "Cannot withdraw more than you are allowed");

        // Mark as withdrawn and reduce treasure
        require(
            amount <= maxWithdrawLimit[msg.sender], "Exceeds maximum withdrawal limit"
        );
        hasWithdrawn[msg.sender] = true;
        treasureAmount -= amount;
        withdrawalAllowance[msg.sender] = 0;
        lastWithdrawTime[msg.sender] = block.timestamp;
        emit TreasureWithdrawn(msg.sender, amount);
    }

    // Only the owner can reset someone's withdrawal status
    function resetWithdrawalStatus(address user) public onlyOwner{
        hasWithdrawn[user] = false;
    }

    // Only the owner can transfer ownership
    function transferOwnership(address newOwner) public onlyOwner{
        require(newOwner != address(0) , "Invalid address");
        address oldOwner = owner;
        owner = newOwner;
        emit OwnershipTransferred(oldOwner, newOwner);
    }

    function getTreasureDetails() public view onlyOwner returns (uint256){
        return treasureAmount;
    }
}