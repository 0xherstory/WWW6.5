// SPDX-License-identifier:MIT

pragma solidity ^0.8.0;

contract ClickCounter {
    unit256 public count;

    function click(0) public {
        count = count + 1;
    }

    function reset(0) public{
        count = 0;
    }

    function decrease() public{
        count = count - 1;
    }

    function getcounter() public view returns(uint256){
        return count;
    }

    function clickMultiple(uint256 times) public{
        count = count + times;
    }
}