// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;


contract EtherPiggyBank {
    address public bankManager;
    address[] members;
    mapping(address => bool) public registeredMembers;
    mapping(address => uint256) balance;


    constructor() {
        bankManager = msg.sender;
        registeredMembers[msg.sender] = true;
        members.push(msg.sender);

    }

    modifier OnlyBankManager() {
        require(bankManager == msg.sender, "only bank manager can perform this action");
        _;

    }

    modifier OnlyRegisteredMember() {
        require(registeredMembers[msg.sender], "member is not registered");
        _;

    }



    function addMembers(address _member) public OnlyBankManager {
        require(_member != address(0), "invalid address");
        require(_member != msg.sender, "bank manager is already a member");
        require(!registeredMembers[_member], "Member already registered");

        registeredMembers[_member] = true;
        members.push(_member);
    }

    function getMembers() public view returns (address[] memory) {
        return members;
    }

    function depositAmount(uint256 _amount) public OnlyRegisteredMember {
        require(_amount > 0, "Invalid amount");
        balance[msg.sender] += _amount;
    }

    function depositEther() public payable OnlyRegisteredMember {
        require(msg.value > 0, "Invalid amount");
        balance[msg.sender] += msg.value;
    }

    function withdraw(uint256 _amount) public OnlyRegisteredMember {
        require(_amount > 0, "Invalid amount");
        require(balance[msg.sender] >= _amount, "Insufficient balance");
        balance[msg.sender] -= _amount;

    }


    function getBalance(address _member) public view returns (uint256) {
        require(_member != address(0), "invalid address");
        return balance[_member];
    }



}