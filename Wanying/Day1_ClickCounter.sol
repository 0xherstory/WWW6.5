// SPDX-License-Identifier:MIT 
// 这是指这个代码可以被任何人使用，而且本人不需要对代码负责

pragma solidity ^0.8.0; 
// 使用的是哪一个版本contract

contract ClickCounter {

    uint256 public counter ;
    // uint256 = unsigned integer 256-bit，无符号整数256位，即非负整数，最大值为2^256-1
    // public = 谁都可以读取 / 调用

    function click() public {
        counter ++;
    }
}