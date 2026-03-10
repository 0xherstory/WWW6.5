// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


import "./ScientificCalculator.sol";

contract Calculator{
    address public owner;
    address public scientificCalculatorAddress;

    constructor (){
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Not the owner");
        _;}

    function setscientificCalculator(address _address) public onlyOwner{
        scientificCalculatorAddress= _address;

    }

    function power(uint256 base , uint256 exponent) public view returns(uint256){
        require(scientificCalculatorAddress != address(0),"calculator not set");
    ScientificCalculator scientificCalc = ScientificCalculator(scientificCalculatorAddress);
        return scientificCalc.power(base, exponent);
    }
   

}




