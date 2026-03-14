// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract AdminOnly {
    address public owner;
    uint256 public treasureAmount;
    mapping(address => uint256) public approvedWithdrawalAmount;
    mapping(address => bool) public hasWithdrawn;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this function");
        _;
    }

    //owner往宝箱加钱啦
    function addTreasure(uint256 _amount) public onlyOwner {
        require(_amount > 0, "Amount must be greater than 0");
        treasureAmount += _amount;
    }

    //批准用户提现额度
    function approveWithdrawal(address _user, uint256 _amount) public onlyOwner {
        require(_amount >0, "Amount must be greater than 0");
        require(_amount <= treasureAmount, "Not enough treasure");
        approvedWithdrawalAmount[_user] = _amount;
    }

    //用户提现
    function withdrawTreasure(uint256 _amount) public {
        if (msg.sender == owner) {
            require(_amount > 0 &&_amount <= treasureAmount, "Invalid amount");
            treasureAmount -= _amount;
            return;
        }
        //用户提现的条件
        require(approvedWithdrawalAmount[msg.sender] >= _amount, "Not approved");
        require(!hasWithdrawn[msg.sender], "Already withdrawn");
        require(_amount <= treasureAmount, "Not enough treasure");

        //执行提现
        treasureAmount -= _amount;
        approvedWithdrawalAmount[msg.sender] = 0;
        hasWithdrawn[msg.sender] = true;
    }

    //owner重置用户提现状态
    function resetWithdrawalStatus(address _user) public onlyOwner {
        hasWithdrawn[_user] = false;
    }
}