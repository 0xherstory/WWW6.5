// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0; 

contract SaveMyName {

    string name;
    string bio;
    string age;

    function add(string memory _name, string memory _bio, string memory _age) public {
        name = _name;
        bio = _bio;
        age = _age;
 
    }

    function retreive() public view returns(string memory,string memory,string memory){
        return (name,bio,age); //read only
    }

    function saveAndRetrive(string memory _name,string memory _bio,string memory _age) public returns(string memory,string memory,string memory){
        name = _name;
        bio = _bio;
        age = _age;
        return(name,bio,age);
    }

    function getName() public view returns(string memory){
        return (name);
    }

    function updateName(string memory _newName) public{
        name = _newName;
    }

}


