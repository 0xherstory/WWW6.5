//SPDX-License-Identifier:MIT
pragma solidity ^0.8.0;

contract OwnedClickCounter{

    //储存点击次数
    uint256 public counter;

    //储存主人地址
    address public owner;

    //构造函数：部署合约时，自动把部署的人设为主人
    constructor(){
        owner=msg.sender;
    }

    //权限修饰符：只有主人能调用
    modifier onlyOwner(){
        require(msg.sender==owner,"Caller is not owner");
        _;
    }

    //基础功能：任何人都可以点击+1
    function click()public{
        counter=counter+1;
    }


    //作业1::只有主人能重置归零
    function reset()public onlyOwner{
        counter=0;
    }

    //作业2：只有主人能减少数字
    function decrease()public onlyOwner{
        if(counter>0){
            counter=counter-1;
        }
    }

    //作业3：查看当前计数（所有人都能看）
    function getCounter()public view returns(uint256){
        return counter;
    }



}