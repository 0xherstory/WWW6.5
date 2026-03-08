// SPDX-License-Identifier:MIT
pragma solidity ^0.8.0;
contract ClickCounter {
    //合约内容在这里
    //状态变量-存储点击次数
    uint256 public counter;
    
    //函数-增加计数器
    function click() public {
        counter++;
    }
    function reset() public{
        counter =0;
    }
    function decrease() public{
        require(counter > 0,"counter cannot be less than zero!");
        counter--;
    }
    function getCounter() public
    view returns (uint256){
        return counter;
    }
function clickMultiple(uint256 times) public{
    counter += times;
}
}
