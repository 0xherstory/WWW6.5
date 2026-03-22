// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface Oracle {
    function getPrice() external view returns (uint256);
}

contract Consumer {
    Oracle public oracle;

    constructor(address _oracle) {
        oracle = Oracle(_oracle);
    }

    function getPrice() external view returns (uint256) {
        return oracle.getPrice();
    }
}