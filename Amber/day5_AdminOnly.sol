// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract AdminOnlyAdvanced {
    // ----------------------------- 状态变量 -----------------------------
    address public owner;
    uint256 public treasureAmount;
    mapping(address => uint256) public withdrawalAllowance;
    mapping(address => bool) public hasWithdrawn;
    mapping(address => uint256) public lastWithdrawalTime;
    mapping(address => uint256) public maxWithdrawalLimit; // 每个用户的最大提取额度

    uint256 public cooldownPeriod = 1 hours; // 冷却时间（示例：1小时）

    // ----------------------------- 事件定义 -----------------------------
    event TreasureAdded(uint256 amount, uint256 newTotal);
    event WithdrawalApproved(address indexed user, uint256 amount);
    event TreasureWithdrawn(address indexed user, uint256 amount);
    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);
    event WithdrawalStatusReset(address indexed user);

    // ----------------------------- 构造函数 -----------------------------
    constructor() {
        owner = msg.sender;
    }

    // ----------------------------- 修饰符 -----------------------------
    modifier onlyOwner() {
        require(msg.sender == owner, "Access denied: Only owner");
        _;
    }

    // ----------------------------- 宝藏管理 -----------------------------
    function addTreasure(uint256 amount) public onlyOwner {
        treasureAmount += amount;
        emit TreasureAdded(amount, treasureAmount);
    }

    function approveWithdrawal(address recipient, uint256 amount, uint256 maxLimit) public onlyOwner {
        require(amount <= treasureAmount, "Not enough treasure");
        withdrawalAllowance[recipient] = amount;
        maxWithdrawalLimit[recipient] = maxLimit;
        emit WithdrawalApproved(recipient, amount);
    }

    // ----------------------------- 提现 -----------------------------
    function withdrawTreasure(uint256 amount) public {
        // 拥有者直接提取，无需限制
        if (msg.sender == owner) {
            require(amount <= treasureAmount, "Not enough treasure");
            treasureAmount -= amount;
            emit TreasureWithdrawn(msg.sender, amount);
            return;
        }

        // 冷却时间检查
        require(block.timestamp - lastWithdrawalTime[msg.sender] >= cooldownPeriod, "Cooldown active");

        uint256 allowance = withdrawalAllowance[msg.sender];

        // 用户状态检查
        require(allowance > 0, "No allowance granted");
        require(!hasWithdrawn[msg.sender], "Already withdrawn");
        require(amount <= allowance, "Cannot withdraw more than allowance");
        require(amount <= maxWithdrawalLimit[msg.sender], "Exceeds maximum limit");
        require(amount <= treasureAmount, "Not enough treasure");

        // 更新状态
        hasWithdrawn[msg.sender] = true;
        lastWithdrawalTime[msg.sender] = block.timestamp;
        treasureAmount -= amount;
        withdrawalAllowance[msg.sender] = 0;

        emit TreasureWithdrawn(msg.sender, amount);
    }

    // ----------------------------- 管理操作 -----------------------------
    function resetWithdrawalStatus(address user) public onlyOwner {
        hasWithdrawn[user] = false;
        lastWithdrawalTime[user] = 0;
        emit WithdrawalStatusReset(user);
    }

    function transferOwnership(address newOwner) public onlyOwner {
        require(newOwner != address(0), "Invalid address");
        emit OwnershipTransferred(owner, newOwner);
        owner = newOwner;
    }

    // ----------------------------- 查询函数 -----------------------------
    function getTreasureDetails() public view onlyOwner returns (uint256) {
        return treasureAmount;
    }

    function getUserStatus(address user) public view returns (
        uint256 allowance,
        bool withdrawn,
        uint256 cooldownEnd,
        uint256 maxLimit
    ) {
        allowance = withdrawalAllowance[user];
        withdrawn = hasWithdrawn[user];
        cooldownEnd = lastWithdrawalTime[user] + cooldownPeriod;
        maxLimit = maxWithdrawalLimit[user];
    }

    // ----------------------------- 可修改参数 -----------------------------
    function setCooldownPeriod(uint256 secondsDuration) public onlyOwner {
        cooldownPeriod = secondsDuration;
    }
}
