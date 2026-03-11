// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Adminonly{
    address public owner;
    uint256 public treasureAmount;

    mapping(address=>uint256)public withdrawalAllowance;
    mapping(address=>bool)public hasWithdraw;

    constructor(){
        owner=msg.sender;
    }

    modifier onlyOwner(){
        require(msg.sender==owner,"not the owner");
        _;
    }

    function addTreasure (uint256 amount )public onlyOwner{
        treasureAmount += amount;

    }

    function approveWithdraw(address recipient , uint256 amount)public onlyOwner{
        withdrawalAllowance[recipient]=amount;

    }

    function withdrawTreasure(uint256 amount) public {
        require(amount <= withdrawalAllowance[msg.sender], "Insufficient allowance");
        require(!hasWithdraw [msg.sender], "Already withdrawn");
        hasWithdraw[msg.sender] = true;
        withdrawalAllowance[msg.sender] -= amount;

    }

    function resetWithdrawalStatus(address user) public onlyOwner {
        hasWithdraw[user] = false;
    }

    function transferWithdrawalStatus(address newOwner) public onlyOwner {
        owner = newOwner;
    }
    function getTreasureDetails() public view onlyOwner returns(uint256){
        return treasureAmount;
    }
    }

