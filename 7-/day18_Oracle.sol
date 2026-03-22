// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Oracle {
    address public owner;
    uint256 public price;

    event PriceUpdated(uint256 newPrice);

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Not owner");
        _;
    }

    // 预言机管理员写入数据（模拟从外部获取）
    function setPrice(uint256 _price) external onlyOwner {
        price = _price;
        emit PriceUpdated(_price);
    }

    // 普通合约读取数据
    function getPrice() external view returns (uint256) {
        return price;
    }
}