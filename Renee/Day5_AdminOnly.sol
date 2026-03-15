// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract AdminOnly {
    
    //Setting Up the Owner
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    //Reusable Access Control with a Modifier
    modifier onlyOwner() {
        require(msg.sender == owner, "Access denied: Only the owner can perform this action.");

        _;
    }

    //Adding Treasure to the Chest
    uint256 public treasureAmount;
    function addTreasure(uint256 amount) public onlyOwner {
        treasureAmount += amount;
    }

    //Approving Others to Withdraw
    mapping (address => uint256) public withdrawalAllowance;
    function approveWithdrawalAllowance(address recipient, uint256 amount) public {
        require(amount <= treasureAmount, "Not enough treasure available.");
        withdrawalAllowance[recipient] = amount;
    }

    //Actually Withdrawing Treasure
    mapping(address => bool) public hasWithdrawn;
    function withdrawTreasure(uint256 amount) public {
        //Case 1: The Owner Is Withdrawing
        if(msg.sender == owner) {
            require(amount <= treasureAmount, "Not enough treasury available for this action.");
            treasureAmount -= amount;
            return;
        }

        //Case 2: A Regular User Is Withdrawing
        uint256 allowance = withdrawalAllowance[msg.sender];
        require(allowance > 0, "You don't have any treasure allowance.");
        require(!hasWithdrawn[msg.sender], "You have already withdrawn your treasure.");
        require(allowance < treasureAmount, "Not enough treasure in the chest.");

        //Finishing the Withdrawal
        hasWithdrawn[msg.sender] = true;
        treasureAmount -= allowance;
        withdrawalAllowance[msg.sender] = 0;
    }

    //Resetting a User’s Withdrawal Status
    function resetWithdrawalStatus(address user) public onlyOwner {
        hasWithdrawn[user] = false;
    }

    //Transferring Ownership (Owner Only)
    function transferOwnership(address newOwner) public onlyOwner {
        require(newOwner != address(0), "Invalid address.");
        owner = newOwner;
    }

    //Viewing the Treasure (Owner Only)
    function getTreasureDetails() public view onlyOwner returns(uint256) { //搞不清楚什么时候要加public和memory
        return treasureAmount;
    }
}