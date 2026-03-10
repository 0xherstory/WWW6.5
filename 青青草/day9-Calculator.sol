// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./day9-ScientificCalculator.sol";
//使用一个 import 语句将 ScientificCalculator.sol 中的代码引入到这个文件中。这允许 Calculator 合约使用那个其他合约中的函数。

contract Calculator{
    address public owner;
    address public scientificCalculatorAddress;//存放已经部署的科学计算器地址的地方
    constructor(){
        owner = msg.sender;
    }

    modifier onlyOwner(){
        require(msg.sender == owner, "Only owner can do this action");
         _; 
    }

    function setScientificCalculator(address _address)public onlyOwner{
        scientificCalculatorAddress = _address;
        }

    function add(uint256 a, uint256 b)public pure returns(uint256){
        uint256 result = a+b;
        return result;
    }

    function subtract(uint256 a, uint256 b)public pure returns(uint256){
        uint256 result = a-b;
        return result;
    }

    function multiply(uint256 a, uint256 b)public pure returns(uint256){
        uint256 result = a*b;
        return result;
    }

    function divide(uint256 a, uint256 b)public pure returns(uint256){
        require(b!= 0, "Cannot divide by zero");
        uint256 result = a/b;
        return result;
    }

    function calculatePower(uint256 base, uint256 exponent)public view returns(uint256){

    ScientificCalculator scientificCalc = ScientificCalculator(scientificCalculatorAddress);
    uint256 result = scientificCalc.power(base, exponent);

    return result;
    }


 //低级调用
    function calculateSquareRoot(uint256 number)public returns (uint256){
        require(number >= 0 , "Cannot calculate square root of negative nmber");

        bytes memory data = abi.encodeWithSignature("squareRoot(int256)", number);
        (bool success, bytes memory returnData) = scientificCalculatorAddress.call(data);
        require(success, "External call failed");
        uint256 result = abi.decode(returnData, (uint256));
        return result;
    }

}