// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
contract ETHPiggyBank {
    //银行经理
    address public bankManager;
    //所有成员
    address[] members;
    //记录是否被批准的成员映射
    mapping(address => bool) public registeredMembers;
    //成员-》余额
    mapping(address => uint256) balance;

    constructor() {
        bankManager = msg.sender;
        members.push(msg.sender);
        registeredMembers[msg.sender] = true;
        
    }

    //经理权限确认校验修饰符
    modifier onlyBankManager() {
        require(msg.sender == bankManager, "Only bank manager can perform this action");
        _;
    }

    //正式成员权限确认校验修饰符
    modifier onlyRegisteredMember() {
        require(registeredMembers[msg.sender], "Member not registered");
        _;
    }

    //经理添加成员
    function addMembers(address _member) public onlyBankManager {
        require(_member != address(0), "Invalid address");
        require(_member != msg.sender, "Bank Manager is already a member");
        require(!registeredMembers[_member], "Member already registered");

        registeredMembers[_member] = true;
        members.push(_member);
    }

    //查看成员列表
    function getMembers() public view returns (address[] memory) {
        return members;
    }

    //存钱
    function deposit(uint256 _amount) public onlyRegisteredMember {
        require(_amount > 0, "Invalid amount");
        balance[msg.sender] += _amount;
    }

    //取钱
    function withdraw(uint256 _amount) public onlyRegisteredMember {
        require(_amount > 0, "Invalid amount");
        require(balance[msg.sender] >= _amount, "Insufficient balance");
        balance[msg.sender] -= _amount;
    }

    //真实存储
    function depositAmountEther() public payable onlyRegisteredMember {
        require(msg.value > 0, "Invalid amount");
        balance[msg.sender] += msg.value;
    }



}