// SPDX-License-Identifier:MIT
pragma solidity ^0.8.0;
contract votecount {
    string[] public candidateNames;
    mapping(string => uint256) voteCount;
    mapping(address => bool) public hasVoted;
    function addCandidateNames(string memory _candidateNames) public {
    candidateNames.push(_candidateNames);
    voteCount[_candidateNames] = 0;
    }
    function getcandidateNames() public view returns (string[] memory){
        return candidateNames;
    }
    function vote(string memory _candidateNames)public{
       require(hasVoted[msg.sender] ==false,"You have already voted!");
       voteCount[_candidateNames] +=1; 
       hasVoted[msg.sender]=true;
    }
    function getVote(string memory _candidateNames) public view returns (uint256){
        return voteCount[_candidateNames];
    }
}
