//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract simpleIOU {
    address public owner;

    //追踪已注册好友
    mapping(address => bool) public registeredFriends;
    address[] public friendList;//代表我告诉电脑有一个变量，是公开的名为friendList的地址数组

    //追踪金额
    mapping(address => uint256) public balances;

    mapping(address => mapping(address => uint256)) public debts;
    //首先，厘清mapping（address => uint256）返回的是一个数字，是被“借钱人”欠“被借钱人”多少钱
    //第二，address => mapping(address => uint256)就是 借钱人=>欠了多少钱
    //最后，把这些欠款信息都放在“debts”这个表里

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

    function addFriend(address _friend) public onlyOwner {
        require(_friend != address(0), "Invalid address");//确认地址存在
        require(!registeredFriends[_friend], "Friend already registered");//确认非反复注册
        
        registeredFriends[_friend] = true;
        friendList.push(_friend);
    }


    function depositIntoWallet() public payable onlyRegistered {
        require(msg.value > 0, "Must send ETH");
        balances[msg.sender] += msg.value;//把钱存到该合约里的个人账本里
    }

    //记录debtor欠我钱
    function recordDebt(address _debtor, uint256 _amount) public onlyRegistered {
        require(_debtor != address(0), "Invalid address");
        require(registeredFriends[_debtor], "Address not registered");
        require(_amount > 0, "Amount must be greater than 0");
        
        debts[_debtor][msg.sender] += _amount;//debtor欠了msg.sender的钱，加上了这部分钱等于_amount
    }

    //用合约内部的钱还款
    function payFromWallet(address _creditor, uint256 _amount) public onlyRegistered {
        require(_creditor != address(0), "Invalid address");
        require(registeredFriends[_creditor], "Creditor not registered");
        require(_amount > 0, "Amount must be greater than 0");
        require(debts[msg.sender][_creditor] >= _amount, "Debt amount incorrect");
        require(balances[msg.sender] >= _amount, "Insufficient balance");
    
        // 更新余额以及债务
        balances[msg.sender] -= _amount;
        balances[_creditor] += _amount;
        debts[msg.sender][_creditor] -= _amount;
    }

    function transferEther(address payable _to, uint256 _amount) public onlyRegistered {
        require(_to != address(0), "Invalid address");
        require(registeredFriends[_to], "Recipient not registered");
        require(balances[msg.sender] >= _amount, "Insufficient balance");
        balances[msg.sender] -= _amount;
        _to.transfer(_amount);
        balances[_to]+=_amount;
    }
    

    function transferEtherViaCall(address payable _to, uint256 _amount) public onlyRegistered {
        require(_to != address(0), "Invalid address");
        require(registeredFriends[_to], "Recipient not registered");
        require(balances[msg.sender] >= _amount, "Insufficient balance");
        
        balances[msg.sender] -= _amount;
        
        (bool success, ) = _to.call{value: _amount}("");
        balances[_to]+=_amount;
        require(success, "Transfer failed");
    }

    function withdraw(uint256 _amount) public onlyRegistered {
        require(balances[msg.sender] >= _amount, "Insufficient balance");
        
        balances[msg.sender] -= _amount;
        
        (bool success, ) = payable(msg.sender).call{value: _amount}("");
        require(success, "Withdrawal failed");
    }
    
    function checkBalance() public view onlyRegistered returns (uint256) {
        return balances[msg.sender];
    }
    
}