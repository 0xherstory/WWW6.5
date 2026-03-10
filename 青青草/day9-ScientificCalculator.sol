// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ScientificCalculator{
 //先编写一个用于计算幂的函数(此函数返回base的exponent次幂的结果）
    function power(uint256 base, uint256 exponent) public pure returns (uint256) {
        //pure:不读取或更改区块链上的任何内容。只进行数学运算
        if (exponent == 0) return 1;
        else return (base ** exponent);
    }
//编写一个估算平方根的函数
    function squareRopt(int256 number) public pure returns (int256){
        require (number >= 0, "Cannot calculate square root of negative number");
        if (number == 0) return 0;

        int256 result = number /2;
        for (uint256 i = 0; i < 10; i++){
            result = (result + number / result) /2;
        }
        return result;
    }
        //int256支持负数，uint只支持正数

}