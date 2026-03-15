//SPDX-License-Identifier:MIT
pragma solidity ^0.8.0;

contract Ownable{
    address private owner;
    event ownershipTransferred(address indexed previousOwner, address indexed newOwner);

    constructor(){
        owner = msg.sender;
        emit ownershipTransferred(address(0), msg.sender);
    }

    modifier onlyOwner(){
        require(msg.sender == owner, "Only owner can perform this action");
        _;
    }

    function checkOwner() public view returns(address){
        return owner;
    }

    function transferOwner(address _newOwner) public onlyOwner{
        require(_newOwner!=address(0),"Invalide address");
        address previousOwner = owner;
        owner = _newOwner;
        emit ownershipTransferred(previousOwner, _newOwner);
    }
}