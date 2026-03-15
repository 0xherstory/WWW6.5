// SPDX-License-Identifier:MIT

pragma solidity ^0.8.0;

contract SaveMyName{
//string x是状态变量（意味永久储存 //占位符_使其变成函数参数    
  string name;
  string bio;
//function setProfile(string memory _name, string memory _bio) public {
//    name = _name;
//    bio = _bio;
//代码常见 setProfile() getProfile()写法
//Storage (永久存储）Memory （内存，草稿纸，仅在函数运行时存在的临时存储空间）
  function add (string memory _name, string memory _bio )public {
    name = _name;
    bio = _bio;
  }
//被标记为 view 的函数在被调用时不会消耗 gas。它只是获取并返回现有数据。（使函数可以自由调用，它不会修改区块链）
//所以 retrieve()可以免费调用——它不会在区块链上做任何改变。它只是读取并返回存储的名称和简介。
  function retrieve() public view returns(string memory, string memory){
    return (name,bio);
  }
//return向调用它的任何人返回数据
//saveAndRetrieve需要消耗gas（组合可以更简短，但是可能会增加gas费
}