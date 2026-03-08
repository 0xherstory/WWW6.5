// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract EtherPiggyBank {

    address public bankManager;
    address[] private members;
    mapping(address => bool) public registeredMembers;
    mapping(address => uint256) private balance;

    constructor() {
        bankManager = msg.sender;
        members.push(msg.sender);
        registeredMembers[bankManager] = true;
    }

    modifier onlyBankManager() {
        require(msg.sender == bankManager, "Only bank manager can perform this action");
        _;
    }

    modifier onlyRegisteredMember() {
        require(registeredMembers[msg.sender], "Member not registered");
        _;
    }

    function addMembers(address _member) public onlyBankManager {
        require(_member != address(0), "Invalid address");
        require(_member != msg.sender, "Bank Manager is already a member");
        require(!registeredMembers[_member], "Member already registered");
        registeredMembers[_member] = true;
        members.push(_member);
    }

    function getMembers() public view returns(address[] memory) {
        return members;
    }

    function depositAmountEther() public payable onlyRegisteredMember {
        require(msg.value > 0, "Invalid amount");
        balance[msg.sender] = balance[msg.sender] + msg.value;
    }

    // 添加一个取现函数，把以太币返还给用户
    function withdrawAmountEther(uint256 amount) public onlyRegisteredMember {
        require(amount > 0, "Invalid amount");
        require(balance[msg.sender] >= amount, "Insufficient balance");
        balance[msg.sender] = balance[msg.sender] - amount;
        payable(msg.sender).transfer(amount);
    }

    function getBalance(address _member) public view returns (uint256) {
        require(_member != address(0), "Invalid address");
        return balance[_member];
    }

}