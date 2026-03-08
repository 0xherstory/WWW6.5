// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract EtherPiggyBank {
    address public owner; 
    constructor() {
        owner = msg.sender;
    }
    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can withdraw!");
        _;
    } 
    function deposit() public payable {   
    }
    function withdraw() public onlyOwner {
        uint256 balance = address(this).balance;
        require(balance > 0, "Piggy bank is empty!");      
        payable(owner).transfer(balance);
    }
     function getBalance() public view returns (uint256) {
        return address(this).balance;
    }
}