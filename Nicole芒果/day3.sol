// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract PollStation{

    //状态变量
    string[] public candidateNames;
    //一个由string类型元素组成的数组
    //带有“//” 表示是数组
    mapping(string => uint256) voteCount;
    //mapping（映射） "=>"是固定写法

    //函数——向投票中添加候选人
    //一个叫做 addCandidateNames的函数，接收一个传入参数，没有返回参数
    function addCandidateNames(string memory _candidateNames) public{
        candidateNames.push(_candidateNames);
        //函数操作一：将候选人储存在数组中
        voteCount[_candidateNames] = 0;
        //函数操作二：将候选人的初始票数设为0
    }

    //函数——检索候选人列表
    //一个叫做 getcandidateNames的函数，没有传入参数，有一个返回参数
    function getcandidateNames() public view returns (string[] memory){
        return candidateNames;
    }

    //函数——为候选人投票
    //一个叫做 vote的函数，接收一个传入参数，没有返回参数
    function vote(string memory _candidateNames) public{
        voteCount[_candidateNames] += 1;//意思是访问名为"votecount"的mapping状态变量中的“键”，即candidatenames;
    }

    //函数——检查候选人的总票数
    //一个叫做 getVote的函数，接收一个传入参数，返回一个参数
    function getVote(string memory _candidateNames) public view returns (uint256){
        return voteCount[_candidateNames];
    }

}