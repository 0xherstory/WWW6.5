// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleIOU {

    address public owner;

    // Registered friends
    mapping(address => bool) public registeredFriends;
    address[] public friendList;

    // Internal wallet balances
    mapping(address => uint256) public balances;

    // Debt tracking: debtor -> creditor -> amount
    mapping(address => mapping(address => uint256)) public debts;

    // Events
    event FriendAdded(address friend);
    event Deposit(address user, uint256 amount);
    event Transfer(address from, address to, uint256 amount);
    event DebtRecorded(address debtor, address creditor, uint256 amount);
    event DebtPaid(address debtor, address creditor, uint256 amount);
    event Withdraw(address user, uint256 amount);

    constructor() {
        owner = msg.sender;
        registeredFriends[msg.sender] = true;
        friendList.push(msg.sender);
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner allowed");
        _;
    }

    modifier onlyRegistered() {
        require(registeredFriends[msg.sender], "Not registered");
        _;
    }

    // Add a new friend
    function addFriend(address _friend) public onlyOwner {
        require(_friend != address(0), "Invalid address");
        require(!registeredFriends[_friend], "Already registered");

        registeredFriends[_friend] = true;
        friendList.push(_friend);

        emit FriendAdded(_friend);
    }

    // Deposit ETH into internal wallet
    function depositIntoWallet() public payable onlyRegistered {
        require(msg.value > 0, "Send ETH");

        balances[msg.sender] += msg.value;

        emit Deposit(msg.sender, msg.value);
    }

    // Record that someone owes you money
    function recordDebt(address _debtor, uint256 _amount) public onlyRegistered {
        require(_debtor != address(0), "Invalid address");
        require(registeredFriends[_debtor], "Debtor not registered");
        require(_amount > 0, "Amount must be > 0");

        debts[_debtor][msg.sender] += _amount;

        emit DebtRecorded(_debtor, msg.sender, _amount);
    }

    // Pay debt using internal wallet balance
    function payFromWallet(address _creditor, uint256 _amount) public onlyRegistered {
        require(_creditor != address(0), "Invalid address");
        require(registeredFriends[_creditor], "Creditor not registered");
        require(_amount > 0, "Amount must be > 0");

        require(debts[msg.sender][_creditor] >= _amount, "Debt too small");
        require(balances[msg.sender] >= _amount, "Insufficient balance");

        balances[msg.sender] -= _amount;
        balances[_creditor] += _amount;

        debts[msg.sender][_creditor] -= _amount;

        emit DebtPaid(msg.sender, _creditor, _amount);
    }

    // Internal transfer between friends (simulation only)
    function transferBalance(address _to, uint256 _amount) public onlyRegistered {
        require(_to != address(0), "Invalid address");
        require(registeredFriends[_to], "Recipient not registered");
        require(balances[msg.sender] >= _amount, "Insufficient balance");

        balances[msg.sender] -= _amount;
        balances[_to] += _amount;

        emit Transfer(msg.sender, _to, _amount);
    }

    // Withdraw ETH from internal wallet
    function withdraw(uint256 _amount) public onlyRegistered {
        require(balances[msg.sender] >= _amount, "Insufficient balance");

        balances[msg.sender] -= _amount;

        (bool success, ) = payable(msg.sender).call{value: _amount}("");
        require(success, "Withdrawal failed");

        emit Withdraw(msg.sender, _amount);
    }

    // Check your balance
    function checkBalance() public view onlyRegistered returns (uint256) {
        return balances[msg.sender];
    }

    // Get all registered friends
    function getFriends() public view returns (address[] memory) {
        return friendList;
    }
}