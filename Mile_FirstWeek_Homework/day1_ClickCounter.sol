// 声明开源协议，必须写
// SPDX-License-Identifier: MIT

// 指定solidity编译器版本，0.8.0以上
pragma solidity ^0.8.0;

// 定义合约：点击计数器
contract ClickCounter {

    // 定义一个公共数字变量，用来存储点击次数
    // 初始值默认是 0
    uint256 public counter;

    // ---------------------- 基础功能 ----------------------
    // 点击一次，数字 +1
    function click() public {
        counter = counter + 1; // 计数器加1
    }

    // ---------------------- 作业1 ----------------------
    // 重置功能：把数字变回 0
    function reset() public {
        counter = 0;
    }

    // ---------------------- 作业2 ----------------------
    // 减少功能：数字 -1（保证不会变成负数）
    function decrease() public {
        // 只有数字大于0的时候，才能减1
        if (counter > 0) {
            counter = counter - 1;
        }
    }

    // ---------------------- 作业3 ----------------------
    // 获取当前数字：只查看，不修改数据
    function getCounter() public view returns(uint256) {
        return counter;
    }

    // ---------------------- 作业4 ----------------------
    // 一次性增加多次：输入几就加几
    function clickMultiple(uint256 times) public {
        counter = counter + times;
    }
}
