//SPDX-License-Identifier:MIT
pragma solidity ^0.8.0;

contract SaveMyName{
    string name;
    string bio;

    function add(string memory _name,string memory _bio)public{
        name=_name;
        bio=_bio;

    }
    function retrive()public view returns(string memory,string memory){
        return(name,bio);
    }
    function addAndRetrive(string memory _name,string memory _bio)
        public returns(string memory,string memory){
        name=_name;
        bio=_bio;
        return(name,bio);
    }
    function getName()public view returns(string memory){
        return name;
    }
    function getBio()public view returns(string memory){
        return bio;
    }
    function updateName(string memory _newname)public{
        name=_newname;
    }

    uint256 age;
    function addAgeAndReturns(uint256 _age)public returns(uint256){
        age=_age;
        return age;
    }

}