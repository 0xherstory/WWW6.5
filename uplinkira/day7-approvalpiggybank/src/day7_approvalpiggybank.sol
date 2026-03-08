// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract ApprovalPiggyBank {
    address public bankManager;
    mapping(address => bool) public members;
    address[] public memberList;

    mapping(address => uint256) public balances;
    mapping(address => uint256) public withdrawalApproval;
    uint256 public totalDeposits;

    constructor() {
        bankManager = msg.sender;
        members[msg.sender] = true;
        memberList.push(msg.sender);
    }

    modifier onlyBankManager() {
        require(msg.sender == bankManager, "Only bank manager");
        _;
    }

    modifier onlyMember() {
        require(members[msg.sender], "Only member");
        _;
    }

    function addMember(address member) public onlyBankManager {
        require(member != address(0), "Invalid member");
        require(!members[member], "Member already exists");

        members[member] = true;
        memberList.push(member);
    }

    function deposit() public payable onlyMember {
        require(msg.value > 0, "Deposit must be greater than 0");

        balances[msg.sender] += msg.value;
        totalDeposits += msg.value;
    }

    function approveWithdrawal(address member, uint256 amountWei) public onlyBankManager {
        require(members[member], "Unknown member");
        require(amountWei <= balances[member], "Amount exceeds member balance");

        withdrawalApproval[member] = amountWei;
    }

    function withdraw(uint256 amountWei) public onlyMember {
        require(amountWei > 0, "Amount must be greater than 0");
        require(amountWei <= withdrawalApproval[msg.sender], "Amount exceeds approval");
        require(amountWei <= balances[msg.sender], "Insufficient member balance");
        require(amountWei <= address(this).balance, "Insufficient contract ETH");

        withdrawalApproval[msg.sender] -= amountWei;
        balances[msg.sender] -= amountWei;
        totalDeposits -= amountWei;

        (bool ok, ) = payable(msg.sender).call{value: amountWei}("");
        require(ok, "ETH transfer failed");
    }

    function transferBankManager(address newManager) public onlyBankManager {
        require(newManager != address(0), "Invalid manager");

        if (!members[newManager]) {
            members[newManager] = true;
            memberList.push(newManager);
        }
        bankManager = newManager;
    }

    function getMembers() public view returns (address[] memory) {
        return memberList;
    }

    function contractEthBalance() public view returns (uint256) {
        return address(this).balance;
    }
}
