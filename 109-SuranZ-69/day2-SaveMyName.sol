// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SaveMyName{
    // 声明两个变量
    string name;
    string bio;

    // add()函数 - 存储数据
    // $name和$bio是函数参数
    function add(string memory $name, string memory $bio) public {
    name = $name;
    bio = $bio;
    }

    // retrieve()检索函数 - 从区块链获取数据
    function retrieve() public view returns (string memory, string memory) {
        return (name, bio);
    }
}