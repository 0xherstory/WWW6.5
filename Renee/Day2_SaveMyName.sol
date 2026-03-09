// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0; // 就像古代文言文，现在用现代汉语，要声明是什么时代/版本的语言

contract SaveMyName {
    string name;
    string bio;

    /*
    function add(string memory _name, string memory _bio) public {
        name = _name;
        bio = _bio;
    }

    function retrieve() public view returns (string memory, string memory) {
        //A function marked as view does not cost gas when called.
        return (name, bio);
    }
    // 可以把这两个函数理解成：写入和读取功能，就像你的笔记本一样
    // 你可以写入任何名字和简介，然后随时读取出来
    */

    function SaveAndRetrieve(string memory _name, string memory _bio) public returns(string memory, string memory) {
        name = _name;
        bio = _bio;
        return (name, bio);
    }
}