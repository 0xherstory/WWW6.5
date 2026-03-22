// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract TipJar {
    address public owner;
    uint256 public totalTips;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner {
        require(msg.sender == owner, "Not owner");
        _;
    }

    function tip() external payable {
        require(msg.value > 0, "Tip must be greater than 0");
        totalTips += msg.value;
    }

    function withdraw() external onlyOwner {
        // 只改这一行，修复 transfer 警告
        (bool success, ) = payable(owner).call{value: address(this).balance}("");
        require(success, "Transfer failed");
    }
}