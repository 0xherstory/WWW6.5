// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./day9_ScientificCalculator.sol";

contract Calculator {
    address public owner;
    address public scientificCalculatorAddress;
    
    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can perform this action");
        _;
    }

    function setScientificCalculator(address _address) public onlyOwner {
        scientificCalculatorAddress = _address;
    }


    function add(uint256 a, uint256 b) public pure returns (uint256) {
        return a + b;
    }

    function subtract(uint256 a, uint256 b) public pure returns (uint256) {
        require(a >= b, "Underflow: a must be greater than b");
        return a - b;
    }

    function multiply(uint256 a, uint256 b) public pure returns (uint256) {
        return a * b;
    }

    function divide(uint256 a, uint256 b) public pure returns (uint256) {
        require(b != 0, "Cannot divide by zero");
        return a / b;
    }

 
    function calculatePower(uint256 base, uint256 exponent) public view returns (uint256) {
        require(scientificCalculatorAddress != address(0), "Scientific address not set");
        ScientificCalculator scientificCalc = ScientificCalculator(scientificCalculatorAddress);
        return scientificCalc.power(base, exponent);
    }


    function calculateSquareRoot(uint256 number) public view returns (uint256) {
        require(scientificCalculatorAddress != address(0), "Scientific address not set");
        

        bytes memory data = abi.encodeWithSignature("squareRoot(uint256)", number);
        
        (bool success, bytes memory returnData) = scientificCalculatorAddress.staticcall(data);
        require(success, "External call failed");

        return abi.decode(returnData, (uint256));
    }
}