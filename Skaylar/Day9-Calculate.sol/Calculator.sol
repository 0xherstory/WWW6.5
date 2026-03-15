//SPDX-License-Identifier: MIT 

pragma solidity ^0.8.0; 

//引入外部合约
import "./ScientificCalculator.sol";

contract Calculator{
    address public owner;
    address public SCaddress;//计算器地址

    constructor () {
        owner = msg.sender;
    }
    modifier onlyOwner(){
        require(msg.sender == owner, "Only owner can do this action.");
        _;
    }

    //设置专属地址
    function onlyAddress(address _address) public onlyOwner{
        SCaddress = _address;
    }

    //基础运算，加减乘除
    function add(uint256 a, uint256 b) public pure returns(uint256) {
        return a + b;
    }

    function substract(uint256 a,uint256 b) public pure  returns(uint256) {
        return a - b;
    }
    function multiple(uint256 a,uint256 b) public pure  returns(uint256) {
        return a * b;
    }
    function divide(uint256 a,uint256 b) public pure  returns(uint256) {
        require( b != 0 ,"Cannot divide by zero");
        return a / b;
    }

    //高级运算
    function calculatorPower(uint256 a,uint256 b) public view returns(uint256){
        ScientificCalculator c = ScientificCalculator(SCaddress) ;
        uint256 result = c.power(a , b);
        return result;
    }

    function calculatorSequreRoot(uint256 a) public  returns(uint256){
        require(a >=0, "Cannot calculate square root of negative number");

        bytes memory data = abi.encodeWithSignature("squareRoot(int256)", a);
        (bool success, bytes memory returnData) = SCaddress.call(data);
        require(success,  "External call failed") ;
        uint256 result = abi.decode(returnData, (uint256));
        return result;
    }
}

