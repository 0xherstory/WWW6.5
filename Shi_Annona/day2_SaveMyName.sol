// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SaveMyName{

    string name;
    string job; 

    function add(string memory _name, string memory _job) public {
        name = _name;
        job = _job;
    }

    function retrieve() public view returns (string memory, string memory)
    {
        return(name,job);
    } 

//不建议这么写
    function AddAndRetrieve(string memory _name, string memory _job) public returns(string memory, string memory) {
        name = _name;
        job = _job;
        return(name,job);//它会执行，但是在用户界面没显示，执行了就消耗gas，所以不要这么写
    }
}
