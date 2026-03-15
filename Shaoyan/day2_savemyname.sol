// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SaveMyName {
    // 定义职业枚举，随便举个例子
    enum Occupation {
        employed, // 0
        Other       // 1
    }

    string public name;
    string public bio;
    uint8 public age;          // 年龄用string不经济，具体原理还没懂，先参考
    Occupation public occupation; // 职业使用枚举，存储为 enum

    function add(
        string memory _name,
        string memory _bio,
        uint8 _age,
        Occupation _occupation
    ) public {
        name = _name;
        bio = _bio;
        age = _age;
        occupation = _occupation;
    }

    function getInfo() public view returns (
        string memory,
        string memory,
        uint8,
        Occupation
    ) {
        return (name, bio, age, occupation);
    }

    /**
     * @dev 获取核心个人信息（名字和简介）
     * @return 名字、简介
     */
    function retrieve() public view returns (string memory, string memory) {
        return (name, bio);
    }
}