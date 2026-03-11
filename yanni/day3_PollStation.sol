// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract PollStation{
    string[] public candidateNames;
    mapping(string => uint256) public voteCount;

    function addCandidateNames(string memory _name) public {
        candidateNames.push(_name);
        voteCount[_name] = 0;
    }
    function getCandidateNames() public view returns(string[] memory){
        return candidateNames;
    }

    function vote(string memory _name) public {
        voteCount[_name]++;
    }

    function getVotes(string memory _name) public view returns(uint256){
        return voteCount[_name];
    }
}