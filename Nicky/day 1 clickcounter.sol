// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ClickCounter{
    uint256 public counter;
    
function reset() public{
    counter=0;
}

function decrease() public{
    counter-=1;
}    

function clickMultiple(uint256 times) public{
    counter += times;

}


function click() public{
    counter+=2;
if (counter >= 50){
        reset();
    }
    if (counter >= 6){
        decrease();
    }
if (counter >=10){
    clickMultiple(5);

}
    }
}
