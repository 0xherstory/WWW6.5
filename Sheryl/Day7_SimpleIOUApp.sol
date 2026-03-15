// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleIOU {
    address public owner;

    // Track registered friends
    mapping (address => bool) public registeredFriends;
    address[] public friendList;

    //Track balance
    mapping (address => uint) public balances;

    //Simple dets tracking
    mapping (address => mapping (address => uint)) public debts;

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

    //Register a new friend
    function addFriend(address _friend) public onlyOwner {
        require(_friend != address(0), "Invalid adress");
        require(!registeredFriends[_friend], "Friend already registered");

        registeredFriends[_friend] = true;
        friendList.push(_friend);
    }

    //Deposit funds to your wallet
    function depositIntoWallet() public payable onlyRegistered {
        require(msg.value > 0, "Must send ETH");
        balances[msg.sender] += msg.value;
    }

    //Record that someone owes you money
    function recordDebt(address _debter, uint256 _amount) public onlyRegistered {
        require(_debter != address(0), "Invalid adress");
        require(registeredFriends[_debter], "Address not registered");
        require(_amount > 0 ,"Amount must be greater than 0" );

        debts[_debter][msg.sender] += _amount;
    }

    // Pay off debt using your internal balance transfer
    // No ETH leaves the contract. It merely moves internally between the users' balances.
    function payFromWallet(address _creditor, uint _amount) public onlyRegistered {
        require(_creditor != address(0), "Invalid adress");
        require(registeredFriends[_creditor], "Creditor not registered");
        require(_amount > 0 ,"Amount must be greater than 0" );
        require(debts[msg.sender][_creditor] >= _amount, "Debt amount incorrect");
        require(balances[msg.sender] >= _amount, "Insufficient balance");

        //Update balance and debt
        balances[msg.sender] -= _amount;
        balances[_creditor] += _amount;
        debts[msg.sender][_creditor] -= _amount;
    }

    // Directly sending ETH Using transfer()
    function transferEther(address payable _to, uint _amount) public onlyRegistered {
        require(_to != address(0), "Invalid address");
        require(registeredFriends[_to], "Recipient not registered");
        require(balances[msg.sender] >= _amount, "Insufficient balance");

        balances[msg.sender] -= _amount;
        _to.transfer(_amount);  //recipientAddress.transfer(amount);
        balances[_to] += _amount;
    }

    // Alternative transfer method using call()
    function transferEtherViaCall(address payable _to, uint _amount) public onlyRegistered {
        require(_to != address(0), "Invalid address");
        require(registeredFriends[_to], "Recipient not registered");
        require(balances[msg.sender] >= _amount, "Insufficient balance");

        balances[msg.sender] -= _amount;
        (bool success, ) = _to.call{value: _amount}("");    //
        balances[_to] += _amount;
        require(success, "Transfer failed");
    }   

    // Withdraw your balance
    function withdrawBalance(uint _amount) public onlyRegistered {
        require(balances[msg.sender] > 0, "Insufficient balance");

        balances[msg.sender] -= _amount;
        (bool success, ) = payable(msg.sender).call{value: _amount}("");
        require(success, "Withdraw failed");
    }

    //Check your balance
    function checkBalance() public onlyRegistered view returns(uint) {
        return balances[msg.sender];
    } 
}