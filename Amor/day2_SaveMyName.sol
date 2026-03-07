// SPDX-License-Identifier:MIT

pragma solidity ^0.8.0;

contract SaveMyName{
    string name;
    string bio;

    function add(string memory_name, string memory_bio) public{
        name = name_;
        bio = bio_;
    }

    function retrieve() public view returns(string memory, string memory){
        return (name, bio);
    }
}
