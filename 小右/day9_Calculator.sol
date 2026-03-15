// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// 确保文件名和路径正确
import "./day9 - ScientificCalculator.sol";

contract Calculator {
    address public owner;
    address public scientificCalculatorAddress;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can do it.");
        _;
    }

    function setScientificCalculator(address _address) public onlyOwner {
        require(_address != address(0), "Invalid address");
        scientificCalculatorAddress = _address;
    }

    function add(uint256 a, uint256 b) public pure returns (uint256) {
        return a + b;
    }

    function subtract(uint256 a, uint256 b) public pure returns (uint256) {
        return a - b;
    }

    function multiply(uint256 a, uint256 b) public pure returns (uint256) {
        return a * b;
    }

    function divide(uint256 a, uint256 b) public pure returns (uint256) {
        require(b != 0, "Cannot divide by zero");
        return a / b;
    }

    // 高级调用：通过接口/类定义调用
    function calculatePower(uint256 base, uint256 exponent) public view returns (uint256) {
        require(scientificCalculatorAddress != address(0), "Calculator address not set");
        ScientificCalculator scientificCalc = ScientificCalculator(scientificCalculatorAddress);
        return scientificCalc.power(base, exponent);
    }

    // 低级调用：使用 staticcall 调用 pure/view 函数
    function calculateSquareRoot(uint256 number) public view returns (uint256) {
        require(scientificCalculatorAddress != address(0), "Calculator address not set");

        // 修正点：将 int256 修改为 uint256，且去掉括号内的空格
        bytes memory data = abi.encodeWithSignature("squareRoot(uint256)", number);
        
        // 使用 staticcall 因为目标函数不修改状态
        (bool success, bytes memory returnData) = scientificCalculatorAddress.staticcall(data);
        
        require(success, "External call failed");

        // 解码响应
        return abi.decode(returnData, (uint256));
    }
}