// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SaveMyName{
    string name;
    string bio;

    function add(string memory arg_name,string memory arg_bio) public{
        name = arg_name;
        bio = arg_bio;
    }

    function retrieve() public view returns(string memory,string memory){
        return(name,bio);
    }
}