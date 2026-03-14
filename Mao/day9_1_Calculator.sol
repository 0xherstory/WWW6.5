//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

//它处理加法、减法、乘法和除法等基本数学运算。
//当它需要更高级的数学运算帮助时，它会将任务委托出去。
/*为了从 ScientificCalculator 中调用函数，在 Calculator 合约内，
我们将 导入（import）它并存储其部署地址。
重要提示：请将两个文件放在同一目录下，以确保导入时不会出现问题。*/

//1、pure 不修改区块链的内容但是去进行数字的计算
//2、连接到另外一个合约的幂函数，首先就是先将 地址对象转换成合约的对象，这个对象去调用自己的函数即可

import "./day9_2_ScientificCalculator.sol";

contract Calculator {
    // basic math functions}
    //状态变量
    address public owner;
    address public scientificCalculatorAddress;

    constructor(){
        owner = msg.sender;
    }

    modifier  onlyOwner() {
        require(msg.sender == owner, "Only owner can call this function");
        _;
    }
    
    //所有者来允许连接一个ScientificCalculator
    function setScientificCalcuator(address _address) public onlyOwner{
        scientificCalculatorAddress = _address;
    }
   
   //基础的数学函数 ，pure函数，因为它不读取或更改区块链上的任何内容。它只是进行数学运算
   function add(uint256 a, uint256 b) public pure returns (uint256){
      uint256 result = a+b;
      return result;
   }

   function subtract(uint256 a, uint256 b)public pure returns (uint256){
      uint256 result = a-b;
      return result;
   }

   function multiply(uint256 a, uint256 b) public pure returns (uint256) {
    uint256 result = a * b;
    return result;
   }

   function divide(uint256 a, uint256 b) public pure returns (uint256) {
    require(b != 0, "Cannot divide by zero");
    uint256 result = a / b;
    return result;
  }
   
   //连接到另外一个合约的幂函数
   function calculatePower(uint256 base,uint256 exponent) public view returns(uint256){
     //地址转换：将地址对象转换成一个合约
     ScientificCalculator scientificCalc = ScientificCalculator(scientificCalculatorAddress);
     uint256 result = scientificCalc.power(base, exponent);
     return result;
   }


  // 定义一个函数：接收一个数字，返回它的平方根
function calculateSquareRoot(uint256 number) public returns (uint256) {
    // 步骤1：校验输入（虽然uint256本身不可能是负数，但写了更友好）
    require(number >= 0, "Cannot calculate square root of negative number");
    // 人话：先检查数字是不是负数，负数没法算平方根，直接报错

    // 步骤2：把“调用squareRoot函数+传number”翻译成EVM能懂的二进制
    bytes memory data = abi.encodeWithSignature("squareRoot(int256)", number);
    // 人话：
    // - "squareRoot(int256)"：告诉EVM要调用的函数名+参数类型（这里有个小坑，后面说）
    // - abi.encodeWithSignature：把“函数名+参数”打包成字节数组（相当于翻译）

    // 步骤3：用翻译好的内容，给目标合约地址打电话
    (bool success, bytes memory returnData) = scientificCalculatorAddress.call(data);
    // 人话：
    // - scientificCalculatorAddress：隔壁老王的手机号（目标合约地址）
    // - .call(data)：打过去，把翻译好的“算平方根+数字”发过去
    // - 返回两个结果：success（电话通了/算成功了？）、returnData（老王算的结果，二进制）

    // 步骤4：检查电话是不是通了、计算是不是成功了
    require(success, "External call failed");
    // 人话：如果调用失败（比如地址错了、函数名写错了），直接报错

    // 步骤5：把老王返回的二进制结果，翻译回uint256数字
    uint256 result = abi.decode(returnData, (uint256));
    // 人话：把二进制的结果转成我们能看懂的数字

    // 步骤6：把结果返回给调用这个函数的人
    return result;
}
    

}