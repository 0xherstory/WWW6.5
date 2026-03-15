// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract PollStation{

  string[] public CandidateNames;
  mapping(string => uint256) VoteCount;

  function addcandidatenames (string memory _CandidateNames) public{
    CandidateNames.push(_CandidateNames);
    VoteCount[_CandidateNames] = 0;
  }

  function getcandidatenames() public view returns (string[] memory){
    return CandidateNames;
  }

  function vote(string memory _CandidateNames) public {
    VoteCount[_CandidateNames] += 1;
  }

  function getvote (string memory _CandidateNames) public view returns (uint256) {
    return  VoteCount[_CandidateNames];
    }
}
