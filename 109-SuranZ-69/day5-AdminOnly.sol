// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract AdminOnly{
    //设置合约拥有者——部署该合约的人就是合约拥有者
    address public owner;
    
    constructor () {
        owner = msg.sender;
    }

    //修饰符modifier——可复用的小型权限检查逻辑，在每个需要检查权限的函数中只需要添加onlyOwner即可
    modifier onlyOwner() {
        require (msg.sender == owner, "Access denied: Only the owner can perform this action.");
        _; //_符号表示权限检查之后函数主体将被插入的位置（占位符），检查通过才会继续执行
    }

    //添加宝物到宝箱中
    uint256 public treasureAmount; //声明变量：宝箱中的宝物

    function addTreasure (uint256 amount) public onlyOwner { //表示仅owner可调用此函数
        treasureAmount += amount;
    }

    //授权ta人取宝
    mapping (address => uint256) public withdrawalAllowance; //记录每个人被允许提取的宝物数量

    function approveWithdrawal (address recipient, uint256 amount) public onlyOwner { //拥有者为被允许者设置提取额度
        require (amount <= treasureAmount, "Not enough treasure available."); //提取额度必须小于宝物的数量
        withdrawalAllowance[recipient] = amount;
    }

    //实际取宝的过程
    mapping (address => bool) public hasWithdrawn; //标记用户是否已取过宝

    function withdrawTreasure (uint256 amount) public {
        //情况一：拥有者自己取宝，不需要检查额度，也不追踪提取记录（Question：为何不用追踪提取记录？）
        if (msg.sender == owner) {
            require (amount <= treasureAmount, "Not enough treasure available for this action.");
            treasureAmount -=amount;
            return;
        }
        //情况二：普通用户取宝
        uint256 allowance = withdrawalAllowance[msg.sender]; //声明一个变量用来存放当前普通用户的可提取额度数值
        require (allowance > 0, "You don't have any treasure allowance."); //普通用户必须被批准（可提取额度不为0）
        require (!hasWithdrawn[msg.sender], "You have already withdrawn your treasure."); //必须之前没有提取过
        require (allowance <= treasureAmount, "Not enough treasure in the chest.");
        //取宝操作完成
        hasWithdrawn[msg.sender] = true;
        treasureAmount -= allowance;
        withdrawalAllowance[msg.sender] = 0;
    }

    //重置用户的提取状态
    function resetWithdrawalStatus (address user) public onlyOwner {
        hasWithdrawn[user] = false;
    } //重置后，需要再次回到由拥有者为该用户设置可提取额度的函数

    //转移合约的拥有权
    function transferOwnership (address newOwner) public onlyOwner {
        require (newOwner != address (0), "Invalid address."); //检查新地址，防止为空或无效
        owner = newOwner;
    }

    //查看宝箱信息（仅限拥有者）
    function getTreasureDetails() public view onlyOwner returns (uint256) {
        return treasureAmount;
    }
}