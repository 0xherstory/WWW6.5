//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

//我对这个合约的理解，类似于支付宝的小荷包
contract EtherPiggyBank{

    address public bankManager;
    address[] members;
    mapping(address => bool) public registeredMembers;
    mapping(address => uint256) balance;

    constructor(){
        bankManager = msg.sender;//指谁部署的这个合约，即负责人银行经理部署了这个合约
        members.push(msg.sender);//".push"指往数组的最后一位添加一个新的元素，即往名为"members"的数组的最后面，添加一个msg.sender
        //把 msg.sender（调用合约的人）放进 members 队伍的最后。这样bankmanager就是第一个成员了
    }

    //下面两个修饰符作用是制定规则
    modifier onlyBankManager(){
        require(msg.sender == bankManager, "Only bank manager can perform this action");
        _;
    }

    modifier onlyRegisteredMember() {
        require(registeredMembers[msg.sender], "Member not registered");
        //"registeredMembers[msg.sender]"去 registeredMembers 这本字典里查一下，调用者这个人是不是 TRUE
        _;
    }
  
    //函数——增加成员
    //一个叫做addmembers的函数。接收一个传入参数，没有返回参数
    function addMembers(address _member)public onlyBankManager{ //这里的"onlyBankManager"是上面的修饰符，即限制规则。 这里只有银行经理有权限添加人员，所以要加上限制条件
        require(_member != address(0), "Invalid address");
        //address(0) 这个是计算机认识的，是一个特殊地址，通常表示“空/未设置”。把它加入成员会造成逻辑混乱，容易带来安全或可用性问题。
        //！ 表示逻辑相反
        //检查待添加成员的地址是否有效
        require(_member != msg.sender, "Bank Manager is already a member");
        //检查银行经理有没有重复添加自己
        require(!registeredMembers[_member], "Member already registered");
        //价差该成员是否已经存在
        registeredMembers[_member] = true;
        //把新成员在“registeredMembers”的映射表格中，标记为true
        members.push(_member);
        //把新成员添加到“ members”的数组中
    }

    //函数——查看成员列表
    //一个叫做getmembers的函数，不接受传入参数，返回一个参数
    //"view"表示只读取，不消耗gas
    function getMembers() public view returns(address[] memory){
        return members;
    }
    
    //函数——存款（可接受以太币）
    //"payable" 用来标记这个函数可以用来接受以太币
    //一个叫做depositAmountEther的函数，没有传入参数，没有返回参数，可以接受以太币，有一个限制即只有注册成员可以调用
    //注意：虽然此函数没有返回参数，但以太币ETH是通过"msg.value"传进来的
    function depositAmountEther() public payable onlyRegisteredMember{  
        require(msg.value > 0, "Invalid amount");//msg.value=本次交易发送到合约的ETH数量
        balance[msg.sender] = balance[msg.sender]+msg.value;
   
    }
    
    //函数——取钱
    //一个叫做 withdrawAmount的函数，接收一个传入参数，没有返回参数，受onlyRegisteredMember限制
    function withdrawAmount(uint256 _amount) public onlyRegisteredMember{
        require(_amount > 0, "Invalid amount");
        require(balance[msg.sender] >= _amount, "Insufficient balance");
        balance[msg.sender] = balance[msg.sender]-_amount;
   
    }

    //函数——查询余额
    //一个叫做getBalance的函数，接收一个传入参数，有一个返回参数
    function getBalance(address _member) public view returns (uint256){
        require(_member != address(0), "Invalid address");
        return balance[_member];
    } 
}