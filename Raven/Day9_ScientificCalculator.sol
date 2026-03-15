//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;
contract ScientificCalculator {
	function power(uint256 _base, uint256 _exp) public pure returns (uint256) {
		if (_exp == 0)
			return (1);
		return (_base ** _exp);
	}
	function squareRoot(int256 _number) public pure returns (int256) {
		require(_number >= 0, "Cannot calculate square root of negative numbers");
		if (_number == 0)
			return (0);
		int256 result = _number / 2;
		for (uint i = 0; i < 10; i++) {
			result = (result + _number / result) / 2;
		}
		return (result);
	}
}