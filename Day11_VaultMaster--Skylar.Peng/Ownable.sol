 //SPDX-License-Identifier :MIT

pragma solidity ^0.8.20;

contract Ownable{

    address private owner;

    event OwnershipTransferred(
        address indexed oldOwner,
        address indexed newOwner
    );

    constructor(){
        owner = msg.sender;
        emit OwnershipTransferred(address(0), msg.sender);
    }

    modifier onlyOwner(){
       require( owner == msg.sender,"Only owner can perform this action");
       _;}

    function transferOwnership(address _newOwner) public onlyOwner {
        require(_newOwner != address(0),"Invalid address");
        address old = owner;
        owner = _newOwner;
        emit OwnershipTransferred(old, _newOwner);
    
    }
}