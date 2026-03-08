// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract OnlyAdmin {
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Not owner");
        _;
    }

    function transferOwnership(address newOwner) external onlyOwner {
        require(newOwner != address(0), "Zero address");
        owner = newOwner;
    }

    function adminDoSomething() external onlyOwner returns (bool) {
        return true;
    }
}
