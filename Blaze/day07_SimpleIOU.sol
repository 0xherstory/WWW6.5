// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
contract SimpleIOU {

    address public owner;
    //是否允许某人使用合约
    mapping(address => bool) public registeredFriends;
    //群组成员地址列表
    address[] public friendList;
    //谁拥有多少
    mapping (address => uint256) public balances;
    //欠债映射
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


    //合约拥有者可以添加朋友
    function addFriend(address _friend) public onlyOwner {
        require(_friend != address(0), "Invalid address");
        require(!registeredFriends[_friend], "Friend already registered");

        registeredFriends[_friend] = true;
        friendList.push(_friend);
    }

    //真实eth存钱
    function depositIntoWallet() public payable onlyRegistered {
        require(msg.value > 0, "Must send ETH");
        balances[msg.sender] += msg.value;
    }

    //记录偿还债务的协议(出借人调用)
    function recordDebt(address _debtor, uint256 _amount) public onlyRegistered {
        require(_debtor != address(0), "Invalid address");
        require(registeredFriends[_debtor], "Address not registered");
        require(_amount > 0, "Amount must be greater than 0");
        debts[_debtor][msg.sender] += _amount;
    }

    //余额变动协议(还款人调用)
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

    //还款人调用(真实转账)
    function transferEther(address payable _to, uint256 _amount) public onlyRegistered {
        require(_to != address(0), "Invalid address");
        require(registeredFriends[_to], "Recipient not registered");
        require(balances[msg.sender] >= _amount, "Insufficient balance");

        balances[msg.sender] -= _amount;
        _to.transfer(_amount);
        balances[_to] += _amount;
    }

    //转账优化，采用call
    function transferEtherViaCall(address payable _to, uint256 _amount) public onlyRegistered {
        require(_to != address(0), "Invalid address");
        require(registeredFriends[_to], "Recipient not registered");
        require(balances[msg.sender] >= _amount, "Insufficient balance");
        balances[msg.sender] -= _amount;
        (bool success, ) = _to.call{value: _amount}("");
        balances[_to] += _amount;
        require(success, "Transfer failed");
    }

    //从合约中取出eth
    function withdraw(uint256 _amount) public onlyRegistered {
        require(balances[msg.sender] >= _amount, "Insufficient balance");
        balances[msg.sender] -= _amount;
        (bool success, ) = payable(msg.sender).call{value: _amount}("");
        require(success, "Withdrawal failed");
    }

    //查看系统中余额 
    function checkBalance() public view onlyRegistered returns (uint256) {
        return balances[msg.sender];
    }

















}