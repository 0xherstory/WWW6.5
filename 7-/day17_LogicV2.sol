// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract LogicV2 {
    uint public value;

    function setValue(uint _value) external {
        value = _value;
    }

    function increment() external {
        value += 1;
    }
}