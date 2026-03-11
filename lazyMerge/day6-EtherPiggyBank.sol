 // SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract EtherPiggyBank {
    address public bankManager; // 银行经理
    address[] members; // 成员列表
    mapping(address => bool) public registeredMembers; // 成员是否是注册会员
    mapping(address => uint256) balance; // 成员-余额
    mapping(address => uint256) ethBalance; // eth-成员-余额

    constructor() {
        bankManager =  msg.sender;
        members.push(msg.sender);
        registeredMembers[msg.sender] = true;
    }

    // 校验权限
    modifier onlyBankManager() {
        require(msg.sender == bankManager, "Only bank manager can perform this action");
        _;
    }

    modifier onlyMember() {
        require(registeredMembers[msg.sender], "Member not registered");
        _;
    }

    // 添加会员（管理员权限）
    function addMembers(address _member) public onlyBankManager {
        // 必须-有效地址
        require(_member != address(0), "Invalid member address");
        // 必须-不是管理员，管理员无须重复添加
        require(_member != bankManager, "Bank Manager is already a member");
        // 必须-没有注册过会员
        require(!registeredMembers[_member], "Member already registered");
        registeredMembers[_member] = true;
        members.push(_member);

    }

    // 查看会员列表（开放）
    // 返回动态数组，需要显式声明数据位置 address[] 后面需要添加 【memory】
    function getMembers() public view returns(address[] memory) {
        return members;
    }

    // 存钱
    function deposit(uint256 _amount) public onlyMember {
        // 必须-金额大于 0
        require(_amount > 0, "Invalid amount");
        balance[msg.sender] += _amount;
    }

    // 存款-eth
    function depositEth() public payable onlyMember {
        require(msg.value > 0, "Invalid amount");
        ethBalance[msg.sender] += msg.value;
    }

    // 取钱
    function withdraw(uint256 _amount) public onlyMember {
        require(_amount > 0, "Invalid amount");
        // 余额必须大于取款金额
        require(balance[msg.sender] >= _amount, "Insufficient balance");
        balance[msg.sender] -= _amount;
    }

    // 取钱-eth
    function withdrawEth(uint256 _amount) public onlyMember {
        require(_amount > 0, "Invalid amount");
        // 余额必须大于取款金额
        require(ethBalance[msg.sender] >= _amount, "Insufficient balance");
        ethBalance[msg.sender] -= _amount;
        // 取钱
        payable(msg.sender).transfer(_amount);
    }

    // 获取余额
    function getBalance(address _member) public view returns (uint256){
        require(_member != address(0), "Invalid address");
        return balance[_member];
    } 
}