// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract AdminOnly {
    address public owner;

//Constructor runs only once at deployment to initialize the contract
    constructor() {
        owner = msg.sender; //Whoever run deploy the contractor is the contract owner
    }

    // Modifier for owner-only functions
    modifier onlyOwner() {
        require(msg.sender == owner, "Access denied: Only the owner can perform this action.");
        _; //_ is the placeholder
    }

    uint256 public treasureAmount;

    function addTreasure(uint256 amount) public onlyOwner {
        treasureAmount += amount; // Addition Assignment: dds the value of amount to treasureAmount
    }

    // Only the owner can approve the withdrawal and amount
    mapping(address => uint256) public withdrawalAllowance;

    function approveWithdrawal(address recipient, uint256 amount) public onlyOwner {
        require(amount <= treasureAmount, "Not enough treasure available.");
        withdrawalAllowance[recipient] = amount;
    }

    // Two scenario for withdrawal
    mapping(address => bool) public hasWithdrawn;

    function withdrawTreasure(uint256 amount) public {

        // Scenario A: the owner
        if (msg.sender == owner) {
            require(amount <= treasureAmount, "Not enought treasury available for this action.");
            treasureAmount -= amount;

            return;
        }

        // Scenario B: others
        uint256 allowance =withdrawalAllowance[msg.sender];

        require(allowance > 0, "You don't have any treasure allowance.");
        require(!hasWithdrawn[msg.sender], "You have already withdrawn your treasure.");
        require(allowance <= treasureAmount, "Not enought treasure in the chest.");

        hasWithdrawn[msg.sender] = true; //// Mark as withdrawn 
        treasureAmount -= allowance; //Reduce treasure amount
        withdrawalAllowance[msg.sender] = 0; //reset allowance as zero
    }
    // The withdrawal status can be reset only by the owner
    function resetWithdrawalStatus(address user) public onlyOwner {
        hasWithdrawn[user] = false;
    }

    function transferOwnership(address newOwner) public onlyOwner {
        require(newOwner != address(0), "Invalid address.");
        owner = newOwner;
    }

    function getTreasureDetails() public view onlyOwner returns (uint256) {
        return treasureAmount;
    }
}
