// SPDX-License-Identifier:MIT

// 声明Solidity版本，要求编译器版本在0.8.0或更高（但低于0.9.0）
pragma solidity ^0.8.0;

// 定义一个名为SaveMyName的合约，用于存储和检索姓名与简介
contract SaveMyName{
     
  // 声明一个字符串类型的私有状态变量name（默认私有）
  string name;
  
  // 声明一个字符串类型的私有状态变量bio（默认私有）
  string bio;

  // 定义一个名为add的公共函数，用于设置姓名和简介
  // memory关键字表示参数数据存储在内存中（临时存储）
  // _name 和 _bio 是函数参数（参数名通常用下划线前缀表示）
  function add (string memory _name, string memory _bio )public {
    // 将传入的_name值赋给状态变量name
    name = _name;
    
    // 将传入的_bio值赋给状态变量bio
    bio = _bio;
  }

  // 定义一个名为retrieve的公共函数，用于获取姓名和简介
  // view关键字表示该函数只读取状态变量，不修改任何状态（不消耗gas）
  // returns声明返回值类型为两个字符串
  function retrieve() public view returns(string memory, string memory){
    // 返回name和bio的值（以元组形式返回多个值）
    return (name,bio);
  }

}