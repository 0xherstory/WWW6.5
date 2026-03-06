// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
contract Profile{
    string public name;
    string public bio;
    function add(string memory _myname, string memory _mybio)public {
       name = _myname;
       bio = _mybio;
    }
    function retrieve()public view returns (string memory, string memory) {
        return (name, bio);
    }
}
