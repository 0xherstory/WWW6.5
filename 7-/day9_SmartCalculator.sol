// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SmartCalculator {
    function add(uint a, uint b) external pure returns (uint) {
        return a + b;
    }

    function sub(uint a, uint b) external pure returns (uint) {
        require(b <= a, "a must be >= b");
        return a - b;
    }

    function mul(uint a, uint b) external pure returns (uint) {
        return a * b;
    }

    function div(uint a, uint b) external pure returns (uint) {
        require(b > 0, "Cannot divide by zero");
        return a / b;
    }
}