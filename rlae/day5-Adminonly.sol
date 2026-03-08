// SPDX-License-Identifier:MIT
pragma solidity ^0.8.0;
contract Adminonly{
    address public owner;
    uint256 public treasureamount;
    uint256 withdrawtime;
    uint256 endtime;
    mapping (address=>uint) public withdrawTreasure; // define the mapping of people's treasure amount
    mapping (address=>bool) public hasWithdrawn; // mapping judge if people already been withdrawn
    constructor(uint256 _withdrawtime){
        owner=msg.sender;
        withdrawtime= _withdrawtime;
    }
    modifier onlyOwner(){
        require(msg.sender==owner,"You are not allowed");// here owner is the one delopyed the contract? 
        _;
    }
    function addTreasure(uint256 amount)public onlyOwner{
        treasureamount += amount;
        endtime=block.timestamp+withdrawtime;
    }
    function approvedwithdraw(address recipient, uint256 amount)public onlyOwner{
        require (amount<treasureamount, "money is not enough");
        withdrawTreasure[recipient]=amount;
    }
    function withdrawmoney(uint256 amount)public { // here no need of onlyowner?
    if (msg.sender==owner){
        require (amount<treasureamount, "money is not enough");
        return;
    }
    uint256 allowence = withdrawTreasure[msg.sender];
    require(allowence>0,"you don't have money in it");
    require(!hasWithdrawn[msg.sender], "You already withdraw yet");
    require(allowence<=treasureamount,"not enough money in it");
    require(block.timestamp<endtime,"expired"); // limit the time 
    hasWithdrawn[msg.sender]=true;
    treasureamount -=allowence;
    withdrawTreasure[msg.sender]=0;
    }
    function reset(address user)public onlyOwner{
        hasWithdrawn[user]=false;

    }
    function transferownership(address newOwner)public onlyOwner{
        require(newOwner!=address(0),"Invalid address");//address(0) meaning 0/NA ?
        owner=newOwner;
    }
    function getdetail()public onlyOwner view returns (uint256){
        return treasureamount;     //   
    }


}