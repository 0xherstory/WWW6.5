// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ClickCounter {
    // 状态变量 - 存储点击次数
    uint256 public counter;

    // 原始click函数 - 增加1次
    function click() public {
        counter++;
    }

    // 1. 重置计数器为0
    function reset() public {
        counter = 0;
    }

    // 2. 计数器减1（防止负数）
    function decrease() public {
        // 检查：只有counter>0时才减1，避免变成负数
        if (counter > 0) {
            counter--;
        }
    }

    // 3. 明确返回当前计数（view修饰符：只读，不花Gas）
    function getCounter() public view returns (uint256) {
        return counter;
    }

    // 4. 一次增加指定次数
    function clickMultiple(uint256 times) public {
        // 累加指定次数（times可以是任意正整数）
        counter += times;
    }
}