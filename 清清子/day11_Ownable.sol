// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/*==========================
  母合约：Ownable
  处理合约所有权逻辑
==========================*/
contract Ownable {
    address private owner;

    // 事件：所有权转移
    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    constructor() {
        owner = msg.sender; // 部署者是最初的owner
        emit OwnershipTransferred(address(0), msg.sender);
    }

    // 只能owner调用的修饰符
    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can perform this action");
        _;
    }

    // 查询owner地址
    function ownerAddress() public view returns (address) {
        return owner;
    }

    // 转移所有权
    function transferOwnership(address _newOwner) public onlyOwner {
        require(_newOwner != address(0), "Invalid address");
        address previous = owner;
        owner = _newOwner;
        emit OwnershipTransferred(previous, _newOwner);
    }
}

/*==========================
  子合约：VaultMaster
  继承Ownable，处理存取款
==========================*/
contract VaultMaster is Ownable {
    // 存取款事件
    event DepositSuccessful(address indexed account, uint256 value);
    event WithdrawSuccessful(address indexed recipient, uint256 value);

    // 查询合约总余额
    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }

    // 存款（ETH会自动进入合约地址）
    function deposit() public payable {
        require(msg.value > 0, "Enter a valid amount");
        emit DepositSuccessful(msg.sender, msg.value);
    }

    // 取款（只有owner可以）
    function withdraw(address _to, uint256 _amount) public onlyOwner {
        require(_amount <= getBalance(), "Insufficient balance");

        // 推荐用 call 方式转账
        (bool success, ) = payable(_to).call{value: _amount}("");
        require(success, "Transfer Failed");

        emit WithdrawSuccessful(_to, _amount);
    }
}