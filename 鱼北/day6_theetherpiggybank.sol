//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract EtherPiggyBank{

    //银行经理及成员
    address public bankManager;
    address[] members;
    mapping(address => bool) public registeredMembers;
    mapping(address => uint256) balance;

    constructor(){
        bankManager = msg.sender;
        members.push(msg.sender);
    }

    //制定规则（修饰符）
    modifier onlyBankManager(){
        require(msg.sender == bankManager, "Only bank manager can perform this action");
        _;
    }

    modifier onlyRegisteredMember() {
        require(registeredMembers[msg.sender], "Member not registered");
        _;
    }
  
    //添加新成员
    function addMembers(address _member)public onlyBankManager{
        require(_member != address(0), "Invalid address");
        require(_member != msg.sender, "Bank Manager is already a member");
        require(!registeredMembers[_member], "Member already registered");
        registeredMembers[_member] = true;
        members.push(_member);
    }

    //查看成员列表
    function getMembers() public view returns(address[] memory){
        return members;
    }
    //存款（模拟储蓄）
    function depositAmount(uint256 _amount) public onlyRegisteredMember{
         require(_amount > 0, "Invalid amount");
         balance[msg.sender] = balance[msg.sender]+_amount;
     }


    //引入以太币到模拟
    function depositAmountEther() public payable onlyRegisteredMember{  
        require(msg.value > 0, "Invalid amount");
        balance[msg.sender] = balance[msg.sender]+msg.value;
   
    }
    
    function withdrawAmountEther(uint256 _amount) public onlyRegisteredMember{
        require(_amount > 0, "Invalid amount");
        require(balance[msg.sender] >= _amount, "Insufficient balance");
        balance[msg.sender] = balance[msg.sender]-_amount;
   
    }

    function getBalance(address _member) public view returns (uint256){
        require(_member != address(0), "Invalid address");
        return balance[_member];
    } 
}