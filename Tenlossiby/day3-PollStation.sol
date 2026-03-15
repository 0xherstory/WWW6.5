// SPDX-License-Identifier: MIT

// 声明Solidity版本，要求编译器版本在0.8.0或更高（但低于0.9.0）
pragma solidity ^0.8.0;

// 定义一个名为PollStation的合约，用于投票站功能
contract PollStation{

    // 声明一个公共的字符串数组，用于存储所有候选人的姓名
    // [] 表示这是一个数组类型
    // public 关键字会自动生成getter函数
    string[] public candidateNames;
    
    // 声明一个映射（mapping），用于存储每个候选人获得的票数
    // 映射结构：mapping(键类型 => 值类型)
    // 这里用候选人的姓名（字符串）作为键，对应的票数（uint256）作为值
    mapping(string => uint256) voteCount;

    // 定义一个函数，用于添加候选人到投票站
    function addCandidateNames(string memory _candidateNames) public{
        // 将候选人姓名添加到数组末尾（push方法）
        candidateNames.push(_candidateNames);
        
        // 在映射中初始化该候选人的票数为0
        voteCount[_candidateNames] = 0;
    }
    
    // 定义一个函数，用于获取所有候选人的姓名列表
    function getcandidateNames() public view returns (string[] memory){
        // 返回候选人姓名数组
        return candidateNames;
    }

    // 定义一个函数，用于给指定候选人投票
    function vote(string memory _candidateNames) public{
        // 将指定候选人的票数加1
        // += 是复合赋值运算符，等同于 voteCount[_candidateNames] = voteCount[_candidateNames] + 1
        voteCount[_candidateNames] += 1;
    }

    // 定义一个函数，用于获取指定候选人获得的票数
    function getVote(string memory _candidateNames) public view returns (uint256){
        // 返回指定候选人的票数
        return voteCount[_candidateNames];
    }

}