// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleIOU{
    address public owner;//合约拥有者
    mapping(address => bool) public registeredFriends;//已注册朋友
    address[] public friendList;//朋友列表
    mapping(address => uint256) public balances; // 合约内余额
    mapping(address => mapping(address => uint256)) public debts; // 债务人→债权人→金额

    
    // 仅部署合约的人可调用
    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can perform this action");
        _;
    }
    
    // 仅注册的好友可调用
    modifier onlyRegistered() {
        require(registeredFriends[msg.sender], "You are not registered");
        _;
    }
    
    // 添加注册朋友（部署合约人）
    function addFriend(address _friend) public onlyOwner {
        require(_friend != address(0), "Invalid address");
        require(!registeredFriends[_friend], "Friend already registered");
        
        registeredFriends[_friend] = true;
        friendList.push(_friend);
    }
    
    // 存入ETH到合约钱包
    function depositIntoWallet() public payable onlyRegistered {
        require(msg.value > 0, "Must send ETH");
        balances[msg.sender] += msg.value;
    }
    
    // 记录他人欠自己的债务
    function recordDebt(address _debtor, uint256 _amount) public onlyRegistered {
        require(_debtor != address(0), "Invalid address");
        require(registeredFriends[_debtor], "Address not registered");
        require(_amount > 0, "Amount must be greater than 0");
        
        debts[_debtor][msg.sender] += _amount;
    }
    
    // 用合约余额偿还债务
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
    
    // 用transfer转ETH给他人
    function transferEther(address payable _to, uint256 _amount) public onlyRegistered {
        require(_to != address(0), "Invalid address");
        require(registeredFriends[_to], "Recipient not registered");
        require(balances[msg.sender] >= _amount, "Insufficient balance");
        balances[msg.sender] -= _amount;
        _to.transfer(_amount);
        balances[_to]+=_amount;
    }
    
    // 用call转ETH给他人
    function transferEtherViaCall(address payable _to, uint256 _amount) public onlyRegistered {
        require(_to != address(0), "Invalid address");
        require(registeredFriends[_to], "Recipient not registered");
        require(balances[msg.sender] >= _amount, "Insufficient balance");
        
        balances[msg.sender] -= _amount;
        (bool success, ) = _to.call{value: _amount}("");
        balances[_to]+=_amount;
        require(success, "Transfer failed");
    }
    
    // 提取合约内余额到钱包
    function withdraw(uint256 _amount) public onlyRegistered {
        require(balances[msg.sender] >= _amount, "Insufficient balance");
        
        balances[msg.sender] -= _amount;
        (bool success, ) = payable(msg.sender).call{value: _amount}("");
        require(success, "Withdrawal failed");
    }
    
    // 查看自身合约余额
    function checkBalance() public view onlyRegistered returns (uint256) {
        return balances[msg.sender];
    }
