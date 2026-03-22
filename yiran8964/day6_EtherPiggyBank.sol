// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract EtherPiggyBank{
    address public backManager;
    address[] members;
    mapping (address => bool) public registeredMembers;
    mapping (address => uint256) balance;

    constructor(){
        backManager = msg.sender;
        registeredMembers[backManager] = true;
        members.push(backManager);
    }

    modifier onlyBackManager(){
        require(msg.sender == backManager, "Only back manager can perform this action");
        _;
    }

    modifier onlyRegisteredMember(){
        require(registeredMembers[msg.sender], "Only registered members can perform this action");
        _;
    }

    function addMembers(address newMember) public onlyBackManager {
        require(newMember != address(0), "Invalid address");
        require(newMember != backManager, "Back Manager is already a member");
        require(!registeredMembers[newMember], "Member already registered");
        registeredMembers[newMember] = true;
        members.push(newMember);
    }

    function getMembers() public view returns(address[] memory) {
        return members;
    }

    function depositAmountEther() public payable onlyRegisteredMember {
        require(msg.value > 0, "Invalid amount");
        balance[msg.sender] += msg.value;
    }

    function withdrawAmountEther(uint256 _amount) public  payable onlyRegisteredMember {
        uint256 amountInWei = _amount*1 ether;
        require(amountInWei> 0, "Invalid amount");
        require(balance[msg.sender] >= amountInWei, "Insufficient balance");
        balance[msg.sender] -= amountInWei;
        (bool success,) = payable(msg.sender).call{value:amountInWei}("");
        require(success, "Transfer failed");
    }

    function getBalance(address _member) public view returns (uint256) {
        require(_member != address(0), "Invalid address");
        return balance[_member];
    }
}