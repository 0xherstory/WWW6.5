// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract TreasureChest {
    // 状态变量
    address public owner;
    uint256 public treasureAmount;
    bool public isLocked;
    
    // 权限映射
    mapping(address => bool) public approvedUsers;
    mapping(address => bool) public admins;
    
    // 事件
    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);
    event TreasureAdded(uint256 amount);
    event TreasureWithdrawn(address indexed user, uint256 amount);
    event UserApproved(address indexed user);
    event UserRemoved(address indexed user);
    event AdminAdded(address indexed admin);
    event AdminRemoved(address indexed admin);
    event ChestLocked();
    event ChestUnlocked();
    
    // 构造函数 - 部署者成为拥有者
    constructor() {
        owner = msg.sender;
        admins[msg.sender] = true;
        isLocked = true; // 默认上锁
        treasureAmount = 0;
    }
    
    // ============ Modifiers 修饰符 ============
    
    // 只有拥有者可以执行
    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this function");
        _;
    }
    
    // 只有管理员可以执行
    modifier onlyAdmin() {
        require(admins[msg.sender], "Only admin can call this function");
        _;
    }
    
    // 只有被授权用户或管理员可以执行
    modifier onlyApproved() {
        require(approvedUsers[msg.sender] || admins[msg.sender], "Not authorized");
        _;
    }
    
    // 检查宝箱是否未上锁
    modifier whenUnlocked() {
        require(!isLocked, "Chest is locked");
        _;
    }
    
    // 检查宝箱是否已上锁
    modifier whenLocked() {
        require(isLocked, "Chest is already unlocked");
        _;
    }
    
    // ============ 管理员功能 ============
    
    // 转移拥有权 - 只有当前拥有者可以执行
    function transferOwnership(address newOwner) public onlyOwner {
        require(newOwner != address(0), "New owner cannot be zero address");
        address oldOwner = owner;
        owner = newOwner;
        
        // 更新管理员权限
        admins[oldOwner] = false;
        admins[newOwner] = true;
        
        emit OwnershipTransferred(oldOwner, newOwner);
    }
    
    // 添加管理员 - 只有拥有者可以执行
    function addAdmin(address admin) public onlyOwner {
        require(admin != address(0), "Invalid address");
        admins[admin] = true;
        emit AdminAdded(admin);
    }
    
    // 移除管理员 - 只有拥有者可以执行
    function removeAdmin(address admin) public onlyOwner {
        require(admin != owner, "Cannot remove owner from admins");
        admins[admin] = false;
        emit AdminRemoved(admin);
    }
    
    // 授权用户 - 管理员可以执行
    function approveUser(address user) public onlyAdmin {
        require(user != address(0), "Invalid address");
        approvedUsers[user] = true;
        emit UserApproved(user);
    }
    
    // 移除用户授权 - 管理员可以执行
    function removeUser(address user) public onlyAdmin {
        approvedUsers[user] = false;
        emit UserRemoved(user);
    }
    
    // ============ 宝箱管理功能 ============
    
    // 向宝箱存入资金 - 任何人都可以存入
    function deposit() public payable {
        require(msg.value > 0, "Must deposit some ether");
        treasureAmount += msg.value;
        emit TreasureAdded(msg.value);
    }
    
    // 向宝箱存入资金（指定数量）- 任何人都可以存入
    function depositAmount(uint256 amount) public payable {
        require(msg.value == amount, "Sent value must match amount");
        require(amount > 0, "Must deposit some ether");
        treasureAmount += amount;
        emit TreasureAdded(amount);
    }
    
    // 解锁宝箱 - 只有拥有者可以执行
    function unlock() public onlyOwner whenLocked {
        isLocked = false;
        emit ChestUnlocked();
    }
    
    // 上锁宝箱 - 只有拥有者可以执行
    function lock() public onlyOwner whenUnlocked {
        isLocked = true;
        emit ChestLocked();
    }
    
    // 提取宝箱资金 - 只有被授权用户且宝箱未上锁时可以执行
    function withdraw(uint256 amount) public onlyApproved whenUnlocked {
        require(amount <= treasureAmount, "Insufficient treasure");
        require(amount > 0, "Amount must be greater than 0");
        
        treasureAmount -= amount;
        payable(msg.sender).transfer(amount);
        
        emit TreasureWithdrawn(msg.sender, amount);
    }
    
    // 重置宝箱 - 只有拥有者可以执行（紧急情况）
    function resetChest() public onlyOwner {
        isLocked = true;
        treasureAmount = 0;
        emit ChestLocked();
    }
    
    // 紧急提款 - 只有拥有者可以执行
    function emergencyWithdraw() public onlyOwner {
        uint256 amount = treasureAmount;
        treasureAmount = 0;
        payable(owner).transfer(amount);
        emit TreasureWithdrawn(owner, amount);
    }
    
    // ============ 查询功能 ============
    
    // 检查地址是否被授权
    function isApproved(address user) public view returns (bool) {
        return approvedUsers[user];
    }
    
    // 检查地址是否是管理员
    function isAdmin(address user) public view returns (bool) {
        return admins[user];
    }
    
    // 获取当前宝箱余额
    function getTreasureAmount() public view returns (uint256) {
        return treasureAmount;
    }
    
    // 获取合约总余额（包括直接转入的）
    function getContractBalance() public view returns (uint256) {
        return address(this).balance;
    }
    
    // 检查调用者是否是拥有者
    function isOwner() public view returns (bool) {
        return msg.sender == owner;
    }
    
    // 接收 ETH 的回调函数
    receive() external payable {
        treasureAmount += msg.value;
        emit TreasureAdded(msg.value);
    }
    
    // 备用回调函数
    fallback() external payable {
        treasureAmount += msg.value;
        emit TreasureAdded(msg.value);
    }
}