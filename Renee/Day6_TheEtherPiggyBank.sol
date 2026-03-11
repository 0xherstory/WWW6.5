// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract TheEtherPiggyBank {
    
    //data we need for our piggy bank
    address public bankManager;
    address[] members;
    mapping (address => bool) public registeredMembers;
    mapping (address => uint256) balance;

    //Setting things up: constructor————初始化
    constructor() {
        bankManager = msg.sender;
        members.push(msg.sender);
        registeredMembers[bankManager] = true;
    }

    //build the rules (Modifiers)
    modifier onlyBankManager {
        require(msg.sender == bankManager, "Only bank maneger can perform this action.");
        _;
    }

    modifier onlyRegisteredMember {
        require(registeredMembers[msg.sender] == true, "Member not registered.");
        _;
    }

    //Adding new members
    function addMembers(address _member) public onlyBankManager {
        require(_member != address(0), "Invalid address.");
        require(_member != msg.sender, "Bank Manager is already a memeber.");
        require(!registeredMembers[_member], "Member already registered.");

        registeredMembers[_member] = true;
        members.push(_member);
    }

    //Viewing the members
    function getMembers() public view returns (address[] memory) {
        return members;
    }

    //Depositing (simulated savings)
    function deposit(uint256 _amount) public onlyRegisteredMember {
        require(_amount > 0, "Invalid amount.");
        balance[msg.sender] += _amount;
    }

    //Withdrawing savings (on paper)
    function withdraw(uint256 _amount) public onlyRegisteredMember {
        require(_amount > 0, "Invalid amount.");
        require(_amount <= balance[msg.sender], "Insufficient balance.");
        balance[msg.sender] -= _amount;
    }

    //Depositing real Ether into the piggy bank
    function depositAmountEther() public payable onlyRegisteredMember {
        require(msg.value > 0, "Invalid amount.");
        balance[msg.sender] += msg.value;
    }
}