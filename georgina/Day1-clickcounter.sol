// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract PiggyBank {
uint public balance = 0;
function deposit(uint amount) public {
balance = balance + amount; 
}
function withdraw(uint amount) public {
require(balance >= amount, "Balance is not enough!");

balance = balance - amount; 
}
}
