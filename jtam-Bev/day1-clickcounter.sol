// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ClickCounter {
    // 状态变量 - 存储点击次数
    uint256 public counter;//状态变量1
    uint256 public totalReset;//每个变量都得有一个定义*不然会报错


    // 函数 - 增加计数器
    function click() public {
        counter++;
    }
    //重置功能
    function reset() public  {
        counter = 0; //更新变量1 重置
        totalReset++; //更新变量。可见重置次数
    }
    //减少-1 
    function decrease () public {
        //只有在counter大于0的时候才执行
        // 减少-1
    
        require(counter > 0, "Counter already at zero");
        counter--;
        
    }
    //获取当前值， 让大家看到
    function getCounter()public view 
    returns (uint256) { 
        return counter;
    }
    //一次增加多次
    function clickMultiple(uint256 times)
    public {
        counter=counter +times;
    }
}
