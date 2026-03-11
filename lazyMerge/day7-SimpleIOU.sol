// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleIOU {
    // 管理员
    address public owner;
    // 是否注册朋友
    mapping(address => bool) public registeredFriends;
    // 朋友列表
    address[] public friendLists;

    // 朋友余额
    mapping(address => uint256) public balances;
    // 跟踪债务流转 debts[debtor][creditor] = amount;
    mapping(address => mapping(address => uint256)) public debts; 

    constructor() {
        owner = msg.sender;
        registeredFriends[msg.sender] = true;
        friendLists.push(msg.sender);
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can perform this action");
        _;
    }
    modifier onlyRegistered() {
        require(registeredFriends[msg.sender], "You are not registered");
        _;
    }

    // 添加朋友
    function addFriend(address _address) public onlyOwner {
        // 必须-合法地址
        require(_address != address(0), "Invalid address");
        // 必须-没有注册
        require(!registeredFriends[_address], "Already registered");
        friendLists.push(_address);
        registeredFriends[_address] = true;
    }

    // 存钱
    function depositIntoWallet() public payable onlyRegistered{
        require(msg.value >0, "Must send greater than 0 ETH");
        balances[msg.sender] += msg.value;
    }

    // 记录债务 入参：地址，金额
    function recordDebt(address _debter, uint256 _amount) public onlyRegistered {
        require(_debter != address(0), "Invalid address");
        require(registeredFriends[_debter], "Address not registered");
        require(_amount > 0, "Amount must be greater than 0");
        debts[_debter][msg.sender] += _amount;
    }

    // 偿还债务 入参：地址，金额
    function payFromWallet(address _creditor, uint256 _amount) public onlyRegistered {
        require(_creditor != address(0), "Invalid address");
        require(registeredFriends[_creditor], "creditor not registered");
        require(_amount > 0, "Amount must be greater than 0");
        require(debts[msg.sender][_creditor] >= _amount, "Debt amount incorrect");
        require(balances[msg.sender] >= _amount, "Insufficient balance");

        balances[msg.sender] -=  _amount;
        balances[_creditor] += _amount;
        debts[msg.sender][_creditor] -= _amount;
    }

    // 划转 Eth: transfer：将 ETH 发送到 钱包
    function transferEth(address payable _to, uint256 _amount) public onlyRegistered {
        require(_to != address(0), "Invalid address");
        require(registeredFriends[_to], "Recipient not registered");
        require(balances[msg.sender] >= _amount, "Insufficient balance");
        balances[msg.sender] -= _amount;

        // transfer 有 2300 gas 限制 —— 刚好足以接收 ETH
        _to.transfer(_amount);

        // 下面代码不应该执行，因为已经发送真实 ETH，账户的余额不应该添加
        // balances[_to] += _amount;
    }

    // 出金
    function withdraw(uint256 _amount) public onlyRegistered {
        require(balances[msg.sender] >= _amount, "Insufficient balance");

        balances[msg.sender] -= _amount;

        // msg.sender.transfer(_amount);
        // 用  call 检查是否成功 比 transfer 更好，不会限制 gas
        (bool success,) = payable(msg.sender).call{value: _amount}("");
        require(success, "Withdrawal failed");
    }


    // 检查余额
    function checkBalance() public view onlyRegistered returns (uint256) {
        return balances[msg.sender];
    }
}