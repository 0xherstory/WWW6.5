//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract EtherPiggyBank{
    //set a bank manager
    //set an array for members
    //a mapping for registered members
    //a mapping with balances

    address public bankManager;
    address[] members ;
    mapping(address => bool) public registeredMembers;
    mapping(address => uint256) balance;

    constructor(){
       bankManager = msg.sender;
       members.push(msg.sender);
    }


    //modifier to bankManager and registeredMembers
    modifier onlyBankManager(){
        require(msg.sender == bankManager, "Only bank manager can perform this action");
        _;
    }

    modifier onlyRegisteredMember() {
        require(registeredMembers[msg.sender], "Member not registered.");
        _;
    }

    //add members,only by the bankManager
    function addMembers(address _member) public onlyBankManager{
        require(_member != address(0), "Invalid address");
        require(_member != msg.sender, "Bank Manager is already a member");
        require(!registeredMembers[_member], "Member already registered");
        registeredMembers[_member] = true;
        members.push(_member);
    }

    //view the members list
    function getMembers() public view returns(address[] memory){
        return members;
    }

    //deposit amount by registered members
    function depositAmountEther() public payable onlyRegisteredMember{  
        require(msg.value > 0, "Invalid amount");
        balance[msg.sender] = balance[msg.sender]+msg.value;
   
    }
    
    //withdraw amount by registered members
    function withdrawAmount(uint256 _amount) public onlyRegisteredMember{
        require(_amount > 0, "Invalid amount");
        require(balance[msg.sender] >= _amount, "Insufficient balance");
        balance[msg.sender] = balance[msg.sender]-_amount;
   
    }

    //view the balance
    function getBalance(address _member) public view returns (uint256){
        require(_member != address(0), "Invalid address");
        return balance[_member];
    } 
}
