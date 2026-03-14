// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SaveMyName {
    string name;
    string bio;
    uint public age; 

    function add(string memory _name, string memory _bio) public {
        name = _name;
        bio = _bio;
    }

    function retrieve() public view returns (string memory, string memory) {
        return (name, bio);
    }

    function getName() public view returns (string memory) {
        return name;
    }

    function getBio() public view returns (string memory) {
        return bio;
    }

    function updateName(string memory _newName) public {
        name = _newName;
    }

    function setAge(uint _age) public {
        age = _age;
    }

    function saveAndRetrieve(string memory _name, string memory _bio) 
        public returns (string memory, string memory) {
        name = _name;
        bio = _bio;
        return (name, bio);
    }
}