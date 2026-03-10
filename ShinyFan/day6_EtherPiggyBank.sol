//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract EtherPiggyBank {
    address public bankManager;
    address[] members;
    mapping(address => bool) public registeredMembers;//检索是否注册过
    mapping(address => uint256) balance;//可以查到自己的余额，没有public所以查不到别人的
    //mapping（钥匙 => 需查询的东西）表名

    constructor(){
        bankManager = msg.sender;
        members.push(msg.sender);//将调用函数者加入到members列表中，成为会员
    }

    modifier onlyBankManager(){
        require(msg.sender == bankManager,"Only bank manager can perform this action.");
        _;
    }

    modifier onlyRegisteredMember() {
        require(registeredMembers[msg.sender],"Member not registered.");//因为已经在前面通过mapping将re...定义为表了，所以直接用“表[钥匙]可以直接查”
        _;
    }

    function addMembers(address _member)public onlyBankManager{   //这是一个叫_member的地址参数
        require(_member != address(0), "Invalid address");//保证地址是存在的
        require(_member != msg.sender, "Bank Manager is already a member");//保证这个人不是管理员
        require(!registeredMembers[_member], "Member already registered");//保证这个人还没注册过
        
        registeredMembers[_member] = true;//标记成正式会员
        members.push(_member);

    }

    function getMembers() public view returns(address[] memory){
        return members;
    }
    
    //模拟存钱
    //function deposit(uint256 _amount) public onlyRegisteredMember {
    //    require(_amount > 0, "Invalid amount");
    //    balance[msg.sender] += _amount;
    //}

    function depositAmountEther() public payable onlyRegisteredMember{//有了payable才能真正进行以太币交易
        require(msg.value > 0,"Invalid amount");//msg.value用户交易中的以太币数量
        balance[msg.sender] += msg.value;
    }

    function withdrawAmount(uint256 _amount) public onlyRegisteredMember{
        require(_amount > 0, "Invalid amount");
        require(balance[msg.sender] >= _amount, "Insufficient balance");
        balance[msg.sender] = balance[msg.sender]-_amount;
    }

    function getBalance(address _member) public view returns (uint256){
        require(_member != address(0), "Invalid address");
        return balance[_member];
    }
}