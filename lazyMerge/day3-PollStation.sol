// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract PollStation {
    string[] private candidateNames; // 候选人
    mapping(string => uint256) private  voteCount; // 候选人 => 投票数
    mapping(address => bool)  private hasVoted; // 地址是否投票过
    mapping(string => bool) private candidateExists; // 是否存在候选人

    // 初始化
    function add(string memory _name) public {
         // 判断是否存在候选人 存在的时候返回报错
        require(!candidateExists[_name], "Candidate already exists");
        candidateNames.push(_name);
        voteCount[_name] = 0;
        candidateExists[_name] = true; // 标记存在
    }

    // 添加投票
    function vote(string memory _name) public {
        require(candidateExists[_name], "Candidate does not exist");
        require(!hasVoted[msg.sender], "You have already voted");
        voteCount[_name] += 1;
        hasVoted[msg.sender] = true;
    }

    // 获取候选人的名字
    function getAllCandidateNames() public view returns(string[] memory) {
        return candidateNames;
    }

    // 通过名字查找投票数
    function getCandidateInfoByName(string memory _name) public view returns(string memory, uint256) {
        require(candidateExists[_name], "Candidate does not exist");
        return (_name, voteCount[_name]);
    }

    // 添加只能投票一次
    function checkVoter(address _address) private  view returns(bool) {
        return hasVoted[_address];
    }
}