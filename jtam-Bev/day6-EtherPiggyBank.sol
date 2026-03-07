// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract EtherPiggyBank {

//银行经理需要有特殊权限管理账户
//必须有映射让让曾元注册并且检查他们是否有注册过
//一个负责blance的映射

address public bankManager;
address [] members;
mapping (address =>bool) public  registeredMembers;
mapping (address => uint256) balance;
mapping  (address => uint256) public pendingAmount; //把提款先冻结
mapping (address =>uint256) public requestTimestamp; //存什么时候申请的


constructor () {

bankManager =msg.sender;
members.push (msg.sender);

}

modifier onlyBankManager(){
    require(msg.sender ==bankManager, "Only bank manager can perform this action");
    _;
}

modifier onlyRegisteredMember (){

require(registeredMembers[msg.sender], "Member not registered");
_;

}

function addMembers (address _member) public onlyBankManager{

require(_member != address (0), "Invalid address");

require(_member !=msg.sender,"Bank manager is already a member");

require(!registeredMembers[_member], "Member already registered");

registeredMembers[_member]=true;

members.push (_member);

}

function getMembers ()public view returns (address [] memory){
    return members;
}

//存入金额 

function depositAmountEther () public  payable onlyRegisteredMember {
    require(msg.value>0,"You must send some Ether");

    balance[msg.sender]+= msg.value;
    }


function withdrawAmount (uint256 _amount) public onlyRegisteredMember {
    require(_amount >0, "Invalid address");
    require(balance[msg.sender]>=_amount, "Insufficient balance");

    balance[msg.sender] =balance [msg.sender] -_amount;
}

function getBalance (address _member) public view returns (uint256) {
    require(_member!=address (0),"Invalid address");

    return balance [_member];
}

function requestWithdraw (uint256 _amount) public onlyRegisteredMember {
    //限制条件

require(balance[msg.sender] >= _amount, "Insufficient balance to freeze");

require(_amount >0, "Amount must be greater than 0");
//从活期账本减去。 结余等于原结余减去金额
balance[msg.sender] -=_amount;
pendingAmount[msg.sender] += _amount;  //存入冻结账户

//记录时间戳.  当前时间
requestTimestamp[msg.sender] =block.timestamp;
}


function approveAndRelease (address _member) public onlyBankManager {
    uint256 amountToRelease =pendingAmount [_member];

 //检查是否有带处理的深情

 require(amountToRelease >0, "no pending withdrawl for this member");

//检查时间：当前时间必须大于😊时间➕24小时

 require(block.timestamp >= requestTimestamp [_member] +24 hours, "Wait for 24-hour cooling period");

//真正发钱的动作

pendingAmount[_member] =0;
//先清零账本 防止重入

payable (_member).transfer (amountToRelease);
}
}
