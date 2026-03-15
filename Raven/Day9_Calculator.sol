//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

// Include other .sol to use external functions
import "./Day9_ScientificCalculator.sol";

contract Calculator {
	address public owner;
	address public scientificAddress;

	constructor() {
		owner = msg.sender;
	}

	modifier onlyOwner() {
		require(msg.sender == owner, "Only owner has access to operate");
		_;
	}
	function setScientificCalculator(address _address) public onlyOwner {
		scientificAddress = _address;
	}
	// Pure: not read or change state variables
	function add(uint256 _a, uint256 _b) public pure returns (uint256) {
		return (_a + _b);
	}
	function subtract(uint256 _a, uint256 _b) public pure returns (uint256) {
		return (_a - _b);
	}
	function multiply(uint256 _a, uint256 _b) public pure returns (uint256) {
		return (_a * _b);
	}
	function divide(uint256 _a, uint256 _b) public pure returns (uint256) {
		require(_b != 0, "Cannot devide by 0");
		return (_a / _b);
	}
	// High level using external functions -- construct a class using address
	// Read external address but not change - view
	function calculatePower(uint256 _base, uint _exp) public view returns (uint256) {
		ScientificCalculator scientificCalc = ScientificCalculator(scientificAddress);
		return (scientificCalc.power(_base, _exp));
	}
	// Low level using external functions -- call function
	// check input - encoding data with function signature - call function - check status -  decoding return data
	// call not gurantee read-only -- no view
	function calculateRoot(uint256 _number) public returns (uint256) {
		require(_number >= 0, "Cannot calculate square root of negative numbers");
		bytes memory data = abi.encodeWithSignature("squareRoot(int256)", _number);
		(bool success, bytes memory returnData) = scientificAddress.call(data);
		require(success, "External call failed");
		uint256 result = abi.decode(returnData, (uint256));
		return (result);
	}
}