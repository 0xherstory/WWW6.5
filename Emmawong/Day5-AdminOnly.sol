// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract AdminOnly{
    //声明变量
    address public owner;
    uint256 public treasureAmount;
    mapping (address=>uint256) public withdrawalAllowance;
    mapping (address=>bool) public hasWithdrawn;

    //设创建者当owner
    constructor(){
        owner = msg.sender;
        }
    
    //创建修饰符实现可复用的访问控制
    modifier onlyOwner(){
        require(msg.sender==owner, "Access denied:Only the owner can perform this action");
        _;
    }

    //只有拥有者可以添加宝藏
    function addTreasure(uint256 amount) public onlyOwner{
        treasureAmount +=amount;
    }

    //只有拥有者可以同意授权
    function approveWithdrawal(address recipient, uint256 amount)public onlyOwner{
        require(amount <=treasureAmount, "Not enough treasure available");
        withdrawalAllowance[recipient]= amount;
    }

    //任何人都可以尝试发起提款，但只有拥有【提取权限】的人才能成功拿到钱
    function withdrawTreasure(uint256 amount)public{

        if(msg.sender==owner){
            require(amount <=treasureAmount,"Not enough treasury available for this action.");
            treasureAmount -= amount;
            return;
        }
        uint allowance = withdrawalAllowance[msg.sender];//allowance额度
        
        //检查用户是否有额度，并且还没授权
        require(allowance>0,"You don't have any treasure allowance");
        require(!hasWithdrawn[msg.sender],"You have already withdrawn your treasure");
        require(allowance<=treasureAmount,"Not enough treasure in the chest");
        require(allowance>=amount,"You can't withdraw more than your allowance");
        
        //标记好已授权，减少宝藏
        hasWithdrawn[msg.sender]=true;
        treasureAmount -= allowance;
        withdrawalAllowance[msg.sender]=0;

    }

    //只有拥有者可以重置别人的授权状态
    function resetWithdrawalStatus(address user)public onlyOwner{
        hasWithdrawn[user]=false;
        
    }
    
    //只有老板可以转让给新老板
    function transferOwnership(address newOwner) public onlyOwner{
        require(newOwner!=address(0),"Invalid address");
        owner = newOwner;
    }
    
    function getTreasureDetails()public view onlyOwner returns(uint256){
        return treasureAmount;
    }


}