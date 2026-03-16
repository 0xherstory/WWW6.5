// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract AdminOnly {
    address public owner;
    uint public treasureAmount;

    mapping(address => uint) public withdrawalAllowance;
    mapping(address => bool) public hasWithdrawn;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner {
        require(msg.sender == owner, "Only Owner Can Do This Thing");
        _;
    }

    function addTreasure(uint amount) public onlyOwner {
        treasureAmount += amount;
    }

    function approveUserGetTreasure(address user, uint amount) public onlyOwner{
        require(amount<=treasureAmount,"Not enough treasure available");
        withdrawalAllowance[user] = amount;
    }

    function withdrawTreasure(uint amount) public {
        if (msg.sender == owner) {
            require(amount<=treasureAmount,"Not enough treasure available");
            treasureAmount -= amount;
            return ;
        }

        uint allowance = withdrawalAllowance[msg.sender];
        require(allowance>0, "You don't have any treasure allowance");
        require(!hasWithdrawn[msg.sender], "you have already withdrawn your treasure");
        require(allowance <= treasureAmount, "Not enough treasure in the chest");
        require(allowance>=amount, "Cannot withdraw more than you are allowed");

        hasWithdrawn[msg.sender] = true;
        treasureAmount -=allowance;
        withdrawalAllowance[msg.sender] = 0;
    }

    function resetWithdrawalStatus(address user) public onlyOwner {
        hasWithdrawn[user] = false;
    }

    function transferOwnership(address newOwner) public onlyOwner {
        require(newOwner != address(0), "Invalid address");
        owner = newOwner;
    }

    function getTreasureDetails() public view onlyOwner returns(uint) {
        return treasureAmount;
    }
    
}