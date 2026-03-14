// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract DepositAndWallet {
    address owner;
    mapping (address => bool) public registeredFriends;
    address[] friends;
    mapping (address => uint256) public balances;
    mapping(address => mapping (address => uint256)) public debts;

    constructor() {
        owner = msg.sender;
        registeredFriends[owner] = true;
        friends.push(owner);
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can perform this action");
        _;
    }
    modifier onlyFriend() {
        require(registeredFriends[msg.sender], "Only friends can perform this action");
        _;
    }

    function addFirend(address _friend) public onlyOwner {
        require(_friend != address(0), "Invalid address");
        require(!registeredFriends[_friend], "This friend has already been registered");
        registeredFriends[_friend] = true;
        friends.push(_friend);
    }

    function depositIntoWallet(uint256 _amount) public onlyFriend {
        require(_amount > 0, "Invalid amount");
        balances[msg.sender] += _amount;
    }
    function recordDebt(address _friend, uint256 _amount) public onlyFriend {
        require(_friend != address(0), "Invalid address");
        require(registeredFriends[_friend], "This friend is not registered");
        require(_amount > 0, "Invalid amount");
        debts[_friend][msg.sender] += _amount;
    }
     
    function payFromWallet(address _creditor, uint256 _amount) public onlyFriend {
        require(_creditor != address(0), "Invalid address");
        require(registeredFriends[_creditor], "Creditor not registered");
        require(_amount > 0, "Amount must be greater than 0");
        require(debts[msg.sender][_creditor] >= _amount, "Debt amount incorrect");
        require(balances[msg.sender] >= _amount, "Insufficient balance");

        balances[msg.sender] -= _amount;
        balances[_creditor] += _amount;
        debts[msg.sender][_creditor] -= _amount;
    }
    function transferEther(address payable _recipient, uint256 _amount) public onlyFriend {
        require(_recipient != address(0), "Invalid address");
        require(registeredFriends[_recipient], "Recipient not registered");
        require(_amount > 0, "Amount must be greater than 0");
        require(balances[msg.sender] >= _amount, "Insufficient balance");

        balances[msg.sender] -= _amount;
        _recipient.transfer(_amount);
        balances[_recipient] += _amount;
    }

    function transferEtherViaCall(address payable _to, uint256 _amount) public onlyFriend {
        require(_to != address(0), "Invalid address");
        require(registeredFriends[_to], "Recipient not registered");
        require(balances[msg.sender] >= _amount, "Insufficient balance");

        balances[msg.sender] -= _amount;

        (bool success, ) = _to.call{value: _amount}("");
        balances[_to] += _amount;
        require(success, "Transfer failed");
    }
     
    function withdraw(uint256 _amount) public onlyFriend {
        require(balances[msg.sender] >= _amount, "Insufficient balance");

        balances[msg.sender] -= _amount;

        (bool success, ) = payable(msg.sender).call{value: _amount}("");
        require(success, "Withdrawal failed");
    }

     
    function checkBalance() public view onlyFriend returns (uint256) {
        return balances[msg.sender];
    }
}