// SPDX-License-Identifier:MIT
pragma solidity ^0.8.0;

contract SaveMyName{

  string name;
  string bio;
  //状态变量 
  //文本

  function add (string memory _name, string memory _bio )public {
  //函数
  //function函数名字（传入参数）returns（返回此参数） {...}
  //意思是：一个叫做add的函数，接受两个传入参数，没有返回参数

  //使用memory的原因：
  //Solidity 有两种主要的存储类型：
  //Storage (存储）:永久存储在区块链上的数据（例如姓名和简介）。
  //Memory （内存）:仅在函数运行时存在的临时存储空间。
    name = _name;
    //name就是状态变量
    //_name是传入参数 （前面的“-”是为了和状态变量区分；怎么写都随便，newname也可以）
    //这一步意思是，把状态变量name改成_name
    bio = _bio;
  }

  function retrieve() public view returns(string memory, string memory){
    return (name,bio);
  //函数
  //一个叫做retrieve的函数，不接受传入参数，返回两个参数，string类型的返回值
  //retrive是检索的意思，上一步将名字和简介存入，这一步就要获取信息。没有传入信息，只有返回信息
  
  //view: 被标记为 view 的函数在被调用时不会消耗 gas。
  }

}