// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract VotingStation {
    string[] private candidates;
    mapping(uint256 => uint256) public votes;
    mapping(address => bool) public hasVoted;

    function addCandidate(string memory name) external {
        candidates.push(name);
    }

    function getCandidates() external view returns (string[] memory) {
        return candidates;
    }

    function vote(uint256 index) external {
        require(!hasVoted[msg.sender], "Already voted");
        require(index < candidates.length, "Invalid candidate");
        hasVoted[msg.sender] = true;
        votes[index] += 1;
    }
}
