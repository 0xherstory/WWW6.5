// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract EtherPiggyBank {
    //there should be a bank manager who has the certain permissions
    //there should be an array for all members registered and a mapping whther they are registered or not
    //a mapping with there balances
    address public bankManager;
    address[] members;
    mapping (address => bool) registeredMembers;
    mapping (address => uint) balance;

    constructor() {
        bankManager = msg.sender;
        members.push(msg.sender);
    }

    modifier onlyBankManager() {
        require(msg.sender == bankManager, "Only bank manager can perform this action");
        _;
    }

    modifier onlyRegisteredMembers() {
        require(registeredMembers[msg.sender], "Member not registered");
        _;
    }

    function addMembers (address _member) public onlyBankManager {
        require(_member != address(0), "Invalid adress");
        require(_member !=msg.sender, "Bank Manager is already a member");
        require(!registeredMembers[_member], "Member already registered");
        registeredMembers[_member] = true;
        members.push(_member);
    }

    function getMembers() public view returns(address[] memory) {
        return members;
    }

    //deposit amount 
    // function depositAmount(uint256 _amount) public onlyRegisteredMember{
    //     require(_amount > 0, "Invalid amount");
    //     balance[msg.sender] = balance[msg.sender]+_amount;
   
    // }

    //Deposit in Ether
    function depositAmountEther() public payable onlyRegisteredMembers {
        require(msg.value > 0, "Must send some Ether");
        balance[msg.sender] += msg.value;
    }

    //Withdraw in Ether
    function withdrawAmountEther(uint _amount) public onlyRegisteredMembers {
        require(_amount > 0, "Withdraw amount must be greater than 0");
        require(balance[msg.sender] >= _amount, "Insufficient amount");
        balance[msg.sender] -= _amount;
        (bool success, ) = payable(msg.sender).call{value: _amount}("");
        require(success, "Transfer failed");
    }

    function getBalance(address _member) public view returns(uint) {
        require(_member != address(0), "Invalid address");
        return balance[_member];
    }

    receive() external payable { }
}