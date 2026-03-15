// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SecureEtherPiggyBank {
    // 银行经理
    address public bankManager;
    
    // 检查某人是否已被批准存钱
    address[] public members;
    mapping(address => bool) public registeredMembers;
    
    // 记录每位成员的余额
    mapping(address => uint256) public balance;

    // --- 取款请求结构体 ---
    struct WithdrawalRequest {
        uint256 amount;       // 请求金额
        uint256 requestTime;  // 请求发起时间
        bool approved;        // 是否已批准
        bool completed;       // 是否已提取
    }

    // 记录每个成员的取款请求
    mapping(address => WithdrawalRequest) public withdrawalRequests;

    // 请求发起后，设置1分钟冷却期
    uint256 public constant COOLDOWN_PERIOD = 60; 

    constructor() {
        bankManager = msg.sender;
        members.push(msg.sender);
        registeredMembers[msg.sender] = true;
    }

    // 设置银行经理的权限
    modifier onlyBankManager() {
        require(msg.sender == bankManager, "Only bank manager can perform this action");
        _;
    }

    // 确保只有已被正式添加入列表的成员可以存钱或取钱
    modifier onlyRegisteredMember() {
        require(registeredMembers[msg.sender], "Member not registered");
        _;
    }

    // 添加新成员：检查地址是否有效，经理没有重复添加自己，该成员是否已经存在
    function addMember(address _member) public onlyBankManager {
        require(_member != address(0), "Invalid address");
        require(_member != msg.sender, "Bank Manager is already a member");
        require(!registeredMembers[_member], "Member already registered");
        registeredMembers[_member] = true;
        members.push(_member);
    }

    // 查看成员列表
    function getMembers() public view returns (address[] memory) {
        return members;
    }

    // 存款：确保存入金额大于零，将该金额加到你的余额中
    function deposit() public payable onlyRegisteredMember {
        require(msg.value > 0, "Invalid amount");
        balance[msg.sender] += msg.value;
    }

    // 成员调用此函数申请取款，检查金额是否有效，余额是否足够
    function requestWithdraw(uint256 _amount) public onlyRegisteredMember {
        require(_amount > 0, "Invalid amount");
        require(balance[msg.sender] >= _amount, "Insufficient balance");

        // 更新或创建取款请求
        // 注意：这会覆盖之前的未完成请求
        withdrawalRequests[msg.sender] = WithdrawalRequest({
            amount: _amount,
            requestTime: block.timestamp, //记录当前区块时间
            approved: false,
            completed: false
        });
    }

    // 经理检查请求并批准
    function approveWithdraw(address _member) public onlyBankManager {
        WithdrawalRequest storage request = withdrawalRequests[_member];
        
        require(request.amount > 0, "No withdrawal request found");
        require(!request.approved, "Request already approved");
        require(!request.completed, "Funds already withdrawn");

        // 检查是否过了冷却期
        require(
            block.timestamp >= (request.requestTime + COOLDOWN_PERIOD),
            "Cooldown period not expired"
        );

        request.approved = true;
    }

    // 成员在获得批准后调用此函数拿走钱
    function executeWithdraw() public onlyRegisteredMember {
        WithdrawalRequest storage request = withdrawalRequests[msg.sender];
        
        require(request.approved, "Withdrawal not approved");
        require(!request.completed, "Funds already withdrawn");

        uint256 amount = request.amount;
        
        // 重置请求状态
        request.completed = true;
        // 清零金额
        request.amount = 0;
        // 扣除余额并转账
        balance[msg.sender] -= amount;
        // 使用 call 替代 transfer
        (bool success, ) = payable(msg.sender).call{value: amount}("");
        require(success, "Transfer failed");
    }

    // 查询每个成员的银行账户余额
    function getBalance(address _member) public view returns (uint256) {
        require(_member != address(0), "Invalid address");
        return balance[_member];
    } 

    // 查看取款请求详情 (用于前端展示) 
    function getWithdrawalRequest(address _member) 
        public 
        view 
        returns (uint256 amount, uint256 requestTime, bool approved, bool completed) 
    {
        WithdrawalRequest storage request = withdrawalRequests[_member];
        return (request.amount, request.requestTime, request.approved, request.completed);
    }
}
