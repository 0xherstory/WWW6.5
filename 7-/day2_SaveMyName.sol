// SPDX-License-Identifier: MIT
// 指定编译器版本（和网页要求一致）
pragma solidity ^0.8.27;

// 合约名：SaveMyName
contract SaveMyName {
    // 状态变量：存储名字（字符串类型）
    string public myName;

    // 函数1：设置名字（接收字符串参数）
    function setName(string memory _name) public {
        myName = _name; // 把输入的名字赋值给状态变量
    }

    // 函数2：读取名字（view修饰符，只读不修改状态）
    function getName() public view returns (string memory) {
        return myName; // 返回已存储的名字
    }

    // 额外拓展：清空名字（可选，网页没要求，练手用）
    function clearName() public {
        myName = ""; // 把名字置为空字符串
    }
}