// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract AdminOnly {
    //以下为状态变量，永久保存在区块链上
    address public owner;
    uint256 public treasureAmount;
    mapping(address => uint256) public withdrawalAllowance;// 每个人能提多少
    mapping(address => bool) public hasWithdrawn;// 是否已经提过款

    //创建合约的人就是管理员
    constructor() {                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              
        owner = msg.sender ;
    }

    //添加一个修饰符，每次检查调用者是否为管理员只需要在函数上添加上“onlyOwner”就行
    modifier onlyOwner(){
        require(msg.sender == owner, "Access denied: Only the owner can perform this action");
        _;//如果是管理员就执行操作
    }

    //定义函数格式：function 函数名(参数) 可见性 修饰符 其他关键字
    //只有管理员可以加钱
    function addTreasure(uint256 amount)public onlyOwner {
        treasureAmount += amount;
    }

    function approveWithdrawal(address recipient, uint256 amount)public onlyOwner {
        require(amount <= treasureAmount,"Not enough treasure available");
        withdrawalAllowance[recipient] = amount;
    }

    //执行取钱
    function withdrawTreasure(uint256 amount) public {

        //之前的onlyOwner执行后，如果不是检测到管理员会报错，现在若不是管理员，则直接跳过这段代码
        if(msg.sender == owner){
            require(amount <=treasureAmount,"Not enough treasury availeable for this action.");
            treasureAmount -= amount;

            return;
        }

        uint256 allowance = withdrawalAllowance[msg.sender];

        require(allowance > 0,"You don't have any treasure allowance");
        require(!hasWithdrawn[msg.sender],"You have already withdrawn your treasure");
        require(allowance <= treasureAmount,"Not enough in the chest");
        require(allowance >= amount, "Cannot withdraw more than you are allowed");

        hasWithdrawn[msg.sender] = true;
        treasureAmount -= allowance;
        withdrawalAllowance[msg.sender] = 0;
    }

    function resetWithdrawalStatus(address user)public onlyOwner {
        hasWithdrawn[user] = false;
    }

    function transferOwnership(address newOwner) public onlyOwner {
        require(newOwner != address(0),"Invadlid address");//!=是不等于的意思
        owner = newOwner;
    }

    function getTreasureDetails() public view onlyOwner returns (uint256) {
    return treasureAmount;
    }
}