// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract AdminOnly {
    // === State Variables ===
    //存储合约创建者的地址，拥有特殊权限
    address public owner;
    //存储合约中当前的“宝藏”数量
    uint256 public treasureAmount;
    // 最大提取上限
    uint256 public maxWithdrawalLimit;
    // 记录每个用户最后一次提取的时间
    mapping(address => uint256) public lastWithdrawTime;
    //每个地址映射到一个允许提取的金额
    mapping(address => uint256) public withdrawalAllowance;
    //记录每个地址是否已经提取过宝藏
    mapping(address => bool) public hasWithdrawn;
    
    // === Events ===
    // 记录添加宝藏事件
    event TreasureAdded(address indexed admin, uint256 amount, uint256 newTotal);
    // 记录提取宝藏事件
    event TreasureWithdrawn(address indexed user, uint256 amount, uint256 remainingTreasure);
    // 记录所有权转移事件
    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    // === Modifiers ===
    modifier onlyOwner() {
        require(msg.sender == owner, "Access denied: Only the owner can perform this action");
        _;
    }

    // === Constructor ===
    constructor() {
        owner = msg.sender;
        // 初始化最大提取上限（例如：默认设为 100）
        maxWithdrawalLimit = 100;
    }

    // === Functions ===
    // Only the owner can add treasure
    function addTreasure(uint256 amount) public onlyOwner {
        treasureAmount += amount;
        // 在添加、提取、或转移拥有权时触发事件
        emit TreasureAdded(msg.sender, amount, treasureAmount);
    }
    
    // 设置最大提取上限
    function setMaxWithdrawalLimit(uint256 limit) public onlyOwner {
        maxWithdrawalLimit = limit;
    }

    // Only the owner can approve withdrawals
    function approveWithdrawal(address recipient, uint256 amount) public onlyOwner {
        require(amount <= treasureAmount, "Not enough treasure available");
        // 检查批准金额不能超过全局上限
        require(amount <= maxWithdrawalLimit, "Approval amount exceeds the global maximum limit");
        withdrawalAllowance[recipient] = amount;
    }

    // Anyone can attempt to withdraw
    function withdrawTreasure(uint256 amount) public {
        // 管理员特权逻辑（无冷却限制）
        if(msg.sender == owner){
            require(amount <= treasureAmount, "Not enough treasury available for this action.");
            treasureAmount -= amount;
            // 在添加、提取、或转移拥有权时触发事件
            emit TreasureWithdrawn(msg.sender, amount, treasureAmount);
            return;
        }
        
        uint256 allowance = withdrawalAllowance[msg.sender];
        
        // 检查是否有额度
        require(allowance > 0, "You don't have any treasure allowance");
        // 检查是否已提取
        require(!hasWithdrawn[msg.sender], "You have already withdrawn your treasure");
        // 检查宝库余额
        require(allowance <= treasureAmount, "Not enough treasure in the chest");
        // 检查提取金额是否超出批准额度
        require(allowance >= amount, "Cannot withdraw more than you are allowed");

        // === 添加冷却时间计时器：用户只能每隔 X 分钟提取一次 ===
        // 假设冷却时间为 10秒
        uint256 cooldownPeriod = 10; 
        require(block.timestamp >= lastWithdrawTime[msg.sender] + cooldownPeriod, "Cooldown period not reached. Please wait before withdrawing again.");
        // 执行提取操作
        hasWithdrawn[msg.sender] = true;
        treasureAmount -= allowance;
        withdrawalAllowance[msg.sender] = 0;
        // 记录本次提取时间
        lastWithdrawTime[msg.sender] = block.timestamp;
        // 在添加、提取、或转移拥有权时触发事件
        emit TreasureWithdrawn(msg.sender, amount, treasureAmount);
    }

    // 让用户自己查询结果（是否批准、是否已提取、剩余冷却时间）
    function getUserStatus(address user) public view returns (
        bool isApproved,
        bool alreadyWithdrawn,
        uint256 timeUntilCanWithdrawAgain
    ) {
        uint256 cooldownPeriod = 1 hours; // 必须与 withdrawTreasure 中的值一致
        uint256 nextWithdrawTime = lastWithdrawTime[user] + cooldownPeriod;
        uint256 remainingTime = block.timestamp >= nextWithdrawTime ? 0 : nextWithdrawTime - block.timestamp;

        return (
            withdrawalAllowance[user] > 0, // isApproved
            hasWithdrawn[user],            // alreadyWithdrawn
            remainingTime                  // timeUntilCanWithdrawAgain (0 表示可以提取)
        );
    }

    // Only the owner can reset someone's withdrawal status
    function resetWithdrawalStatus(address user) public onlyOwner {
        hasWithdrawn[user] = false;
    }

    // Only the owner can transfer ownership
    function transferOwnership(address newOwner) public onlyOwner {
        require(newOwner != address(0), "Invalid address");
        address oldOwner = owner;
        owner = newOwner;
        // 在添加、提取、或转移拥有权时触发事件
        emit OwnershipTransferred(oldOwner, newOwner);
    }
    //Only the owner can check the treasureAmount
    function getTreasureDetails() public view onlyOwner returns (uint256) {
        return treasureAmount;
    }
}