// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract EtherPiggyBank{
    // there should be a bank manager who has the certain permissions
    // there should be an array for all members registered and a mapping whether they registered or not
    // a mapping with there balances
    address public bankManager;
    address[] members;
    mapping (address => bool) public isRegistered;
    mapping (address => uint256) balance;
    mapping (address => uint256) public lastWithdrawTime;

    uint256 public withdrawCooldown = 1 minutes;
    uint256 public maxWithdrawAmount = 1 ether;

    constructor() payable {
        bankManager = msg.sender;
        isRegistered[msg.sender] = true;
        members.push(msg.sender);
    }

    modifier onlyBankManager(){
        require(msg.sender == bankManager, "Only bank manager can perform this action");
        _;
    }

    modifier onlyRegisteredMember(){
        require(isRegistered[msg.sender], "Member not registered");
        _;
    }

    function addMembers(address _member) public onlyBankManager{
        require(_member != address(0), "Invalid address");
        require(_member != msg.sender, "Bank Manager is already a member");
        require(!isRegistered[_member], "Member already registered");
        isRegistered[_member] = true;
        members.push(_member);
    }

    function getMembers() public view returns (address[] memory){
        return members;
    }

    // deposit amount
    // function depositAmount(uint256 _amount) public onlyRegisteredMember{
    //     require(_amount > 0, "Invalid amount");
    //     balance[msg.sender] = balance[msg.sender] + _amount;
    // }

    // deposit in Ether
    function depositAmountEther() public payable onlyRegisteredMember{
        require(msg.value > 0, "Invalid amount");
        balance[msg.sender] = balance[msg.sender]+msg.value;
    }

    function withdrawAmount(uint256 _amount) public onlyRegisteredMember{
        require(_amount > 0, "Invalid amount");
        require(balance[msg.sender] >= _amount, "Insufficient Balance");

        // masamount detection
        require(_amount <= maxWithdrawAmount, "Exceeds max withdraw limit");

        // cooldowmtime detection
        require(block.timestamp >= lastWithdrawTime[msg.sender] + withdrawCooldown,"Withdrawal cooldown active");

        balance[msg.sender] = balance[msg.sender]-_amount;
        lastWithdrawTime[msg.sender] = block.timestamp;

        // transfer ETH to user
        payable(msg.sender).transfer(_amount); 
    }

    function getBalance(address _member) public view returns (uint256){
        require(_member != address(0), "Invalid address");
        return balance[_member];
    }
}