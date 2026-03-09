// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SaveMyName {
    string name;
    string bio;
    string age;
    string job;

    // 写
    // memory 表示临时存储
    // 直接使用状态变量在链上写入数据是一个非常昂贵的过程，所以需要使用内存或者临时存储来获取所有数据
    function add(string memory _name, string memory _bio) public {
        name = _name;
        bio = _bio;
    }


    // 读
    // view 无须 gas
    function retrieve() public view returns(string memory, string memory) {
        return (name, bio);
    }


    // 这里接受一个输入，保存它，并立即返回它，看似高效，可是在链上，函数会改变区块链，每次调用都会消耗 gas，即使它是用来展示的
    // 后续学习需要关注如何优化 gas 避免编写过于昂贵的函数
    function saveAndRetrieve(string memory _name, string memory _bio) public returns(string memory, string memory) {
        name = _name;
        bio = _bio;
        return(name, bio);
    }

    function  saveInfos(string memory _name, string  memory _bio, string memory _age, string memory _job) public {
        name = _name;
        bio = _bio;
        age = _age;
        job = _job;
    }

      function logInfos() public view returns(string memory, string memory, string memory, string memory) {
        return (name, bio, age, job);
    } 
  
}