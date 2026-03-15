// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract AdminOnly {
    // State variables
    address public owner;
    uint256 public treasureAmount;
    mapping(address => uint256) public withdrawalAllowance;
    mapping(address => bool) public hasWithdrawn;

    //Constructor sets the contract creator as the owner
    constructor() {
        owner = msg.sender;
    }

    //Modifier to restrict access to only the owner
    modifier onlyOwner() {
        require(msg.sender == owner, "Access denied: Only the owner can perform this action.");
        _;
    }

    //Function to add to the treasure amount, only callable by the owner{
    function addTreasure(uint256 _amount) public onlyOwner {
        treasureAmount += _amount;
    }

    //Funcition to approve withdrawals, only callable by the owner
    function approveWithdrawal(address _user, uint256 _amount) public onlyOwner {
        require(_amount <= treasureAmount, "Not enough treasure available");
        withdrawalAllowance[_user] = _amount;
    }

    //Function for users to withdraw their approved amount
    function withdrawTreasure(uint256 amount) public {
       if(msg.sender == owner){
           require(amount <= treasureAmount, "Not enough treasure available");
           treasureAmount -= amount;
           
           return;

       }
       uint256 allowance = withdrawalAllowance[msg.sender];
    

        //check if the user has already withdrawn
        require(allowance > 0,  "You don't have any treasure allowance");
        require(!hasWithdrawn[msg.sender], "You have already withdrawn your allowance");
        require(allowance >= treasureAmount, "Not enough treasure available");
        require(allowance >= amount, "Cannot withdraw more than you are allowed");

        //mark the user as having withdrawn and reduce the treasure amount
        hasWithdrawn[msg.sender] = true;
        treasureAmount -= amount;
        withdrawalAllowance[msg.sender] = 0;
    }

    //reset only callable by the owner
    function resetWithdrawals(address _user) public onlyOwner {
    hasWithdrawn[_user] = false;
    }

    //transfer ownship, only callable by the owner
    function transferOwnership(address newOwner) public onlyOwner {
        require(newOwner != address(0), "Invalid address");
        owner = newOwner;
    }
    //get the treasure details, only callable by the owner
     function getTreasureDetails() public view onlyOwner returns (uint256) {
        return treasureAmount;
    }
}