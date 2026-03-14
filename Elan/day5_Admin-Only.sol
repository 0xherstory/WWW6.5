// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract AdminOnly {
    address public admin;
    uint256 public secretNumber;
constructor(){
    admin = msg.sender;
}
modifier onlyAdmin() {
    require(msg.sender == admin,"You are not the admin!");
    _;
}
function setSecretNumber(uint256 _newNumber)public onlyAdmin {
    secretNumber = _newNumber;
}
function getSecretNumber()public view returns (uint256) {
    return secretNumber;
}
}
