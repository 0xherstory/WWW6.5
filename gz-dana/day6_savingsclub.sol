// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SavingsClub {
    // ============ 角色定义 ============
    address public bankManager;
    
    // 成员结构体
    struct Member {
        bool isRegistered;
        uint256 balance;
        uint256 joinTime;
        string name;
    }
    
    // ============ 状态变量 ============
    mapping(address => Member) public members;
    address[] public memberList;
    uint256 public totalDeposits;
    uint256 public memberCount;
    bool public isOpen;
    
    // ============ 事件 ============
    event MemberRegistered(address indexed member, string name);
    event MemberRemoved(address indexed member);
    event Deposited(address indexed member, uint256 amount);
    event Withdrawn(address indexed member, uint256 amount);
    event ManagerChanged(address indexed oldManager, address indexed newManager);
    event ClubOpened();
    event ClubClosed();
    event EmergencyWithdraw(address indexed to, uint256 amount);
    
    // ============ 修饰符 ============
    modifier onlyManager() {
        require(msg.sender == bankManager, "Only bank manager can call this");
        _;
    }
    
    modifier onlyMember() {
        require(members[msg.sender].isRegistered, "Not a registered member");
        _;
    }
    
    modifier clubIsOpen() {
        require(isOpen, "Club is currently closed");
        _;
    }
    
    modifier clubIsClosed() {
        require(!isOpen, "Club is currently open");
        _;
    }
    
    // ============ 构造函数 ============
    constructor() {
        bankManager = msg.sender;
        isOpen = true;
        memberCount = 0;
        totalDeposits = 0;
    }
    
    // ============ 管理员功能 ============
    
    // 更换银行经理
    function changeManager(address newManager) public onlyManager {
        require(newManager != address(0), "Invalid address");
        require(newManager != bankManager, "New manager must be different");
        
        address oldManager = bankManager;
        bankManager = newManager;
        
        // 新经理自动成为成员（如果不是的话）
        if (!members[newManager].isRegistered) {
            members[newManager] = Member({
                isRegistered: true,
                balance: 0,
                joinTime: block.timestamp,
                name: "Bank Manager"
            });
            memberList.push(newManager);
            memberCount++;
        }
        
        emit ManagerChanged(oldManager, newManager);
    }
    
    // 注册新成员 - 经理可以主动添加
    function registerMember(address memberAddress, string memory name) public onlyManager {
        require(memberAddress != address(0), "Invalid address");
        require(!members[memberAddress].isRegistered, "Already a member");
        
        members[memberAddress] = Member({
            isRegistered: true,
            balance: 0,
            joinTime: block.timestamp,
            name: name
        });
        memberList.push(memberAddress);
        memberCount++;
        
        emit MemberRegistered(memberAddress, name);
    }
    
    // 移除成员
    function removeMember(address memberAddress) public onlyManager {
        require(members[memberAddress].isRegistered, "Not a member");
        require(memberAddress != bankManager, "Cannot remove manager");
        
        // 退还余额
        uint256 refund = members[memberAddress].balance;
        if (refund > 0) {
            totalDeposits -= refund;
            payable(memberAddress).transfer(refund);
        }
        
        members[memberAddress].isRegistered = false;
        members[memberAddress].balance = 0;
        memberCount--;
        
        emit MemberRemoved(memberAddress);
    }
    
    // 开放俱乐部
    function openClub() public onlyManager clubIsClosed {
        isOpen = true;
        emit ClubOpened();
    }
    
    // 关闭俱乐部
    function closeClub() public onlyManager clubIsOpen {
        isOpen = false;
        emit ClubClosed();
    }
    
    // 紧急提款 - 经理可以在紧急情况下提取所有资金
    function emergencyWithdraw(address payable to) public onlyManager {
        uint256 amount = address(this).balance;
        require(amount > 0, "No funds to withdraw");
        
        // 重置所有成员余额记录（实际资金已转出）
        for (uint i = 0; i < memberList.length; i++) {
            address memberAddr = memberList[i];
            if (members[memberAddr].isRegistered) {
                members[memberAddr].balance = 0;
            }
        }
        totalDeposits = 0;
        
        to.transfer(amount);
        emit EmergencyWithdraw(to, amount);
    }
    
    // ============ 成员自助功能 ============
    
    // 自助注册成为成员
    function joinClub(string memory name) public clubIsOpen {
        require(!members[msg.sender].isRegistered, "Already a member");
        require(bytes(name).length > 0, "Name cannot be empty");
        require(bytes(name).length <= 50, "Name too long");
        
        members[msg.sender] = Member({
            isRegistered: true,
            balance: 0,
            joinTime: block.timestamp,
            name: name
        });
        memberList.push(msg.sender);
        memberCount++;
        
        emit MemberRegistered(msg.sender, name);
    }
    
    // 退出俱乐部
    function leaveClub() public onlyMember {
        require(msg.sender != bankManager, "Manager cannot leave");
        
        // 退还余额
        uint256 refund = members[msg.sender].balance;
        if (refund > 0) {
            totalDeposits -= refund;
            payable(msg.sender).transfer(refund);
        }
        
        members[msg.sender].isRegistered = false;
        members[msg.sender].balance = 0;
        memberCount--;
        
        emit MemberRemoved(msg.sender);
    }
    
    // ============ 存取款功能 ============
    
    // 存款 - 成员可以向自己的账户存钱
    function deposit() public payable onlyMember clubIsOpen {
        require(msg.value > 0, "Must deposit some ETH");
        
        members[msg.sender].balance += msg.value;
        totalDeposits += msg.value;
        
        emit Deposited(msg.sender, msg.value);
    }
    
    // 批量存款 - 经理可以为成员存款
    function depositFor(address memberAddress) public payable onlyManager {
        require(members[memberAddress].isRegistered, "Not a registered member");
        require(msg.value > 0, "Must deposit some ETH");
        
        members[memberAddress].balance += msg.value;
        totalDeposits += msg.value;
        
        emit Deposited(memberAddress, msg.value);
    }
    
    // 取款 - 成员可以取出自己的存款
    function withdraw(uint256 amount) public onlyMember clubIsOpen {
        require(amount > 0, "Amount must be greater than 0");
        require(amount <= members[msg.sender].balance, "Insufficient balance");
        
        members[msg.sender].balance -= amount;
        totalDeposits -= amount;
        payable(msg.sender).transfer(amount);
        
        emit Withdrawn(msg.sender, amount);
    }
    
    // 取出全部存款
    function withdrawAll() public onlyMember clubIsOpen {
        uint256 amount = members[msg.sender].balance;
        require(amount > 0, "No balance to withdraw");
        
        members[msg.sender].balance = 0;
        totalDeposits -= amount;
        payable(msg.sender).transfer(amount);
        
        emit Withdrawn(msg.sender, amount);
    }
    
    // ============ 查询功能 ============
    
    // 获取成员信息
    function getMemberInfo(address memberAddress) public view returns (
        string memory name,
        uint256 balance,
        uint256 joinTime,
        bool registered
    ) {
        Member memory m = members[memberAddress];
        return (m.name, m.balance, m.joinTime, m.isRegistered);
    }
    
    // 获取自己的信息
    function getMyInfo() public view onlyMember returns (
        string memory name,
        uint256 balance,
        uint256 joinTime
    ) {
        Member memory m = members[msg.sender];
        return (m.name, m.balance, m.joinTime);
    }
    
    // 获取成员列表（分页）
    function getMembers(uint256 start, uint256 limit) public view returns (address[] memory) {
        require(start < memberList.length, "Start index out of bounds");
        
        uint256 end = start + limit;
        if (end > memberList.length) {
            end = memberList.length;
        }
        
        address[] memory result = new address[](end - start);
        for (uint256 i = start; i < end; i++) {
            result[i - start] = memberList[i];
        }
        return result;
    }
    
    // 获取合约总余额
    function getContractBalance() public view returns (uint256) {
        return address(this).balance;
    }
    
    // 检查是否是成员
    function isMember(address addr) public view returns (bool) {
        return members[addr].isRegistered;
    }
    
    // 获取成员总数
    function getMemberCount() public view returns (uint256) {
        return memberCount;
    }
    
    // ============ 接收 ETH ============
    
    // 直接接收 ETH（自动存入发送者账户，如果是成员）
    receive() external payable {
        if (members[msg.sender].isRegistered) {
            members[msg.sender].balance += msg.value;
            totalDeposits += msg.value;
            emit Deposited(msg.sender, msg.value);
        } else {
            // 非成员转入，计入总存款但不归属任何人
            totalDeposits += msg.value;
        }
    }
    
    fallback() external payable {
        if (members[msg.sender].isRegistered) {
            members[msg.sender].balance += msg.value;
            totalDeposits += msg.value;
            emit Deposited(msg.sender, msg.value);
        } else {
            totalDeposits += msg.value;
        }
    }
}