// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
 * @title PollStation
 * @author mumu
 * @notice This contract is a simple poll station that allows users to vote on a user('s name)
 * @dev This contract is a simple poll station that allows users to vote on a user
 * @dev learning how to use mapping and array
 */
contract PollStation{
    string[] public candidateNames;
    mapping(string => uint256) public voteCount;

    // 1. 向投票中添加候选人
    function addCandidate(string memory _candidateName) public {
        candidateNames.push(_candidateName);
        voteCount[_candidateName] = 0; // 初始化投票数为0
    }

    // 2. 检索候选人列表
    function getCandidateNames() public view returns (string[] memory) {
        return candidateNames;
    }

    // 3. 为候选人投票
    function vote(string memory _candidateName) public {
        voteCount[_candidateName] += 1;
    }

    // 4. 检查候选人收到的总票数，可以直接使用内置getter函数
    function getVoteCount(string memory _candidateName) public view returns (uint256) {
        return voteCount[_candidateName];
    }
    
    // 其他：
    // candidateNames的内置getter函数为：candidateNames(uint256 index) public view returns (string memory)
    // voteCount的内置getter函数为：voteCount(string memory candidateName) public view returns (uint256)
}

/*
mapping(string => uint256) public voteCount;
  - key: string (candidate name)
  - value: uint256 (vote count)
  - example: "Alice": 10, "Bob": 5
  - mapping is a key-value store
  how to use mapping:
    - voteCount["Alice"] = 10;
    - voteCount["Bob"] = 5;
nested mapping:
  - mapping(string => mapping(string => uint256)) public voteCount;
  - example: "Alice": {"Bob": 5, "Charlie": 3}, "Bob": {"Alice": 10, "Charlie": 3}
  - nested mapping is a mapping of mappings
  how to use nested mapping:
    - voteCount["Alice"]["Bob"] = 5;
    - voteCount["Bob"]["Alice"] = 10;

what if a key is not found?
  - voteCount["Charlie"] 会返回 0（Solidity mapping 未设置的 key 默认返回 0）
how to add a new key?
  - voteCount["Charlie"] = 3; // 直接赋值即可添加新 key

array:
  - string[] public candidateNames;
  - example: ["Alice", "Bob", "Charlie"]
  Solidity 里实际可用的：
    - candidateNames.push("Alice");   // 在末尾添加
    - candidateNames[0] = "Alice";   // 按索引赋值（索引必须已存在或先 push）
    - candidateNames.pop();          // 删除最后一个元素
    - candidateNames.length;         // 数组长度
 */