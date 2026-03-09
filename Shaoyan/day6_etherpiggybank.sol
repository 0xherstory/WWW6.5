// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract RealWorldTreasury {
    // 1. 谁是负责人？
    address public manager;
    
    // 2. 谁是成员 & 3. 存了多少钱？
    // 用 mapping 建立成员地址到存款金额的映射，这就像是一本电子存折
    mapping(address => uint256) public memberBalances;
    mapping(address => bool) public isMember;

    // 修饰符：定义规则，只有经理才能执行特定操作
    modifier onlyManager() {
        require(msg.sender == manager, "Only manager can perform this");
        _;
    }

    // 初始化：构造函数，部署合约时确定经理
    constructor() {
        manager = msg.sender;
    }

    // 添加新成员
    function addMember(address _member) public onlyManager {
        require(_member != address(0), "Invalid address");
        require(!isMember[_member], "Member already exists");
        require(_member != manager, "Manager is already the boss");
        
        isMember[_member] = true;
    }

    // 存款：使用 payable 和 msg.value 接收真正的以太币
    // 任何人都可以存，但只有成员存入的才会被记录
    function deposit() public payable {
        require(isMember[msg.sender], "You are not a member");
        require(msg.value > 0, "Deposit must be greater than 0");
        
        // 更新存折
        memberBalances[msg.sender] += msg.value;
    }

    // 取钱：将真正的以太币退还给用户
    function withdraw(uint256 _amount) public {
        require(memberBalances[msg.sender] >= _amount, "Insufficient funds");

        // 1. 先扣账 (防止重入攻击)
        memberBalances[msg.sender] -= _amount;

        // 2. 实际转账
        (bool success, ) = payable(msg.sender).call{value: _amount}("");
        require(success, "Transfer failed");
    }

    // 查看当前成员余额
    function getMyBalance() public view returns (uint256) {
        return memberBalances[msg.sender];
    }
}