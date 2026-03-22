// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ActivityChecker {
    address public owner;
    uint256 public maxInactiveDuration;
    mapping(address => uint256) public lastActiveTime;

    constructor(uint256 _maxInactiveDuration) {
        owner = msg.sender;
        maxInactiveDuration = _maxInactiveDuration;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this function");
        _;
    }

    function checkIn(address user) external onlyOwner {
        lastActiveTime[user] = block.timestamp;
    }

    function isUserInactive(address user) public view returns (bool) {
        if (lastActiveTime[user] == 0) {
            return true;
        }
        return block.timestamp - lastActiveTime[user] > maxInactiveDuration;
    }

    function setMaxInactiveDuration(uint256 _newDuration) external onlyOwner {
        maxInactiveDuration = _newDuration;
    }
}