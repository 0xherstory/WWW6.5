// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract EtherPiggyBank {
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    receive() external payable {}

    function deposit() external payable {}

    function getBalance() external view returns (uint256) {
        return address(this).balance;
    }

    function withdraw(address payable to, uint256 amount) external {
        require(msg.sender == owner, "Not owner");
        require(amount <= address(this).balance, "Insufficient balance");
        (bool ok, ) = to.call{value: amount}("");
        require(ok, "Withdraw failed");
    }
}
