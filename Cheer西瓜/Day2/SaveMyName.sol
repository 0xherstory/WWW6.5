// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SaveMyName {
    string private name;

    function setName(string memory newName) external {
        name = newName;
    }

    function getName() external view returns (string memory) {
        return name;
    }
}
