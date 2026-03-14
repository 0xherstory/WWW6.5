// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract PollStation {
    // 候选人列表(数组 - 可遍历)
    string[] public candidateNames;
    
    // 票数统计(映射 - 快速查询)
    mapping(string => uint256) voteCount;
    
    // 添加候选人
    function addCandidateNames(string memory _candidateNames) public {
        candidateNames.push(_candidateNames);
    }
    
    // 获取所有候选人
    function getcandidateNames() public view returns (string[] memory) {
        return candidateNames;
    }
    
    // 投票
    function vote(string memory _candidateNames) public {
        voteCount[_candidateNames]++;
    }
    
    // 查看某个候选人的票数
    function getVote(string memory _candidateNames) public view returns (uint256) {
        return voteCount[_candidateNames];
    }
}

/* 自动生成的 candidateNames() 函数

当你写：

string[] public candidateNames;

编译器会自动生成一个类似这样的函数：

function candidateNames(uint256 index) public view returns (string memory)

作用是：

根据下标读取数组里的元素。

例如：

下标	候选人
0	Alice
1	Bob
2	Tom

调用：

candidateNames(0)

返回：

Alice

调用：

candidateNames(1)

返回：

Bob

所以你在 Remix IDE 里会看到一个按钮：

candidateNames

点开后会让你输入：

uint256

其实就是让你输入：

数组下标 index*/