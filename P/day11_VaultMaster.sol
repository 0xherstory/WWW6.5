// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;


contract Ownable {
    address public owner;

    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    constructor() {

        owner = msg.sender;
    }


    modifier onlyOwner() {
        require(msg.sender == owner, "Ownable: caller is not the owner");
        _;
    }


    function transferOwnership(address newOwner) public onlyOwner {
        require(newOwner != address(0), "Ownable: new owner is the zero address");
        emit OwnershipTransferred(owner, newOwner);
        owner = newOwner;
    }
}


contract VaultMaster is Ownable {
    event Deposit(address indexed sender, uint256 amount);
    event Withdraw(uint256 amount);

 
    receive() external payable {
        emit Deposit(msg.sender, msg.value);
    }


    function deposit() public payable {
        require(msg.value > 0, "Amount must be greater than 0");
        emit Deposit(msg.sender, msg.value);
    }


    function withdrawAll() public onlyOwner {
        uint256 amount = address(this).balance;
        require(amount > 0, "Vault is empty");


        (bool success, ) = payable(owner).call{value: amount}("");
        

        require(success, "Transfer failed.");

        emit Withdraw(amount);
    }


    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }
}