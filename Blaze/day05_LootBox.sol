// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
contract LootBox {
    //合约拥有者
    address public owner;
    //宝物数量
    uint256 public treasureAmount;
    //记录每个地址被允许提取的数量
    mapping(address => uint256) public withdrawalAllowance;
    //是否取宝成功
    mapping(address => bool) public hasWithdrawn;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Access denied: Only the owner can perform this action");
        _;
    }

    //添加宝物
    function addTreasure(uint256 amount) public onlyOwner {
        treasureAmount += amount;
    }


    //授权取宝
    function approveWithdrawal(address recipient, uint256 amount) public onlyOwner {
        require(amount <= treasureAmount, "Not enough treasure available");
        withdrawalAllowance[recipient] = amount;
    }

    //取宝
    function withdrawTreasure(uint256 amount) public {
        if (msg.sender == owner) {
            require(amount <= treasureAmount, "Not enough treasury available for this action.");
            treasureAmount -= amount;
            return;
        }
        uint256 allowance = withdrawalAllowance[msg.sender];
        require(allowance > 0, "You don't have any treasure allowance");
        require(!hasWithdrawn[msg.sender], "You have already withdrawn your treasure");
        require(allowance <= treasureAmount, "Not enough treasure in the chest");
        hasWithdrawn[msg.sender] = true;
        treasureAmount -= allowance;
        withdrawalAllowance[msg.sender] = 0;
    }

    //重置用户提取状态
    function resetWithdrawalStatus(address user) public onlyOwner {
        hasWithdrawn[user] = false;
    }

    //转移合约拥有权
    function transferOwnership(address newOwner) public onlyOwner {
        require(newOwner != address(0), "Invalid address");
        owner = newOwner;
    }

    //查看宝箱信息（仅限拥有者）
    function getTreasureDetails() public view onlyOwner returns (uint256) {
        return treasureAmount;
    }


    



}