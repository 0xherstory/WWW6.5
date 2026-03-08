// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract AdvancedPoll {
    struct Candidate {
        string name;
        uint256 voteCount;
    }

    uint256 public constant MAX_CANDIDATES = 5;

    Candidate[] public candidates;

    function addCandidate(string memory _name) public {
        require(candidates.length < MAX_CANDIDATES, "Too many candidates!");
    
        candidates.push(Candidate(_name, 0));
    }

    function vote(uint256 _index) public {
        require(_index < candidates.length, "Candidate does not exist!");

        candidates[_index].voteCount++;
    }

}
