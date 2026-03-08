// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract PollStation {
    struct Candidate {
        string name;
        uint256 voteCount;
        string description; // 可选描述
    }

    // 当前进行投票的候选人
    Candidate[] public candidates;
    
    // 地址是否已经投票
    mapping(address => bool) public hasVoted;
    
    // 合约所有者
    address public owner;

    // 构造函数，设定初始合约所有者
    constructor() {
        owner = msg.sender;
    }

    // 仅允许所有者操作的修饰符
    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can perform this action");
        _;
    }

    // 添加新候选人，只有合约所有者才能增加
    function addCandidate(string memory _name, string memory _description) public onlyOwner {
        candidates.push(Candidate(_name, 0, _description));
    }
    
    // 移除候选人，只有合约所有者才能执行
    function removeCandidate(string memory _name) public onlyOwner {
        for (uint i = 0; i < candidates.length; i++) {
            if (keccak256(bytes(candidates[i].name)) == keccak256(bytes(_name))) {
                candidates[i] = candidates[candidates.length - 1];
                candidates.pop();
                break;
            }
        }
    }

    // 投票给指定候选人
    function vote(string memory _name) public {
        require(!hasVoted[msg.sender], "You have already voted");
        bool candidateExists = false;
        
        for (uint i = 0; i < candidates.length; i++) {
            if (keccak256(bytes(candidates[i].name)) == keccak256(bytes(_name))) {
                candidates[i].voteCount++;
                candidateExists = true;
                break;
            }
        }
        
        require(candidateExists, "Candidate does not exist");
        hasVoted[msg.sender] = true;
    }

    // 返回候选人票数最多的名字
    function getWinner() public view returns (string memory winnerName_) {
        uint256 maxVotes = 0;
        for (uint i = 0; i < candidates.length; i++) {
            if (candidates[i].voteCount > maxVotes) {
                maxVotes = candidates[i].voteCount;
                winnerName_ = candidates[i].name;
            }
        }
    }
    
    // 获取某个候选人的票数
    function getVote(string memory _name) public view returns (uint256) {
        for (uint i = 0; i < candidates.length; i++) {
            if (keccak256(bytes(candidates[i].name)) == keccak256(bytes(_name))) {
                return candidates[i].voteCount;
            }
        }
        return 0; // 不存在的候选人票数为0
    }
}