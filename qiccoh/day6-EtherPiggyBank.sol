// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


contract EtherPiggyBank{

address public bankManager;
address[] members;
mapping(address =>bool) public registeredMembers;

mapping (address => uint256) balance;

constructor(){
    bankManager = msg.sender;
    members.push(msg.sender);
}

//权力指定
//只有管理者能执行
modifier onlyBankManager(){
    require(msg.sender ==bankManager,"Only bank manager can perform this action" );
    _;
}

//注册成员可以访问
modifier  OnlyRegisteredMenber(){
    require(registeredMembers[msg.sender],"member not registered");
    _;
}

//添加人
function addmambers(address _member) public onlyBankManager{
    require(_member != address(0),"invalid");
    require(_member != msg.sender,"Bank manager is already a member");
    require(!registeredMembers[_member],"member already registered");

    registeredMembers[_member] = true;
    members.push(_member);

}
//returns(address[] memory)：指定该函数返回一个地址数组，该数组存储在内存中
function getMambers()public view returns(address[] memory){
    return members;
    //返回一个名为 members 的地址数组。
}

// function deposit(uint256 _amount) public onlyRegisteredMember{
//     require(_amount > 0,"Invalid amount");
//     balance[msg.sender]+=_amount; 
// }
function depositAmountEnter() public payable OnlyRegisteredMenber{
    require(msg.value >0,"invalid");
    balance[msg.sender]+=msg.value;
}

function withdraw(uint256 _amount) public OnlyRegisteredMenber{
   require(_amount > 0,"Invalid amount");
    require(balance[msg.sender] >= _amount,"Insufficient balance");
    balance[msg.sender] -=_amount;
}   

}
