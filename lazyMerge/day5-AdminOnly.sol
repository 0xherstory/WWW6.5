 // SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract AdminOnly {
    address public  owner; // owner
    uint256 public treasureAmount; // 宝物数量
    mapping(address => uint256) public withdrawalApprovals; // 宝物地址列表
    mapping(address => bool) public hasWithdrawn; // 是否已提取过
    uint256 public maxOnceWithdrawalAmount; // 单次最大提取上限，适用于用户提取

    constructor(uint256 _maxOnceWithdrawalAmount) {
        owner = msg.sender;
        maxOnceWithdrawalAmount = _maxOnceWithdrawalAmount;
    }

    // modifier onlyOwner ！！这课重点！！
    modifier onlyOwner() {
        require(owner == msg.sender, "Access denied: Only the owner can perform this action");
        // _; 是一个特殊的占位符，表示被修饰的函数体的插入位置
        // 这里表示后续使用修饰器 onlyOwner 的时候，需要上面的 require 执行完成后触发
        _;
    }

    // 添加宝物，仅限 ower
    function addTreasure(uint256 _amount) public onlyOwner {
        treasureAmount += _amount;
    }

    // 给地址授予宝物数量
    function approveWithdrawal(address _address, uint256 _amount) public onlyOwner {
        require(_amount <= treasureAmount, "Not enough treasure available");
        withdrawalApprovals[_address] = _amount;
    }

    // 取宝
    // 区分 owner 和用户，用户有最大的提取上限
    function withdrawTreasure(uint256 _amount) public {
        if(msg.sender == owner) {
            require(_amount <= treasureAmount, "Not enough treasury available for this action.");
            treasureAmount -= _amount;
            return;
        }
        uint256 allowance  = withdrawalApprovals[msg.sender]; // 提取用户的数量

        // 必须 可提取数量是大于 0
        require(allowance > 0, "You dont't have any treasure allowance");
        // 必须 提取数量小于用户上限
        require(allowance >= _amount, "Cannot withdraw more than you are allowed");
        // 必须 提取数量小于单次最大上限
        require(maxOnceWithdrawalAmount >= _amount, "You can't withdraw more than max once withdrawal amout");
        // 必须 提取数量小于总提取数
        require(_amount <= treasureAmount, "Not enough treasury available for this action");
        treasureAmount -= _amount;
        withdrawalApprovals[msg.sender] -= _amount;
        hasWithdrawn[msg.sender] = true;
    }

    // 转移 owner
    function transferOwnership(address newOwner) public onlyOwner {
        // address(0) 表示以太坊的零地址，通常表示一个无效地址，常用于检查地址是否有效
        require(newOwner != address(0), "Invalid address");
        owner = newOwner;
    }

    // 查看宝物，仅限 owner
    function getTreasureAmount() public view onlyOwner returns (uint256) {
        return treasureAmount;
    }

    // 查看是否被批准，是否已提取
    function getApprovalStatus(address _address) public view returns (uint256, bool) {
        return (withdrawalApprovals[_address], hasWithdrawn[_address]);
    }
}