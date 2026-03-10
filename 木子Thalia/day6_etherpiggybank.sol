// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract EtherPiggyBank{
    address public bankmanager;
    address[] members;  //所有加入的人
    mapping(address => bool) registeredMembers;  //是否已被批准
    mapping(address => uint256) balance;  //每位成员存的钱

    constructor() {  //构造函数，定义管理员
        bankmanager = msg.sender;
        members.push(bankmanager);
        registeredMembers[bankmanager] = true;
    }

    modifier onlyBankManager() {
        require(msg.sender == bankmanager, "Only bank manager can perform this antion");
        _;
    }

    modifier onlyRegisteredMember(){
        require(registeredMembers[msg.sender], "Member not registered");
        _;
    }

    function addMembers(address _member) public onlyBankManager{
        require(_member != address(0), "Invalid address");
        require(_member != msg.sender, "Bank Manager is already a member");
        require(!registeredMembers[_member], "Member already registered");

        registeredMembers[_member] = true;
        members.push(_member);
    }

    function getMembers() public view returns (address[] memory) {
        return members;
    }

    function deposit(uint256 _inAmount) public onlyRegisteredMember{
        require(_inAmount > 0, "Invalid amnount");
        balance[msg.sender] += _inAmount;
    } 

    function withdraw(uint256 _outAmount) public onlyRegisteredMember{
        require(_outAmount > 0, "Invalid amount");
        require(_outAmount <= balance[msg.sender], "Insufficient balance");
        balance[msg.sender] -= _outAmount;
    }

    function depositAmountEther() public payable onlyRegisteredMember {
        require(msg.value > 0, "Invalid amount");
        balance[msg.sender] += msg.value;
    }   
    
}
