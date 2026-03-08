//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract EtherPiggyBank{

    address public bankManager;
    address[] members;
    mapping(address => bool) public registeredMembers; //是否有权限
    mapping(address => uint256) balance; //存xx

    constructor(){
        bankManager = msg.sender;
        members.push(msg.sender);
    }//初始化

    modifier onlyBankManager(){
        require(msg.sender == bankManager, "Only bank manager can perform this action");
        _;
    }

    modifier onlyRegisteredMember() {
        require(registeredMembers[msg.sender], "Member not registered");
        _;
    }
  
    function addMembers(address _member)public onlyBankManager{
        require(_member != address(0), "Invalid address");
        require(_member != msg.sender, "Bank Manager is already a member");
        require(!registeredMembers[_member], "Member already registered");
        registeredMembers[_member] = true;
        members.push(_member);
    }//地址有效；没有重复添加

    function getMembers() public view returns(address[] memory){
        return members;
    }
    
    //
    function deposit(uint256 _amount) public onlyRegisteredMember {
        require(_amount > 0, "Invalid amount");
        balance[msg.sender] += _amount;
    }
    // 为什么bankManager存钱，提示"Member not registered".但实际上Bankmanager又是呢（"Bank Manager is already a member".）
    //
    
    //deposit in Ether 
    //function depositAmountEther() public payable onlyRegisteredMember{  //payable：可以接收以太币
    //    require(msg.value > 0, "Invalid amount");
    //   balance[msg.sender] = balance[msg.sender]+msg.value; //msg.value：以太币数量（单位是 wei ）
   
    //}//存
    
    function withdrawAmount(uint256 _amount) public onlyRegisteredMember{
        require(_amount > 0, "Invalid amount");
        require(balance[msg.sender] >= _amount, "Insufficient balance");
        balance[msg.sender] = balance[msg.sender]-_amount;
   
    }//取：金额有效、足够；扣钱；

    function getBalance(address _member) public view returns (uint256){
        require(_member != address(0), "Invalid address");
        return balance[_member];
    } 
}