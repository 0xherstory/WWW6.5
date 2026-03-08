//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleIOU{
    address public owner;
    
    // 记录已注册的好友
    mapping(address => bool) public registeredFriends;
    address[] public friendList;
    
    // 记录每个地址的钱包余额
    mapping(address => uint256) public balances;
    
    // 简单的债务记录
    // debts[债务人][债权人] = 欠款金额
    mapping(address => mapping(address => uint256)) public debts;
    
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
    
    // 添加一个新的好友（只有 owner 可以添加）
    function addFriend(address _friend) public onlyOwner {
        require(_friend != address(0), "Invalid address");
        require(!registeredFriends[_friend], "Friend already registered");
        
        registeredFriends[_friend] = true;
        friendList.push(_friend);
    }
    
    // 向自己的钱包余额中存入 ETH
    function depositIntoWallet() public payable onlyRegistered {
        require(msg.value > 0, "Must send ETH");
        balances[msg.sender] += msg.value;
    }
    
    // 记录某人欠你的钱（建立债务关系）
    function recordDebt(address _debtor, uint256 _amount) public onlyRegistered {
        require(_debtor != address(0), "Invalid address");
        require(registeredFriends[_debtor], "Address not registered");
        require(_amount > 0, "Amount must be greater than 0");
        
        debts[_debtor][msg.sender] += _amount;
    }
    
    // 使用内部钱包余额偿还债务
    function payFromWallet(address _creditor, uint256 _amount) public onlyRegistered {
        require(_creditor != address(0), "Invalid address");
        require(registeredFriends[_creditor], "Creditor not registered");
        require(_amount > 0, "Amount must be greater than 0");
        require(debts[msg.sender][_creditor] >= _amount, "Debt amount incorrect");
        require(balances[msg.sender] >= _amount, "Insufficient balance");
        
        // 更新余额和债务记录
        balances[msg.sender] -= _amount;
        balances[_creditor] += _amount;
        debts[msg.sender][_creditor] -= _amount;
    }
    
    // 使用 transfer() 方法进行 ETH 转账
    function transferEther(address payable _to, uint256 _amount) public onlyRegistered {
        require(_to != address(0), "Invalid address");
        require(registeredFriends[_to], "Recipient not registered");
        require(balances[msg.sender] >= _amount, "Insufficient balance");
        
        balances[msg.sender] -= _amount;
        _to.transfer(_amount);
        balances[_to] += _amount;
    }
    
    // 使用 call() 方法进行 ETH 转账（另一种转账方式）
    function transferEtherViaCall(address payable _to, uint256 _amount) public onlyRegistered {
        require(_to != address(0), "Invalid address");
        require(registeredFriends[_to], "Recipient not registered");
        require(balances[msg.sender] >= _amount, "Insufficient balance");
        
        balances[msg.sender] -= _amount;
        
        (bool success, ) = _to.call{value: _amount}("");
        balances[_to] += _amount;
        require(success, "Transfer failed");
    }
    
    // 从合约中提取自己的余额
    function withdraw(uint256 _amount) public onlyRegistered {
        require(balances[msg.sender] >= _amount, "Insufficient balance");
        
        balances[msg.sender] -= _amount;
        
        (bool success, ) = payable(msg.sender).call{value: _amount}("");
        require(success, "Withdrawal failed");
    }
    
    // 查询自己的余额
    function checkBalance() public view onlyRegistered returns (uint256) {
        return balances[msg.sender];
    }
}
