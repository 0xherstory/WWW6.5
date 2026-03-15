//SPDX-License-Identifier:Mit

pragma solidity ^0.8.0;
 
contract ScientificCalculator{
//幂运算
function power(uint256 a,uint256 b) public pure returns(uint256){
    if(b ==0)
        return 1;
        else return ( a ** b);
    }

//平方根运算

function squareRoot(int256 a) public pure returns(int256){
    require(a >=0,"Cannot calculate square root of negative number");
    if(a == 0)
        return 0;

        int256 result = a / 2;
        for (uint256 i = 0; i <10;i++){
            result =(result +a / result) / 2;
        }
        return result;
}

}