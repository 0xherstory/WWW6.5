// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

// Contract6：以太坊存钱罐/智能钱包（匹配contract-6需求）
contract EtherPiggyBank {
    // 核心状态变量
    address public owner;                  // 存钱罐主人（管理员）
    uint256 public totalDeposit;           // 累计存款金额
    mapping(address => bool) public allowedWithdrawers; // 授权提款账户

    // 事件：记录存款/提款/授权操作
    event Deposited(address indexed depositor, uint256 amount);
    event Withdrawn(address indexed withdrawer, uint256 amount);
    event AllowedWithdrawerUpdated(address indexed user, bool allowed);

    // 权限修饰器：仅主人可操作
    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this");
        _;
    }

    // 权限修饰器：仅授权账户/主人可提款
    modifier onlyAllowed() {
        require(allowedWithdrawers[msg.sender] || msg.sender == owner, "Not authorized to withdraw");
        _;
    }

    // 构造函数：部署时设置主人
    constructor() {
        owner = msg.sender;
        allowedWithdrawers[owner] = true; // 主人默认可提款
    }

    // 核心功能1：接收ETH（存钱）- 回退函数，直接转ETH到合约地址即触发
    receive() external payable {
        require(msg.value > 0, "Deposit amount must be > 0");
        totalDeposit += msg.value;
        emit Deposited(msg.sender, msg.value);
    }

    // 核心功能2：查看存钱罐余额
    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }

    // 核心功能3：提款（仅授权账户可操作）
    function withdraw(uint256 _amount) public onlyAllowed {
        require(_amount > 0, "Withdraw amount must be > 0");
        require(address(this).balance >= _amount, "Insufficient balance");

        // 转账ETH给提款人
        (bool success, ) = payable(msg.sender).call{value: _amount}("");
        require(success, "Withdraw failed");

        totalDeposit -= _amount;
        emit Withdrawn(msg.sender, _amount);
    }

    // 核心功能4：授权/取消授权提款账户（仅主人可操作）
    function setAllowedWithdrawer(address _user, bool _allowed) public onlyOwner {
        require(_user != address(0), "Invalid user address");
        allowedWithdrawers[_user] = _allowed;
        emit AllowedWithdrawerUpdated(_user, _allowed);
    }

    // 核心功能5：提取全部余额（仅主人可操作）
    function withdrawAll() public onlyOwner {
        uint256 balance = address(this).balance;
        require(balance > 0, "No balance to withdraw");

        (bool success, ) = payable(owner).call{value: balance}("");
        require(success, "Withdraw all failed");

        totalDeposit = 0;
        emit Withdrawn(owner, balance);
    }
}