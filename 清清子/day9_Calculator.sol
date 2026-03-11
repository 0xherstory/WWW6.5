// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./day9-ScientificCalculator.sol";
import "./day9-CalculatorInterface.sol"; 

contract Calculator {
    address public calculatorAddress; // 记录calculator合约地址
    address public owner;

    // 构造函数，初始化ScientificCalculator合约地址
    // 决定了部署顺序：先部署ScientificCalculator，获取地址后再部署Calculator
    constructor(address _calculatorAddress) {
        owner = msg.sender;

        // 记录calculator合约地址
        calculatorAddress = _calculatorAddress;
    }

    // 调用ScientificCalculator的power函数
    function calculatePower(uint256 _base, uint256 _exponent) public view returns (uint256) {
        require(calculatorAddress != address(0), "Invalid calculator address");

        ScientificCalculator scientificCalc = ScientificCalculator(calculatorAddress);
        uint256 result = scientificCalc.power(_base, _exponent);
        return result;
    }

    // 调用ScientificCalculator的squareRoot函数
    function calculateSquareRoot(uint256 number) public view returns (uint256) {
        ScientificCalculator scientificCalc = ScientificCalculator(calculatorAddress);
        uint256 result = scientificCalc.squareRoot(number);
        return result;
    }

    // 拓展功能：调用ScientificCalculator的factorial函数
    function calculateFactorial(uint256 n) public view returns (uint256) {
        ScientificCalculator scientificCalc = ScientificCalculator(calculatorAddress);
        uint256 result = scientificCalc.factorial(n);
        return result;
    }

    // 实现批量计算功能（一次调用多个计算）
    function batchCalculate(uint256[] memory bases, uint256[] memory exponents) public view returns (uint256[] memory) {
        ScientificCalculator scientificCalc = ScientificCalculator(calculatorAddress);
        require(bases.length == exponents.length, "Input arrays must have the same length");
        uint256[] memory results = new uint256[](bases.length);
        // 如何确定调用哪个函数？
        for (uint256 i = 0; i < bases.length; i++) {
            results[i] = scientificCalc.power(bases[i], exponents[i]);
        }
        return results;
    }

    // 批量计算功能
    function batchCalculateMixed(uint256[] memory numbers) public view returns (uint256[] memory) {
        ScientificCalculator scientificCalc = ScientificCalculator(calculatorAddress);
        uint256[] memory results = new uint256[](numbers.length);
        for (uint256 i = 0; i < numbers.length; i++) {
            if (i % 3 == 0) {
                results[i] = scientificCalc.power(numbers[i], 2); // 平方
            } else if (i % 3 == 1) {
                results[i] = scientificCalc.squareRoot(numbers[i]); // 平方根
            } else {
                results[i] = scientificCalc.factorial(numbers[i]); // 阶乘
            }
        }
        return results;
    }

    // 使用interface而不是import完整的合约, 1以power函数为例
    function calculatePowerWithInterface(uint256 _base, uint256 _exponent) public view returns (uint256) {
        IScientificCalculator calc = IScientificCalculator(calculatorAddress);
        uint256 result = calc.power(_base, _exponent);
        return result;
    }

    // divide
    function calculateDivide(uint256 dividend, uint256 divisor) public view returns (uint256 quotient, uint256 remainder) {
        IScientificCalculator calculatorInterface = IScientificCalculator(calculatorAddress);
        (quotient, remainder) = calculatorInterface.divide(dividend, divisor);
        return (quotient, remainder);
    }

    // 增加低级调用示例
    function calculatePowerLowLevel(uint256 _base, uint256 _exponent) public view returns (uint256) {
        require(calculatorAddress != address(0), "Invalid calculator address");
        (bool success, bytes memory data) = calculatorAddress.staticcall(
            abi.encodeWithSignature("power(uint256,uint256)", _base, _exponent)
        );
        require(success, "Low-level call failed");
        uint256 result = abi.decode(data, (uint256));
        return result;  
    }
}