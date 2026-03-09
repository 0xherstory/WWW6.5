// SPDX-License-Identifier:MIT

pragma solidity ^0.8.0;

contract ClickCounter {

    uint256 public counter;
    function click() public {
        counter++;
     
}
function clickMultiple(uint256  times) public {
    for (uint256 i=0; i< times; i++){
        counter++;
    }
}
}
