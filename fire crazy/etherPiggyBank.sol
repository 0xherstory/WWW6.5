// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract EtherPiggyBank {
    address public bankManager;
    address[] public members;
    mapping(address => bool) public registeredMembers;
    mapping(address => uint256) public balance;

    modifier onlyBankManager() {
        require(msg.sender == bankManager, "Only manager!");
        _;
    }

    modifier onlyRegisteredMember() {
        require(registeredMembers[msg.sender], "Member not registered"); 
        _;
    }

    constructor() {
        bankManager = msg.sender;
        registeredMembers[msg.sender] = true;
        members.push(msg.sender);
    }

    function addMembers(address _member) public onlyBankManager {
        require(_member != address(0), "Invalid address");
        require(!registeredMembers[_member], "Already registered");
        registeredMembers[_member] = true;
        members.push(_member);
    }

    function depositAmountEther() public payable onlyRegisteredMember {
        require(msg.value > 0, "Invalid amount");
        balance[msg.sender] += msg.value;
    }

    function withdraw(uint256 _amount) public onlyRegisteredMember {
        require(balance[msg.sender] >= _amount, "Insufficient balance");
        
        balance[msg.sender] -= _amount; 
        
        payable(msg.sender).transfer(_amount); 
    }
}
