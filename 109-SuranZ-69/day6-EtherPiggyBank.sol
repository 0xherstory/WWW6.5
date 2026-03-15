// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract EtherPiggyBank { //存钱罐
    //定义一个银行经理角色——拥有管理员权限
    address public bankManager;
    //定义成员——有权使用这个存钱罐
    address[] members; //数组，保存所有加入的成员
    mapping (address => bool) public registeredMembers; //映射，快速检查某人是否被批准为成员
    //每位成员存了多少钱
    mapping (address => uint256) balance;

    //构造函数
    constructor () {
        bankManager = msg.sender;
        members.push (msg.sender);
    }

    //制定规则权限（modifiers）
    modifier onlyBankManager () {
        require (msg.sender == bankManager, "Only bank manager can perform this action.");
        _;
    }
    modifier onlyRegisteredMember () {
        require (registeredMembers[msg.sender], "Member not registered.");
        _;
    }

    //添加新成员
    function addMembers (address _member) public onlyBankManager {
        require (_member != address (0), "Invalid address."); //新成员地址必须有效
        require (_member != msg.sender, "Bank Manager is already a member."); //新成员不能是经理自己
        require (!registeredMembers[_member], "Member already registered."); //新成员不能已经存在
        registeredMembers[_member] = true;
        members.push (_member);
    }

    //查看成员列表
    function getMembers() public view returns (address[] memory) {
        return members;
    }

    //存款（模拟储蓄）
    function deposit (uint256 _amount) public onlyRegisteredMember {
        require (_amount >0, "Invalid amount.");
        balance[msg.sender] += _amount;
    }

    //取钱（模拟）
    function withdraw (uint256 _amount) public onlyRegisteredMember {
        require (_amount > 0, "Invalid amount.");
        require (balance[msg.sender] >= _amount, "Insufficient balance."); //要取的数额必须小于该成员已存的数额
        balance[msg.sender] -= _amount;
    }

    //引入真正的以太币到上述模拟环节——新版本的存款函数
    function depositAmountEther() public payable onlyRegisteredMember {
        require (msg.value > 0, "Invalid amount."); //payable表示该函数可接收以太币
        balance[msg.sender] += msg.value; //msg.value表示用户在交易中发送的以太币数量（单位是wei）
    }

    //新的取现函数（引入以太币）
    function withdrawAmountEther () public payable onlyRegisteredMember {
        require (msg.value > 0, "Invalid amount.");
        require (balance[msg.sender] >= msg.value, "Insufficient balance.");
        balance[msg.sender] -= msg.value;
    }
}