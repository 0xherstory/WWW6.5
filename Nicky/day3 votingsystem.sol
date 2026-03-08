// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract VotingSystem{
string[] public candidateNames;
mapping(string => uint256) voteCount;
mapping(address => bool) hasVoted;
mapping(string => bool) hasCandidate;

function addCandidateNames(string memory _candidateNames) public{
candidateNames.push(_candidateNames);
voteCount[_candidateNames]=0;
hasCandidate[_candidateNames]= true;
}

function getCandidateNames() public view returns(string[] memory){
    return candidateNames;
}

function vote(string memory _candidateNames) public{
    require(hasCandidate[_candidateNames],"candidate not exits");
   voteCount[_candidateNames ] +=1 ;
   require (!hasVoted[msg.sender], "Voted");
   hasVoted[msg.sender] =true;
}

function getVote(string memory _candidateNames) public view returns(uint256) {
    return voteCount[_candidateNames];
}

//function vote() public{
   // require (!hasVoted[msg.sender], "Voted");
   // hasVoted[msg.sender] =true;
//}

//function check() public view returns(bool){
    //return hasVoted[msg.sender];
//}
}