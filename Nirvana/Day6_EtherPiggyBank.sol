// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract EtherPiggyBank{
    
    //There should be a bank manager who has the certain permissions
    //There should be an array for all members registered and a mapping whether they are are registered or not 
    //a mapping with there balances

    address public bankManager;

    address[]members;
    mapping(address => bool) public registeredMembers;
    mapping(address => uint256) balance;

    constructor(){
        bankManager = msg.sender;
        members.push(msg.sender);
    }

    modifier onlyBankManager(){
        require(msg.sender == bankManager, "only bank manager can perform this action");
        _;
    }

    modifier onlyRegisteredMember(){
        require(registeredMembers[msg.sender],"Member not registered");
        _;
    }

    function addMembers(address newMember) public onlyBankManager {
        require(newMember != address(0),"Invalid address");
        require(newMember != msg.sender,"Bank Mangaer is already a member");
        require(!registeredMembers[newMember],"Member alaready registered");

        registeredMembers[newMember] = true;
        members.push(newMember);
    }

    function getMembers() public view returns(address[] memory){
        return members;
    }

    //deposit acmount 
    function depositAmountEther() public payable onlyRegisteredMember{
        require(msg.value > 0,"Invalid amount");
        balance[msg.sender] = balance[msg.sender] + msg.value;

    }

    function withdrawAmount(uint256 _amount) public onlyRegisteredMember{
        require(_amount > 0, "Invalid amount");
        require(balance[msg.sender] >= _amount, "Insufficient balance");
        balance[msg.sender] = balance[msg.sender]-_amount;


    }

    function getBalance(address newMember) public view returns(uint256){
        require(newMember != address(0), "Invalid address");
        return balance[newMember];
    }

}