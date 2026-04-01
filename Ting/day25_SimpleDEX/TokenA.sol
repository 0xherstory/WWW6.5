// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract TokenA is ERC20 {
    constructor () ERC20("Token A" ,"TKA"){
        _mint(msg.sender, 100 * 10 ** decimals()); // 铸造了100枚A代币给合约发起人
    }
}

// 0xD0269Ae1345BB9148bA77A92B7dA908A7efa3141