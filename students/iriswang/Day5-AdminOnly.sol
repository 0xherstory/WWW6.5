// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract AdminOnly {
    address public owner;
    uint256 public treasureAmount;

    mapping(address => uint256) public withdrawlAllowance;
    mapping(address => bool) public hasWithdrawn;

    constructor(){
        owner = msg.sender;
    }
    modifier onlyOwner(){
        require(msg.sender == owner, "Not the owner");
        _;
    }


function addTreasure(uint256 amount) public onlyOwner{
treasureAmount += amount;
}

function withdrawTreasure(uint256 amount) public{
    require(amount <= withdrawlAllowance[msg.sender], "Insufficient allowance");
    require(!hasWithdrawn[msg.sender], "Already withdrawn");

    hasWithdrawn[msg.sender] = true;
    withdrawlAllowance[msg.sender]-= amount;
}

function resetWuthdrawlStatus(address user)public onlyOwner{
    hasWithdrawn[user] = false;
}
function transferOwnership(address newOwner) public onlyOwner{
    owner = newOwner;
}

function getTreasureDetails() public view onlyOwner returns (uint256) {
    return treasureAmount;
}
}
