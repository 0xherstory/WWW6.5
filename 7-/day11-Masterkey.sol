// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MasterKey {
    address public owner;
    bytes32 public masterKeyHash;

    constructor(bytes32 _masterKeyHash) {
        owner = msg.sender;
        masterKeyHash = _masterKeyHash;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Not owner");
        _;
    }

    function changeOwner(string calldata key) external {
        require(keccak256(abi.encodePacked(key)) == masterKeyHash, "Wrong key");
        owner = msg.sender;
    }

    function updateKeyHash(bytes32 newHash) external onlyOwner {
        masterKeyHash = newHash;
    }
}