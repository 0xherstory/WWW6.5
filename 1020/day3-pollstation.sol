// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
contract PollStation{
    string[] public candidateNames;
    mapping(string=>uint256) voteCount;

    function addCandidatenames(string memory _candidatenames) public{
        candidateNames.push(_candidatenames);
        voteCount[_candidatenames]=0;
    }
    function getCandidatenames() public view returns (string[] memory){
        return candidateNames;
    }
    function vote(string memory _Candidatenames) public{
        voteCount[_Candidatenames]+=1;
    }
    //uint256 是值类型（大小固定且直接传递副本），而 string 等引用类型需要明确声明内存位置。
    function getvote(string memory _candidatenames) public view returns(uint256){
        return voteCount[_candidatenames];
    }
}

