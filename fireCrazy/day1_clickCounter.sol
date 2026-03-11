// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ClickCounter {
    uint256 public counter;
    address public boss;

    constructor() {
        boss = msg.sender; 
    }

    function click() public {
        require(counter < 100, "Too many clicks!");
        counter++; 
    }

    function reset() public {
        require(msg.sender == boss, "Not the boss!");
        counter = 0;
    }
}
