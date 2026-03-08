//SPDX-License-Identifier:MIT
pragma solidity ^0.8.0;

contract ClickCounter{

    unit256 public counter;

    function Click() public{
        counter ++;
    }

    function Reset() public{
        counter = 0;
    }
}
