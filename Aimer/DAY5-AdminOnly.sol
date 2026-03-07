// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
contract AdminOnly {
    address public owner;
    uint256 public treasureAmount;
    mapping (address=>uint256)public withdrawAllowance;
    mapping (address=>bool) hasWithdrawn;

    constructor(){
        owner=msg.sender;
    }
    modifier OnlyOwner(){
        require(msg.sender==owner,"Access denied: Only the owner can perform this action");
        _;
    }
    function addTreasure(uint256 amount) public OnlyOwner{
        treasureAmount+=amount;
    }
    function approveWithdrawal(address recipient, uint256 amount) public OnlyOwner{
        require(amount<=treasureAmount,"Insufficient funds in the contract");
        withdrawAllowance[recipient]=amount;
    }
    function withdrawTreasure(uint256 amount)public {
        if (msg.sender==owner){
            require(amount <=treasureAmount,"Insufficient funds in the contract");
            treasureAmount -=amount;
            return;
        }
        uint256 allowance = withdrawAllowance[msg.sender];

        require(allowance>0,"You don't have any treasure allowance");
        require(!hasWithdrawn[msg.sender],"You have already withdrawn your treasure");
        require(allowance<=treasureAmount,"Not enough treasure in the chest");
        require(amount<=allowance,"Not enough allowance for withdrawl");

        hasWithdrawn[msg.sender]=true;
        treasureAmount -=allowance;
        withdrawAllowance[msg.sender]=0;
    }
    function resetWithdrawlStatus(address user)public OnlyOwner{
        hasWithdrawn[user]=false;
    }
    function transferOwnership(address newOwner)public OnlyOwner{
        require(newOwner!=address(0),"Invalid new Owner");
        owner=newOwner;
    }
    function getTreasureDetails()public view OnlyOwner returns (uint256){
        return treasureAmount;
    }
}
