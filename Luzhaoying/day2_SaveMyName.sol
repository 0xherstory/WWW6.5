// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SaveMyInfo {
    // 状态变量
    string public name;
    string public bio;
    string public occupation;
    uint256 public age;
    string public gender;

    // 存储数据
    function saveInfo(
        string memory _name, 
        string memory _bio, 
        string memory _occupation,
        uint256 _age,
        string memory _gender
    ) public {
        name = _name;
        bio = _bio;
        occupation = _occupation;
        age = _age;
        gender = _gender;
    }

    function retrieve() public view returns (
        string memory,
        string memory,
        string memory,
        uint256,
        string memory
    ) {
        return (name, bio, occupation, age, gender);
    }
}