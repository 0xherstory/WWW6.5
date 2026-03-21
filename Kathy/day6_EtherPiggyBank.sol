// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract EtherPiggyBank{
    address public bankManager;
    address[] members;
    mapping(address => bool) public registeredMembers;
    mapping(address => uint256) balance;

    constructor() {
        bankManager = msg.sender;
        members.push(msg.sender);
    }

    modifier  onlyBankeManager() {
        require(msg.sender == bankManager, "Only bank manager can perform this action.");
        _;
    }

    modifier  onlyRegisterdMemer() {
        require(registeredMembers[msg.sender], "Member not registerd.");
        _;
    }

    function addMembers(address _member) public onlyBankeManager {
        require(_member != address(0), "Invalid address.");
        require(_member != msg.sender, "Bank Manager is already a member.");
       
       registeredMembers[_member] = true;
       members.push(_member);
    }


    function getMembers() public view returns (address[] memory) {
        return members;
    }

    // Simulation: withdrawal
    //function withdraw(unit245 _amount) public onlyRegisteredMemver {
    //    require(_amount >0, "Invalid amount.");
    //    require(balance[msg.sender] >= _amount, "Insufficient balance.");
    //   balance[msg.sender] -= _amount;
    //}

    // Simulation: deposit
    //function deposit(uint256 _amount) public onlyRegisterdMemer {
    //    require(_amount > 0, "Invalid amount.");
    //    balance[msg.sender] += _amount;
    //}

    function depositAmoiuntEther() public payable onlyRegisterdMemer {
        require(msg.value > 0, "Invalid amount.");
        balance[msg.sender] += msg.value;
    }
}
