// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Ownable {

    // 存储当前合约所有者地址
    address private owner;

    // 当所有权转移时触发事件
    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    // 构造函数：部署合约时执行
    constructor() {
        // 将部署者设置为合约所有者
        owner = msg.sender;

        // 记录所有权初始化事件
        emit OwnershipTransferred(address(0), msg.sender);
    }

    // 修饰符：只允许 owner 调用函数
    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can perform this action");
        _;
    }

    // 查询当前 owner 地址
    function ownerAddress() public view returns (address) {
        return owner;
    }

    // 转移合约所有权
    function transferOwnership(address _newOwner) public onlyOwner {

        // 确保新地址不是空地址
        require(_newOwner != address(0), "Invalid address");

        // 保存旧 owner
        address previous = owner;

        // 更新 owner
        owner = _newOwner;

        // 触发事件
        emit OwnershipTransferred(previous, _newOwner);
    }
}
