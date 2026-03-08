//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleIOU{
    address public owner;//定义群组的管理员

    mapping(address => bool) public registeredFriends;//检查是否允许某人使用此合约
    address[] public friendList;//记录群组成员的地址
    
    mapping(address => uint256) public balances;
    
    mapping(address => mapping(address => uint256)) public debts; //嵌套。还是不太理解
    
    constructor() {
        owner = msg.sender;
        registeredFriends[msg.sender] = true;
        friendList.push(msg.sender);
    }
    
    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can perform this action");
        _;
    }
    
    modifier onlyRegistered() {
        require(registeredFriends[msg.sender], "You are not registered");
        _;
    }
    
    //函数-添加好友
    //一个叫做addfriend的函数，接收一个传入参数，没有返回参数，受onlyowner的限制
    function addFriend(address _friend) public onlyOwner {
        require(_friend != address(0), "Invalid address");//检查加入的好友的地址是否有效
        require(!registeredFriends[_friend], "Friend already registered");//不能重复注册
        
        registeredFriends[_friend] = true;
        friendList.push(_friend);//把一个新地址变成“已注册朋友”并加入 friendList
    }
    
    //函数-将每个好友的钱，都充到钱包里
    //一个叫做depositIntowallet的函数，不接收传入参数，没有返回参数，受onlyregistered的限制
    function depositIntoWallet() public payable onlyRegistered {//payabe表明此函数可以用来接收以太币
        require(msg.value > 0, "Must send ETH");//"msg.value"指这次交易附带的ETH数量。
        balances[msg.sender] += msg.value;
    }
    
    //函数-钱包记录欠款，即例如A好友欠B好友的钱
    //一个叫做recorddebt的函数，接收两个传入参数，没有返回参数，受onlyRegistered限制
    function recordDebt(address _debtor, uint256 _amount) public onlyRegistered {
        require(_debtor != address(0), "Invalid address");//debtor即欠钱的人
        require(registeredFriends[_debtor], "Address not registered");
        require(_amount > 0, "Amount must be greater than 0");
        
        debts[_debtor][msg.sender] += _amount;
        //“debts"是个双层嵌套；
        //debts[A][B] 即A欠B多少钱
        //"_debts" 即欠钱的人； "meg.sender"即这次调用函数的人，也就是债主
    }
    
    //函数-在钱包内部，A好友直接自动还B好友的钱（内部余额还债）
    //creditor 债权人
    function payFromWallet(address _creditor, uint256 _amount) public onlyRegistered {
        require(_creditor != address(0), "Invalid address");
        require(registeredFriends[_creditor], "Creditor not registered");
        require(_amount > 0, "Amount must be greater than 0");
        require(debts[msg.sender][_creditor] >= _amount, "Debt amount incorrect");
        require(balances[msg.sender] >= _amount, "Insufficient balance");
        
        balances[msg.sender] -= _amount;
        balances[_creditor] += _amount;
        debts[msg.sender][_creditor] -= _amount;
    }

    //函数-钱包余额转出
    function transferEther(address payable _to, uint256 _amount) public onlyRegistered {
        require(_to != address(0), "Invalid address");
        require(registeredFriends[_to], "Recipient not registered");
        require(balances[msg.sender] >= _amount, "Insufficient balance");
        balances[msg.sender] -= _amount;
        _to.transfer(_amount);
        balances[_to]+=_amount;
    }

    //函数-钱包转账
    function transferEtherViaCall(address payable _to, uint256 _amount) public onlyRegistered {
        require(_to != address(0), "Invalid address");
        require(registeredFriends[_to], "Recipient not registered");
        require(balances[msg.sender] >= _amount, "Insufficient balance");
        
        balances[msg.sender] -= _amount;
        
        (bool success, ) = _to.call{value: _amount}("");
        balances[_to]+=_amount;
        require(success, "Transfer failed");
    }

    //函数-提现
    function withdraw(uint256 _amount) public onlyRegistered {
        require(balances[msg.sender] >= _amount, "Insufficient balance");
        
        balances[msg.sender] -= _amount;
        
        (bool success, ) = payable(msg.sender).call{value: _amount}("");
        require(success, "Withdrawal failed");
    }

    //函数-查询钱包余额
    function checkBalance() public view onlyRegistered returns (uint256) {
        return balances[msg.sender];
    }
}