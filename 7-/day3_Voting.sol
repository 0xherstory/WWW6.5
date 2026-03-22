// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

contract Voting {
    mapping(string => uint256) public voteCount;
    string[] public candidates;

    constructor(string[] memory _candidates) {
        for (uint256 i = 0; i < _candidates.length; i++) {
            candidates.push(_candidates[i]);
            voteCount[_candidates[i]] = 0;
        }
    }

    function vote(string memory _candidate) public {
        // 英文提示语，无兼容问题
        require(isCandidate(_candidate), "Candidate does not exist!");
        voteCount[_candidate] += 1;
    }

    function getVoteCount(string memory _candidate) public view returns (uint256) {
        // 英文提示语，无兼容问题
        require(isCandidate(_candidate), "Candidate does not exist!");
        return voteCount[_candidate];
    }

    function isCandidate(string memory _candidate) internal view returns (bool) {
        for (uint256 i = 0; i < candidates.length; i++) {
            if (keccak256(abi.encodePacked(candidates[i])) == keccak256(abi.encodePacked(_candidate))) {
                return true;
            }
        }
        return false;
    }

    function getAllCandidates() public view returns (string[] memory) {
        return candidates;
    }
}