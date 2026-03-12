//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;
//加入scientificCalculator的代码
import "./ScientificCalculator.sol";

contract Calculator{
//记录 ScientificCalculator 合约的地址，所有人都能看到
    address public owner;
    address public ScientificCalculatorAddress;
//msg.sender部署这个合约的人，owner = msg.sender 把部署者设为所有者
    constructor(){
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can do this action");
        _;
    }

    function setScientificCalculator(address _address)public onlyOwner{
        scientificCalculatorAddress = _address;
    }

    function add(uint256 a, uint256 b) public pure returns(uint256){
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
        require(b!= 0,"Cannot divide by zero");
        uint256 result = a/b;
        return result;
    }
// base是底数，exponent是指数
    function calculatepower(uint256 base, uint256 exponent)public view returns(uint256){

    ScientificCalculator scientificCalc =ScientificCalculator(scientificCalculatorAddress);

    //external call
    uint256 result = scientificCalc.power(base, exponent);

    return result;

    }

    function calculateSquareRoot(uint256 number)public returns (uint256){
        require(number >= 0, "Cannot calculate square root of negative number");

        bytes memory date = abi.encodeWithSignature("squareRoot(uint256)", number);
        (bool success, bytes memory returnData) = scientificCalculatorAddress.call(data);
        uint256 result = abi.decode(returnData, (uint256));
        return result;
    }


}