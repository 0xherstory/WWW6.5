// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract FortKnox {
    mapping(address => uint256) public balances;
    uint256 private _status;
    uint256 private constant _NOT_ENTERED = 1;
    uint256 private constant _ENTERED = 2;

    constructor() {
        _status = _NOT_ENTERED;
    }

    modifier nonReentrant() {
        require(_status != _ENTERED, "Reentrant call blocked");
        _status = _ENTERED;
        _;
        _status = _NOT_ENTERED;
    }

    function deposit() external payable {
        balances[msg.sender] += msg.value;
    }

    function vulnerableWithdraw() external {
        uint256 bal = balances[msg.sender];
        (bool success, ) = msg.sender.call{value: bal}("");
        require(success, "Transfer failed");
        balances[msg.sender] = 0;
    }

    function safeWithdraw() external {
        uint256 bal = balances[msg.sender];
        balances[msg.sender] = 0;
        (bool success, ) = msg.sender.call{value: bal}("");
        require(success, "Transfer failed");
    }

    function protectedWithdraw() external nonReentrant {
        uint256 bal = balances[msg.sender];
        balances[msg.sender] = 0;
        (bool success, ) = msg.sender.call{value: bal}("");
        require(success, "Transfer failed");
    }

    function getContractBalance() external view returns (uint256) {
        return address(this).balance;
    }
}