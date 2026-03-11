// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract PollStation {
    //定义候选人结构体，存姓名+票数
    struct Candidate {
        string name;
        uint256 votes;
    }

    //核心映射/数组，数据存储
    mapping(string => Candidate) public candidateInfo; //姓名-候选人信息
    mapping(address => bool) public hasVoted;          //地址-防止重复投
    string[] public candidateList;

    //添加候选人
    function addCandidate(string memory _name) public {
        //检查候选人不能重复添加
        if (candidateInfo[_name].votes != 0) {
            revert("Candidate already exists!");
        }

        candidateInfo[_name] = Candidate(_name, 0);

        candidateList.push(_name);
    }

    //投票
    function vote(string memory _name) public {
        //检查投票人是否投过
        require(!hasVoted[msg.sender], "You have already voted");
        //检查候选人是否存在
        require(bytes(candidateInfo[_name].name).length != 0, "Candidate does not exist!");

        candidateInfo[_name].votes += 1;
        hasVoted[msg.sender] = true;
    }

    //查单个候选人票数
    function getCandidateVotes(string memory _name) public view returns (uint256) {
        return candidateInfo[_name].votes;
    }

    //查所有候选人票数
    function getAllCandidates() public view returns (string[] memory, uint256[] memory) {
        uint256 length = candidateList.length;
        uint256[] memory votesList = new uint256[](length);
    
        //挨个点名查票数
        for (uint256 i = 0; i < length; i++) {
            votesList[i] = candidateInfo[candidateList[i]].votes;
        }

        return (candidateList, votesList);
    }
}