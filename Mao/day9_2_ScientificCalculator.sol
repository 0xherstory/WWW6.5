//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

//这个合约将存放高级功能——比如指数运算（幂运算）和平方根计算。

contract ScientificCalculator {
    // advanced functions will go here
    //计算幂函数
    //pure，因为它不读取或更改区块链上的任何内容。它只是进行数学运算。
    function power(uint256 base, uint256 exponent) public pure returns(uint256){
        if(exponent == 0) return 1;
        else return (base ** exponent);
    }

    //牛顿法来估算一个数的平方根
    function squareRoot(uint256 number) public pure returns(uint256){
        require(number >= 0, "Cannot calculate square root of negative number");
        if(number == 0) return 0;
        
       uint256 result = number / 2;
       for (uint256 i = 0; i < 10; i++) {
            result = (result + number / result) / 2;
        }
        return result;
    }
}