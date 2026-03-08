// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract AdvancedPoll {
    struct Candidate {
        string name;
        uint256 voteCount;
    }

    address public manager;
    uint256 public constant MAX_CANDIDATES = 5;
    Candidate[] public candidates;
    
    // 记录谁投过票
    mapping(address => bool) public hasVoted;

    constructor() {
        manager = msg.sender;
    }

    function addCandidate(string memory _name) public {
        require(msg.sender == manager, "Only manager can add candidates");
        require(candidates.length < MAX_CANDIDATES, "Too many candidates!");
        candidates.push(Candidate(_name, 0));
    }

    function vote(uint256 _index) public {
        require(!hasVoted[msg.sender], "You have already voted!");
        require(_index < candidates.length, "Candidate does not exist!");

        candidates[_index].voteCount++;
        hasVoted[msg.sender] = true; // 标记已投票
    }

    function getCandidateCount() public view returns (uint256) {
        return candidates.length;
    }
}
