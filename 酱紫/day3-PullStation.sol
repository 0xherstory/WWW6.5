// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract PollStation {

    //数组与映射定义
    string[] public candidateNames;
    mapping(string => uint256) voteCount;

    //【钱包地址】是否已经投过票 address 是 Solidity 特有类型，存的是 0x... 这种钱包地址，bool=布尔值，用于判断true/false
    mapping(address => bool) hasVoted;

    //【候选人名字】是否真的存在
    mapping(string => bool) isExist;
    //添加候选人
    function addCandidateNames(string memory _candidateNames) public {
        // 防止重复添加同一个候选人, 如果添加了同一人会出现错误提示
        require(!isExist[_candidateNames], "Candidate already exists!");
        
        candidateNames.push(_candidateNames);
        voteCount[_candidateNames] = 0;
        isExist[_candidateNames] = true; // 标记该名字已录入系统
    }

    // 投票功能（带“防作弊”和“防空投”）
    function vote(string memory _candidateNames) public {
        // 【检查 1】：检查当前投票人是否投过票
        // msg.sender 是内置变量，代表当前正在点击按钮的那个人的地。如果同一地址重复投票后，会出现You have already voted! 报错
        require(!hasVoted[msg.sender], "You have already voted!");

        // 【检查 2】：检查候选人是否在名单内
        require(isExist[_candidateNames], "Candidate does not exist!");

        // 【执行】：如果上面两关都过了，才执行下面的代码
        voteCount[_candidateNames] += 1;
        hasVoted[msg.sender] = true; // 标记此人已投票，下次再来就会触发“检查 1”
    }
    //查询候选人，列出候选数组
    function checkcandidateNames() public view returns (string[] memory) {
        return candidateNames;
    }
    //查询投票数，输入候选人名字，出现票数结果
    function checkVote(string memory _candidateNames) public view returns (uint256) {
        return voteCount[_candidateNames];
    }
}
