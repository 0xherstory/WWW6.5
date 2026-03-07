// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract CandidateName {
    string[] public candidateNames;
    mapping(string => uint256) public voteCount;

    // 添加候选人名字
    function addCandidateName(string memory _candidateName) public {
        require(bytes(_candidateName).length != 0, "Empty candidate name");
        candidateNames.push(_candidateName);
    }

    // 获取所有候选人列表
    function getCandidateNames() public view returns (string[] memory) {
        return candidateNames;
    }

    // 为指定候选人投票
    function vote(string memory _candidateName) public {
        require(bytes(_candidateName).length != 0, "Empty candidate name");
        voteCount[_candidateName] += 1;
    }

    // 查询某个候选人的得票数
    function getVoteCount(string memory _candidateName) public view returns (uint256) {
        return voteCount[_candidateName];
    }
}