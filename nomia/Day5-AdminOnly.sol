
// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract AdminOnly{
    address public owner;
    uint public treasureAmount;
    mapping(address => uint256) public withdrawalAllowance;
    mapping(address => bool) public hasWithdrawn;

    constructor(){ //initiallization, run only once

        owner = msg.sender;



    }

    modifier OnlyOwner(){
        require(msg.sender == owner, "Access denied: only owner can perform this action.");
        _;


    }

    function addTreasure(uint256 amount) public OnlyOwner {
        treasureAmount += amount;
    }


    function approveWithdrawal(address recipient, uint256 amount) public nlyOwner {
        withdrawalAllowance[recipient] = amount;
    }
    

    function withdrawTreasure(uint256 amount) public {
        require(amount <= withdrawalAllowance[msg.sender], "insufficient allowance");
        require(!hasWithdrawn[msg.sender], "already withdrawn");
        
        hasWithdrawn[msg.sender] = true;
        withdrawalAllowance[msg.sender] -= amount;

    }
    

    function resetWithdrawalStatus(address user) public OnlyOwner {
        hasWithdrawn[user] = false;
    }

        
    function transferOwnership(address newOwner) public OnlyOwner {
        owner = newOwner;
    }


    function getTreasureDetails() public view OnlyOwner returns (uint256) {
        return treasureAmount;
    }








}
