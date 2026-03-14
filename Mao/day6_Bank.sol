// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;


contract SavingsPot {
    // ============ 状态变量定义 ============
    // 银行经理（合约部署者，拥有管理员权限）
    address public bankManager;

    // 成员列表（存储所有注册成员地址）
    address[] public members;

    // 成员注册状态映射（快速校验地址是否为注册成员）
    mapping(address => bool) public registeredMembers;

    // 成员余额映射（记录每个成员的存款金额，单位：wei）
    mapping(address => uint256) public balance;


    constructor() {
        // 部署者成为银行经理
        bankManager = msg.sender;
        // 标记部署者为注册成员
        registeredMembers[msg.sender] = true;
        // 将部署者加入成员数组
        members.push(msg.sender);
    }


    modifier onlyBankManager() {
        require(
            msg.sender == bankManager,
            "Only bank manager can perform this action"
        );
        _; // 执行被修饰函数的核心逻辑
    }


    modifier onlyRegisteredMember() {
        require(
            registeredMembers[msg.sender],
            "Member not registered"
        );
        _; // 执行被修饰函数的核心逻辑
    }


    function addMembers(address _member) public onlyBankManager {
        // 校验地址是否为无效的零地址
        require(_member != address(0), "Invalid address");
        // 校验是否重复添加银行经理（经理已默认加入）
        require(_member != msg.sender, "Bank Manager is already a member");
        // 校验成员是否已注册，避免重复添加
        require(!registeredMembers[_member], "Member already registered");

        // 标记该地址为注册成员
        registeredMembers[_member] = true;
        // 将地址加入成员列表
        members.push(_member);
    }

    
    function transferManager(address _newManager) public onlyBankManager {
        require(_newManager != address(0), "Invalid new manager address");
        bankManager = _newManager;
    }


    function getMembers() public view returns (address[] memory) {
        return members;
    }

    function deposit(uint256 _amount) public onlyRegisteredMember {
        require(_amount > 0, "Invalid amount");
        balance[msg.sender] += _amount;
    }


    function withdraw(uint256 _amount) public onlyRegisteredMember {
        require(_amount > 0, "Invalid amount");
        require(balance[msg.sender] >= _amount, "Insufficient balance");
        balance[msg.sender] -= _amount;
    }


    function depositAmountEther() public payable onlyRegisteredMember {
        require(msg.value > 0, "Invalid amount");
        // 将存入的以太币数量（wei）计入成员余额
        balance[msg.sender] += msg.value;
    }

    function withdrawAmountEther(uint256 _amount) public onlyRegisteredMember {
        require(_amount > 0, "Invalid amount");
        require(balance[msg.sender] >= _amount, "Insufficient balance");
        require(address(this).balance >= _amount, "Contract has no enough ether");

        // 更新成员余额
        balance[msg.sender] -= _amount;


        (bool success, ) = payable(msg.sender).call{value: _amount}("");
        require(success, "Ether withdrawal failed");
    }


    function getContractEtherBalance() public view returns (uint256) {
        return address(this).balance;
    }


    function getMemberBalance(address _member) public view returns (uint256) {
        return balance[_member];
    }
}