//每个合约前面都要写上
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

//一个叫做clickcounter的合约
contract Clickcounter{

//状态变量：储存的数据
//uint：指的是整数（无符号的整数）-1就不可以，因为前面有符号；int：任意整数（0，-1，2）
//意思是：一个叫做counter的整数状态变量
    uint256 public counter ;

//函数：做某一件事情
//一个叫做click的函数，不读取数据（因为括号里面没东西）
    function click() public 
    {
        counter ++;
        //a++   意思是：a=a+1
        //a- -  意思是：a=a-1
        //a+=b 意思是：a=a+b
        //a-=b 意思是：a=a-b
    }
}