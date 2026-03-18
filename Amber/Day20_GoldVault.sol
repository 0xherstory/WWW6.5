// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

// 引入重入保护（安全版本用）
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";

contract GoldVault is ReentrancyGuard {

    // 用户余额记录
    mapping(address => uint256) public balances;

    // =========================
    // 存款函数
    // =========================
    function deposit() external payable {
        require(msg.value > 0, "Must deposit ETH");

        balances[msg.sender] += msg.value;
    }

    // =========================
    // ❌ 存在漏洞的提现函数
    // =========================
    function vulnerableWithdraw() external {
        uint256 amount = balances[msg.sender];

        require(amount > 0, "No balance");

        // ⚠️ 关键漏洞：
        // 先转钱，再更新余额
        (bool success, ) = msg.sender.call{value: amount}("");
        require(success, "Transfer failed");

        // ❌ 太晚更新余额（会被重入攻击利用）
        balances[msg.sender] = 0;
    }

    // =========================
    // ✅ 安全的提现函数
    // =========================
    function safeWithdraw() external nonReentrant {
        uint256 amount = balances[msg.sender];

        require(amount > 0, "No balance");

        // ✅ 先更新余额（Checks-Effects-Interactions）
        balances[msg.sender] = 0;

        // 再转钱
        (bool success, ) = msg.sender.call{value: amount}("");
        require(success, "Transfer failed");
    }

    // 查看合约余额
    function getVaultBalance() external view returns (uint256) {
        return address(this).balance;
    }
}
