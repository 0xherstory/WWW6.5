// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract IOU {
    // ============ 数据结构 ============
    
    // 用户余额
    mapping(address => uint256) public balances;
    
    // 嵌套 mapping：谁欠谁多少钱
    // debts[ debtor ][ creditor ] = amount
    mapping(address => mapping(address => uint256)) public debts;
    
    // 总债务记录（用于统计）
    mapping(address => uint256) public totalOwed;      // 某人总共欠别人多少
    mapping(address => uint256) public totalOwedTo;    // 别人总共欠某人多少
    
    // 成员管理
    mapping(address => bool) public isMember;
    address[] public memberList;
    uint256 public memberCount;
    
    // 群主/管理员
    address public owner;
    
    // ============ 事件 ============
    event MemberAdded(address indexed member);
    event MemberRemoved(address indexed member);
    event Deposited(address indexed member, uint256 amount);
    event Withdrawn(address indexed member, uint256 amount);
    event IOUCreated(
        address indexed debtor, 
        address indexed creditor, 
        uint256 amount, 
        string reason
    );
    event IOUPaid(
        address indexed debtor, 
        address indexed creditor, 
        uint256 amount
    );
    event DebtSettled(
        address indexed debtor, 
        address indexed creditor, 
        uint256 amount
    );
    event OwnerChanged(address indexed oldOwner, address indexed newOwner);
    
    // ============ 修饰符 ============
    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this");
        _;
    }
    
    modifier onlyMember() {
        require(isMember[msg.sender], "Not a member");
        _;
    }
    
    // ============ 构造函数 ============
    constructor() {
        owner = msg.sender;
        isMember[msg.sender] = true;
        memberList.push(msg.sender);
        memberCount = 1;
    }
    
    // ============ 成员管理 ============
    
    // 添加成员
    function addMember(address member) public onlyOwner {
        require(member != address(0), "Invalid address");
        require(!isMember[member], "Already a member");
        
        isMember[member] = true;
        memberList.push(member);
        memberCount++;
        
        emit MemberAdded(member);
    }
    
    // 批量添加成员
    function addMembers(address[] memory members) public onlyOwner {
        for (uint i = 0; i < members.length; i++) {
            if (!isMember[members[i]] && members[i] != address(0)) {
                isMember[members[i]] = true;
                memberList.push(members[i]);
                memberCount++;
                emit MemberAdded(members[i]);
            }
        }
    }
    
    // 移除成员
    function removeMember(address member) public onlyOwner {
        require(isMember[member], "Not a member");
        require(member != owner, "Cannot remove owner");
        require(balances[member] == 0, "Member still has balance");
        require(totalOwed[member] == 0, "Member still has debts");
        require(totalOwedTo[member] == 0, "Member still has credits");
        
        isMember[member] = false;
        memberCount--;
        
        emit MemberRemoved(member);
    }
    
    // 转移群主
    function transferOwnership(address newOwner) public onlyOwner {
        require(newOwner != address(0), "Invalid address");
        require(isMember[newOwner], "New owner must be a member");
        
        address oldOwner = owner;
        owner = newOwner;
        
        emit OwnerChanged(oldOwner, newOwner);
    }
    
    // ============ 存款与提款 ============
    
    // 存入 ETH 到个人账户
    function deposit() public payable onlyMember {
        require(msg.value > 0, "Must deposit some ETH");
        
        balances[msg.sender] += msg.value;
        
        emit Deposited(msg.sender, msg.value);
    }
    
    // 提取个人账户余额
    function withdraw(uint256 amount) public onlyMember {
        require(amount > 0, "Amount must be greater than 0");
        require(amount <= balances[msg.sender], "Insufficient balance");
        
        balances[msg.sender] -= amount;
        
        // 使用 call 代替 transfer（更现代的方式）
        (bool success, ) = payable(msg.sender).call{value: amount}("");
        require(success, "Transfer failed");
        
        emit Withdrawn(msg.sender, amount);
    }
    
    // 提取全部余额
    function withdrawAll() public onlyMember {
        uint256 amount = balances[msg.sender];
        require(amount > 0, "No balance to withdraw");
        
        balances[msg.sender] = 0;
        
        (bool success, ) = payable(msg.sender).call{value: amount}("");
        require(success, "Transfer failed");
        
        emit Withdrawn(msg.sender, amount);
    }
    
    // ============ IOU 核心功能 ============
    
    // 创建欠条：msg.sender 欠 creditor amount ETH
    function createIOU(address creditor, uint256 amount, string memory reason) public onlyMember {
        require(isMember[creditor], "Creditor must be a member");
        require(creditor != msg.sender, "Cannot owe yourself");
        require(amount > 0, "Amount must be greater than 0");
        
        debts[msg.sender][creditor] += amount;
        totalOwed[msg.sender] += amount;
        totalOwedTo[creditor] += amount;
        
        emit IOUCreated(msg.sender, creditor, amount, reason);
    }
    
    // 偿还债务：用个人余额支付给 creditor
    function payDebt(address creditor, uint256 amount) public onlyMember {
        require(isMember[creditor], "Creditor must be a member");
        require(amount > 0, "Amount must be greater than 0");
        require(debts[msg.sender][creditor] >= amount, "Debt amount exceeded");
        require(balances[msg.sender] >= amount, "Insufficient balance");
        
        // 更新债务记录
        debts[msg.sender][creditor] -= amount;
        totalOwed[msg.sender] -= amount;
        totalOwedTo[creditor] -= amount;
        
        // 转账
        balances[msg.sender] -= amount;
        balances[creditor] += amount;
        
        emit IOUPaid(msg.sender, creditor, amount);
    }
    
    // 用 ETH 直接偿还债务
    function payDebtWithETH(address creditor) public payable onlyMember {
        require(isMember[creditor], "Creditor must be a member");
        require(msg.value > 0, "Must send some ETH");
        
        uint256 debtAmount = debts[msg.sender][creditor];
        require(debtAmount > 0, "No debt to this creditor");
        
        uint256 payAmount = msg.value;
        if (payAmount > debtAmount) {
            payAmount = debtAmount;
        }
        
        // 更新债务
        debts[msg.sender][creditor] -= payAmount;
        totalOwed[msg.sender] -= payAmount;
        totalOwedTo[creditor] -= payAmount;
        
        // 超额部分存入债务人账户
        if (msg.value > payAmount) {
            balances[msg.sender] += (msg.value - payAmount);
        }
        
        // 给债权人入账
        balances[creditor] += payAmount;
        
        emit IOUPaid(msg.sender, creditor, payAmount);
    }
    
    // 结清全部债务给指定债权人
    function settleDebt(address creditor) public onlyMember {
        uint256 debtAmount = debts[msg.sender][creditor];
        require(debtAmount > 0, "No debt to settle");
        require(balances[msg.sender] >= debtAmount, "Insufficient balance");
        
        debts[msg.sender][creditor] = 0;
        totalOwed[msg.sender] -= debtAmount;
        totalOwedTo[creditor] -= debtAmount;
        
        balances[msg.sender] -= debtAmount;
        balances[creditor] += debtAmount;
        
        emit DebtSettled(msg.sender, creditor, debtAmount);
    }
    
    // 债务和解：债权人减免部分债务（需要债权人调用）
    function forgiveDebt(address debtor, uint256 amount) public onlyMember {
        require(isMember[debtor], "Debtor must be a member");
        require(amount > 0, "Amount must be greater than 0");
        require(debts[debtor][msg.sender] >= amount, "Debt amount exceeded");
        
        debts[debtor][msg.sender] -= amount;
        totalOwed[debtor] -= amount;
        totalOwedTo[msg.sender] -= amount;
        
        emit IOUPaid(debtor, msg.sender, amount);
    }
    
    // ============ 批量结算 ============
    
    // 智能结算：自动用余额偿还所有债务（按顺序）
    function settleAllDebts() public onlyMember {
        uint256 myBalance = balances[msg.sender];
        require(myBalance > 0, "No balance to settle debts");
        require(totalOwed[msg.sender] > 0, "No debts to settle");
        
        uint256 remaining = myBalance;
        
        for (uint i = 0; i < memberList.length && remaining > 0; i++) {
            address creditor = memberList[i];
            uint256 debt = debts[msg.sender][creditor];
            
            if (debt > 0) {
                uint256 payAmount = debt;
                if (payAmount > remaining) {
                    payAmount = remaining;
                }
                
                debts[msg.sender][creditor] -= payAmount;
                totalOwed[msg.sender] -= payAmount;
                totalOwedTo[creditor] -= payAmount;
                balances[creditor] += payAmount;
                remaining -= payAmount;
                
                emit IOUPaid(msg.sender, creditor, payAmount);
            }
        }
        
        balances[msg.sender] = remaining;
    }
    
    // ============ 查询功能 ============
    
    // 查询两个成员之间的债务关系
    function getDebt(address debtor, address creditor) public view returns (uint256) {
        return debts[debtor][creditor];
    }
    
    // 查询某人的全部债务详情
    function getMyDebts() public view onlyMember returns (
        address[] memory creditors,
        uint256[] memory amounts
    ) {
        uint256 count = 0;
        for (uint i = 0; i < memberList.length; i++) {
            if (debts[msg.sender][memberList[i]] > 0) {
                count++;
            }
        }
        
        creditors = new address[](count);
        amounts = new uint256[](count);
        
        uint256 idx = 0;
        for (uint i = 0; i < memberList.length; i++) {
            uint256 debt = debts[msg.sender][memberList[i]];
            if (debt > 0) {
                creditors[idx] = memberList[i];
                amounts[idx] = debt;
                idx++;
            }
        }
        
        return (creditors, amounts);
    }
    
    // 查询某人的全部债权详情
    function getMyCredits() public view onlyMember returns (
        address[] memory debtors,
        uint256[] memory amounts
    ) {
        uint256 count = 0;
        for (uint i = 0; i < memberList.length; i++) {
            if (debts[memberList[i]][msg.sender] > 0) {
                count++;
            }
        }
        
        debtors = new address[](count);
        amounts = new uint256[](count);
        
        uint256 idx = 0;
        for (uint i = 0; i < memberList.length; i++) {
            uint256 credit = debts[memberList[i]][msg.sender];
            if (credit > 0) {
                debtors[idx] = memberList[i];
                amounts[idx] = credit;
                idx++;
            }
        }
        
        return (debtors, amounts);
    }
    
    // 查询净债务（正数表示欠别人，负数表示别人欠你）
    function getNetDebt(address member) public view returns (int256) {
        return int256(totalOwed[member]) - int256(totalOwedTo[member]);
    }
    
    // 查询个人财务概况
    function getMySummary() public view onlyMember returns (
        uint256 balance,
        uint256 totalDebt,
        uint256 totalCredit,
        int256 netPosition
    ) {
        balance = balances[msg.sender];
        totalDebt = totalOwed[msg.sender];
        totalCredit = totalOwedTo[msg.sender];
        netPosition = getNetDebt(msg.sender);
    }
    
    // 获取成员列表
    function getMembers() public view returns (address[] memory) {
        return memberList;
    }
    
    // 获取合约总余额
    function getContractBalance() public view returns (uint256) {
        return address(this).balance;
    }
    
    // 检查债务是否存在
    function hasDebt(address debtor, address creditor) public view returns (bool) {
        return debts[debtor][creditor] > 0;
    }
    
    // ============ 接收 ETH ============
    
    receive() external payable {
        if (isMember[msg.sender]) {
            balances[msg.sender] += msg.value;
            emit Deposited(msg.sender, msg.value);
        }
        // 非成员转入，只增加合约余额，不归属任何人
    }
    
    fallback() external payable {
        if (isMember[msg.sender]) {
            balances[msg.sender] += msg.value;
            emit Deposited(msg.sender, msg.value);
        }
    }
}