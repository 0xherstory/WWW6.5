// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract EtherPiggyBank{
    //共享存钱罐需要：批准人，存取钱，查看金额
    address public bankManager;
    address[] members;
    mapping (address => bool) public registeredMember; //address 可以用bool状态判断
    mapping (address =>uint256) balance;

constructor () {
    bankManager =msg.sender;
    registeredMember[bankManager]=true; //bank manager在注册member中
    members.push(msg.sender);
    // bankManager =msg sender，同时msg 也属于members列表
}

modifier  onlybankManager() {
    require(msg.sender== bankManager,"Only bank Manager can perform this action");
    _;
    // ==为判断：左边是否等于右边；=为赋值：将左边的值赋予右边；
}

modifier onlyRegisteredMember(){
    require(registeredMember[msg.sender], "Member not registeres");
    _;
    //不能用msg.sender == registeredMember，因为这是对比单个值，而member为数组，用registeredMember[msg.sender]
}

function addmembers(address _member) public onlybankManager{
    require(_member!= address(0),"Invalid address");//!= 为组合符号，代表inequality；此段话代表member的地址不等于0
    require(_member !=msg.sender,"is the bank manager");
    require(!registeredMember[_member],"already a member");
    registeredMember[_member]=true;
    members.push(_member);
}

function getMembers() public view returns (address[]memory) {
    return members;
}

function deposit(uint256 _amount) public  onlyRegisteredMember(){
    require(_amount>0, "Invalid amount");
    balance[msg.sender]+= _amount; //某个人存钱到这个人的账户
}

function withdraw(uint256 _amount) public onlyRegisteredMember(){
    require(_amount>0, "invalid amount");
    require(balance[msg.sender] >= _amount, "Insufficient balance");
    balance[msg.sender]-= _amount;
}

//查询存蓄罐现有金额
function getAmount(address _member) public view returns (uint256){ //某个账户的余额
    require(_member !=address(0), "invalid address");
    //return balance[msg.sender];
    return balance[_member];
}

function depositAmountEther() public payable onlyRegisteredMember(){//payable：以太币许可证？
    require(msg.value >0, "Invalid amount");
    balance[msg.sender]+=msg.value;
}//真实储存以太币


}