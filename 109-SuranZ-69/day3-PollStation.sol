// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract PollStation{
    // 声明候选人列表（数组）和投票跟踪（映射）
    string[] public candidateNames;
    mapping (string => uint256) voteCount;

    // addCandidateNames()函数 - 添加候选人，初始票数为0
    function addCandidateNames (string memory _candidateNames) public {
        candidateNames.push (_candidateNames);
        voteCount [_candidateNames] = 0;
    }

    // getCandidateNames()函数 - 检索候选人列表
    function getCandidateNames () public view returns (string[] memory) {
        return candidateNames;
    }

    // vote()函数 - 为候选人投票
    function vote (string memory _candidateNames) public {
        voteCount [_candidateNames] += 1;
    }

    //getVote()函数 - 检查候选人的票数
    function getVote (string memory _candidateNames) public view returns (uint256) {
        return voteCount [_candidateNames];
    }
}