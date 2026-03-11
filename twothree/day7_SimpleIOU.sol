//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleIOU {
    address public owner;
    mapping(address => bool) public registeredFriends;
    address[] public friendList;
    mapping(address => uint256) public balances;
    mapping(address => mapping(address => uint256)) public debts;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Not the owner");
        _;
    }

    modifier onlyRegistered() {
        require(registeredFriends[msg.sender], "Not registered");
        _;
    }

    function addFriend(address _friend) public onlyOwner {
        require(!registeredFriends[_friend], "Already registered");
        registeredFriends[_friend] = true;
        friendList.push(_friend);
    }

    function depositIntoWallet() public payable onlyRegistered {
        balances[msg.sender] += msg.value;
    }

    function recordDebt(address _creditor, uint256 _amount) public onlyRegistered {
        require(registeredFriends[_creditor], "Creditor is not registered");
        require(balances[msg.sender] >= _amount,"Insufficient balance");
        require(_amount > 0, "Amount must be greater than 0");
        
        balances[msg.sender] -= _amount;
        (bool success, ) = payable(_creditor).call{value: _amount}("");
        require(success, "Transfer failed");
        debts[msg.sender][_creditor] += _amount;
    }
    

    function transeferEtherViacall(address payable _to, uint256 _amount) public onlyRegistered {
        require(balances[msg.sender] > _amount, "Insufficient balance");
        balances[msg.sender] -= _amount;

        (bool success, ) = _to.call{value: _amount}("");
        require(success, "Transfer failed");
        }

    function withdraw(uint256 _amount) public onlyRegistered {
        require(balances[msg.sender] > _amount, "Insufficient balance");
        balances[msg.sender] -= _amount;

        (bool success, ) = payable(msg.sender).call{value: _amount}("");
        require(success, "Trancfer failed");
    }

     function registerCreditor(address creditorAddress) public {
        require(creditorAddress != address(0), "Creditor address cannot be zero");
        require(!registeredFriends[creditorAddress], "Creditor is already registered");
        
        registeredFriends[creditorAddress] = true;
        friendList.push(creditorAddress);
    }




    function payFromWallet(address payable _recipient, uint256 _amount) public onlyRegistered {
        require(_amount > 0, "Amount must be greater than 0");
        require(registeredFriends[_recipient], "Recipient is not registered");
        require(balances[msg.sender] >= _amount, "Insufficient wallet balance");

        balances[msg.sender] -= _amount;

        (bool success, ) = _recipient.call{value: _amount}("");
        require(success, "Payment transfer failed");
    }


}