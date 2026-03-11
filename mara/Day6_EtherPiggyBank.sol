// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract DepositAndWithdraw {
    address owner;
    mapping (address => bool) registedMembers;
    address[] members;
    mapping (address => uint256) bank;

    constructor() {
        owner = msg.sender;
        members.push(owner);
    }
    modifier onlyBankManager() {
        require(msg.sender == owner, "Only bank manager can perform this action");
        _;
    }
    modifier onlyMember() {
        require(registedMembers[msg.sender], "only membership can do");
        _;
    }

    function addMemer (address _name) public onlyBankManager {
        require(msg.sender != address(0), "invalid address");
        require(!registedMembers[_name], "This member has already been registed");
        registedMembers[_name] = true;
        members.push(_name);
    }
    function getMembers() public view returns (address[] memory) {
        return members;
    }
    function deposit(uint256 _value) public onlyMember {
        require(msg.sender != address(0), "invalid address");
        require(_value > 0, "invalid value");
        bank[msg.sender] += _value;
    }
    function withdraw(uint256 _value) public onlyMember {
        require(msg.sender != address(0), "invalid address");
        require(_value > 0, "invalid value");
        require(bank[msg.sender] >= _value, "insufficient balance");
        bank[msg.sender] -= _value;
    }
    function depositAmountEther() public payable onlyMember {
        require(msg.value > 0, "Invalid amount");
        bank[msg.sender] += msg.value;
    }

    function withdrawAmountEther() public payable onlyMember {
        require(msg.value > 0, "invalid amount");
        require(bank[msg.sender] >= msg.value, "insufficient balance");
        bank[msg.sender] -= msg.value;
    }

}