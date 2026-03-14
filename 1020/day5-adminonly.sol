// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract AdminOnly {
    //设置合约拥有者
    address public owner;
    uint256 public treasureAmount;

    constructor(){
        owner=msg.sender;
    }
    //可复用，只有owner可调用
    modifier onlyOwner(){
        require(msg.sender==owner,"access denied:only the owner can perform this action");
        _;//占位符
    }

    //宝箱增加金额
    function addressTreasure(uint256 amount) public onlyOwner{
        treasureAmount+=amount;
    }
    //record how much allowed to be withdraw
    mapping(address=>uint256) public withdrawalAllowance;
    function approveWithdrawal(address recipient,uint256 amount) public onlyOwner{
        require(amount<=treasureAmount,"not enough treasure available");
        withdrawalAllowance[recipient]=amount;
    }
    //get treasure for box
    mapping(address=>bool) public hasWithdrawn;
    function withdrawTrawTreasure(uint256 amount)public{
        //ower use
        if(msg.sender==owner){
            require(amount<=treasureAmount,"not enough treasure available");
            treasureAmount-=amount;//reduce treasureAmount
            return;
        }
        //other user
        uint256 allowance=withdrawalAllowance[msg.sender];
        require(allowance>0,"you don't have any treasure allowance");
        require(!hasWithdrawn[msg.sender],"you have already withdrawn your treasure");
        require(allowance<=treasureAmount,"not enough treasure in the chest");
        hasWithdrawn[msg.sender]=true;//记录已经被提取
        treasureAmount-=allowance;//从宝箱减去被批准的提取数量
        withdrawalAllowance[msg.sender]=0;//将用户的提取额度归0

    }
    // Only the owner can reset someone's withdrawal status拥有者可以操作
    function resetWithdrawalStatus(address user) public onlyOwner {
        hasWithdrawn[user] = false;
    }
    
    // Only the owner can transfer ownership
    function transferOwnership(address newOwner) public onlyOwner {
        require(newOwner != address(0), "Invalid address");//address(0)用于校验地址是否为空
        owner = newOwner;
    }
    
    function getTreasureDetails() public view onlyOwner returns (uint256) {
        return treasureAmount;
    }
}