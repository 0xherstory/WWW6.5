// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract AdminOnly {
    address public owner;
    uint256 public treasureAmount;
    uint256 public constant MAX_LIMIT = 1000; 
    mapping(address => uint256) public withdrawalAllowance;
    mapping(address => bool) public hasWithdrawn;
    constructor() {
        owner = msg.sender;
    }
    modifier onlyOwner() {
        require(msg.sender == owner, "Access denied: Only the owner can perform this action");
        _;
    }
    function addTreasure(uint256 amount) public onlyOwner {
        treasureAmount += amount;
    }
    function approveWithdrawal(address recipient, uint256 amount) public onlyOwner {
        require(amount <= treasureAmount, "Not enough treasure available");
        require(amount <= MAX_LIMIT, "Exceeds maximum withdrawal limit!");
        
        withdrawalAllowance[recipient] = amount;
    }
    function checkUserStatus(address _user) public view returns (uint256 allowance, bool withdrawn) {
        return (withdrawalAllowance[_user], hasWithdrawn[_user]);
    }

    function withdrawTreasure(uint256 amount) public {
        if (msg.sender == owner) {
            require(amount <= treasureAmount, "Not enough treasury available for this action.");
            treasureAmount -= amount;
            return;
        }

        uint256 allowance = withdrawalAllowance[msg.sender];
        require(allowance > 0, "You don't have any treasure allowance");
        require(!hasWithdrawn[msg.sender], "You have already withdrawn your treasure");
        require(allowance <= treasureAmount, "Not enough treasure in the chest");
        hasWithdrawn[msg.sender] = true;
        treasureAmount -= allowance;
        withdrawalAllowance[msg.sender] = 0;
    }
}
