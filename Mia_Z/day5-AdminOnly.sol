//SPDX-License-Identifier:MIT
pragma solidity ^0.8.0;


contract AdminOnly{

    address  public owner;

    constructor(){
        owner = msg.sender;
    }

    modifier onlyOwner(){
        require(msg.sender == owner,"Access denied: Only the owner can perform this action");
        /**
        这个好抽象？ */
        _;
    }

    uint256 public treasureAmount;

/**
居然还有特别修饰 仅owner能调用？ */
    function addTreasure(uint256 amount) public onlyOwner {
        treasureAmount += amount;
    }

    mapping(address =>uint256) public withdrawalAllowance;

    function approveWithdrawal(address recipient, uint256 amount) public onlyOwner {
        /**
        反向的映射吗？键值？ */
        require(amount <= treasureAmount, "Not enough treasure available");
        withdrawalAllowance[recipient] = amount;
    }

    mapping(address => bool)public hasWithdrawn;

    //owner
    function withdrawTreasure(uint256 amount) public {
        
        if (msg.sender == owner){
            require(amount <= treasureAmount, "Not enough treasure available");
            treasureAmount -= amount;
            return;
        }
        //user
        uint256 allowance = withdrawalAllowance[msg.sender];
        require(allowance > 0, "No withdrawal allowance");
        require(!hasWithdrawn[msg.sender], "Already withdrawn");
        require(allowance <= treasureAmount, "Not enough treasure available");


        hasWithdrawn[msg.sender] = true;
        treasureAmount -= allowance;
        withdrawalAllowance[msg.sender] = 0;
    }

    function resetWithdrawalStatus(address user) public onlyOwner {
        hasWithdrawn[user] = false;
    }

    /**
    转移合约拥有权 */

    function transferOwnership(address newOwner) public onlyOwner {
        require(newOwner != address(0), "Invalid new owner");
        owner = newOwner;
    }

    /**
    查看宝箱信息 */

    function getTreasureDetails()public view onlyOwner returns (uint256) {
        return treasureAmount;
    }


}