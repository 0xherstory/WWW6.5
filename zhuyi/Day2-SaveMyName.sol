// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SaveMyName {
    // 状态变量 - 永久存储在区块链上
    string name;
    string bio;

    // 存储数据 0
    function add(string memory _name, string memory _bio) public {
    name = _name; // _name占位符（name 状态变量; _name 函数参数
    bio = _bio;
}

    function retrieve() public view returns (string memory, string memory) {
    return (name, bio);
}


    
    // 组合函数 - 保存并立即返回
    function saveAndRetrieve(string memory _name, string memory _bio) public returns (string memory, string memory) {
    name = _name;
    bio = _bio;
    return (name, bio);
}
    //为什么deploy时，当环境为shanghai时，saveAndRetrieve()函数报错
    //"error": "Failed to decode output: RangeError: data out-of-bounds (buffer=0x, length=0, offset=32, code=BUFFER_OVERRUN, version=6.14.0)"
    //看起来是gas不够
    //将环境改为Osaka就成功了
}