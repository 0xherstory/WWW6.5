//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract EtherPiggyBank {

    address public bankManager;//银行经理
    address[] members;//成员列表
    mapping(address => bool) public registeredMembers;//是否注册过/被批准
    mapping(address => uint256) balance;//成员余额

    constructor() {
        bankManager = msg.sender;//部署合约的人是银行经理
        members.push(msg.sender);//银行经理也是成员
        registeredMembers[msg.sender] = true;//银行经理默认注册成功
    }

    modifier onlyBankManager() {
        //只有银行经理才能执行某些操作
        require(msg.sender == bankManager,"Only bank manager can perform this action");
        _;
    }

    modifier onlyRegisteredMember() {
        //只有注册过的成员才能执行某些操作
        require(registeredMembers[msg.sender],"Member not registered.");
        _;
    }

    function addMembers(address _member)public onlyBankManager {
        //银行经理添加成员
        require(_member != address(0),"Invalid address.");//地址不能为空
        require(_member != bankManager,"Bank manager is already a member.");//银行经理已经是成员了
        require(!registeredMembers[_member],"Member already registered.");
        registeredMembers[_member] = true;
        members.push(_member);
    }

    function getMembers() public view returns (address[] memory) {
        //获取成员列表
        return members;
    }
    //payable函数允许合约接收以太币，msg.value表示发送的以太币数量
    //只有标记了 payable，别人才能调用这个函数并顺便给你转钱。如果没有这个词，哪怕代码里写了收钱逻辑，区块链也会拦截这笔交易。
    function depositAmountEther() public payable onlyRegisteredMember {
        //成员存款
        require(msg.value > 0,"Invalid amount.");
        balance[msg.sender] += msg.value;
    }

    function withdrawAmount(uint256 _amount)public onlyRegisteredMember {
        //成员取款
        require(_amount > 0,"Invalid amount.");
        require(balance[msg.sender] >= _amount,"Insufficient balance.");
        balance[msg.sender] -= _amount;
        
    }

    function getBalance(address _member) public view returns (uint256) {
        //查询成员余额
        require(registeredMembers[_member],"Member not registered.");//查询的成员必须是注册过的成员
        require(_member != address(0),"Invalid address.");
        return balance[_member];
        
    }

}