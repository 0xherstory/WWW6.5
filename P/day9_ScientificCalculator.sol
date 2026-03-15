// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ScientificCalculator {
    
    function power(uint256 base, uint256 exponent) public pure returns (uint256) {
        if (exponent == 0) return 1;
        return (base ** exponent);
    }

    function squareRoot(uint256 number) public pure returns (uint256) {
        if (number == 0) return 0;
        if (number <= 3) return 1;

        uint256 result = number;
        uint256 x = number / 2 + 1;
        
        for (uint256 i = 0; i < 10; i++) {
            if (x < result) {
                result = x;
                x = (number / x + x) / 2;
            } else {
                break;
            }
        }
        return result;
    }
}