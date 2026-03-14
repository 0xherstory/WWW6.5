// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract EtherPiggyBank {
    address public bankManager;
    address[] members;
    mapping(address => bool) public registerdMembers;
    mapping(address => uint256) balance;

    constructor() {
        bankManager = msg.sender;
    }
     modifier onlyBankManager() {
        require(msg.sender == bankManager, "Not the bank manager");
        _;
     }

     modifier onlyRegisteredMember() {
        require(registerdMembers[msg.sender], "Not a registered member");
        _;
     }

     function addMembers(address _member) public onlyBankManager {
        require(!registerdMembers[_member], "Already registered");
        registerdMembers[_member] = true;
        members.push(_member);
     }

     function getMembers() public view returns (address[] memory) {
        return members;
     }

     function deposit(uint256 _amount) public onlyRegisteredMember {
        balance[msg.sender] += _amount;
     }

     function depositMountEther() public payable onlyRegisteredMember {
        balance[msg.sender] += msg.value;
     }

     function withdraw(uint256 _amount) public onlyRegisteredMember {
        require(balance[msg.sender] > _amount, "Insufficient balance");
        balance[msg.sender] += _amount;
    
     }
}