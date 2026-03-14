//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract ScientificCalculator{

    // 求基数(base) 的给定指次数 (exponent) 的结果。pure同样表明只是本地的简单输出纯逻辑计算。
    function power(uint256 base, uint256 exponent)public pure returns(uint256){
        if(exponent == 0)return 1; // 零次方均为 1
        else return (base ** exponent); // '**' 在Solidity等价于指数的意思
    }

    // 以牛顿法逼近求取输入数的平方根 （Solidity 因为不具备浮点数运算支持这使这种开箱式求近似正变得常用）
    function squareRoot(int256 number)public pure returns(int256){
        require(number >= 0, "Cannot calculate square root of negative number"); // 数学要求被开方根必须不是负的
        if(number == 0)return 0;

        int256 result = number/2; // 原始预估近似值
        // 为保证它不仅消耗光所有的手续费且死锁(Gas exhausted), 人为限制让逼近只能进行 10 轮
        // 虽然轮次限制代表得不到精确数字，但足够反映逼近的过程
        for(uint256 i = 0; i<10; i++){
            result = (result + number / result)/2; // 牛顿迭代法的基础公约公式
        }

        return result; // 反馈出求取之后的收敛值
    }
}