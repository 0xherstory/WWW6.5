// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract TokenB is ERC20{
    constructor() ERC20("Token B", "TKB"){
        _mint(msg.sender, 100 * 10 ** decimals()); // 铸造100枚B代币给合约发起人
    }
}

// 0x855659FE49EF3036Af43bb348C5D7B2566270373