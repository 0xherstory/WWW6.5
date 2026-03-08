//SPDX-License-Identifier:MIT

pragma solidity ^0.8.0;

contract AdminOnly {

    uint public treasureAmount; //宝藏数额
    mapping(address => uint) public approvalAmount; //批准数额
    mapping(address => bool) public hasWithdrawn; //用户是否已提取过
    //部署合约者被指定为管理者
    address public owner;
    constructor() {
        owner = msg.sender;
    }

    //使用修饰符生成逻辑预处理函数
    modifier onlyOwner() {
        require(owner == msg.sender, "Access denied: Only the owner can perform this action"); //判断条件
        _; //执行被修饰的函数主体
    }

    //管理员添加宝藏数额 
    function addTreasure(uint amount) public onlyOwner {
        treasureAmount += amount;
    }

    //管理员查看宝藏数额
    function getTreasureDetails() public view onlyOwner returns(uint) { //修改器位于函数名参数之后，且在返回参数returns之前
        return treasureAmount;
    }

    //管理员授权用户取宝藏，并设置数额
    function approveWithdrawal(address user, uint amount) public onlyOwner {
        //需要宝藏数额大于等于输入数额
        require(amount <= treasureAmount, "Not enough treasure available.");
        approvalAmount[user] = amount;
    }

    //管理员转让身份
    function transferOwnership(address newOwner) public onlyOwner {
        require(newOwner != address(0), "Invalid address"); //在以太坊中，address(0)是一个黑洞地址，放进去的东西相当于销毁
        owner = newOwner;
    }
    
    //取宝藏（管理员不限，用户只能取一次）
    function withdrawTreasure(uint amount) public {

        //检测是否为管理员
        if(msg.sender == owner){
            //需要宝藏数额大于等于输入数额
            require(amount <= treasureAmount, "Not enough treasure available.");
            treasureAmount -= amount;
            return; //！执行到这里直接跳出函数。这里也可以用if...else语句，但是用return符合智能合约中“卫语句”（Guard Clauses）的设计模式，常用的require也是使用了这一模式。但如果管理员和普通用户有共同的收尾逻辑，就得用if...else
        }
        //普通用户逻辑如下
        uint allowance = approvalAmount[msg.sender];
        //需要被授权
        require(allowance > 0, "You don't have any treasure allowance.");
        //需要提取数额小于等于批准数额
        require(amount <= allowance, "Cannot withdraw more than you are allowed.");
        //需要还未取过宝藏
        require(!hasWithdrawn[msg.sender], "You have already withdrawn your treasure.");
        //需要提取数额小于等于宝藏数额
        require(amount <= treasureAmount, "Not enough treasure in the chest.");
        
        //满足以上条件用户即可提取
        hasWithdrawn[msg.sender] = true; //先修改状态再转账比较安全
        treasureAmount -= amount;
        approvalAmount[msg.sender] = 0;

    }
    
    //管理员重置用户取宝藏状态
    function resetWithdrawalStatus(address user) public onlyOwner{
        hasWithdrawn[user] = false;
    }
   
}