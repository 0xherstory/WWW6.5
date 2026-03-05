// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract PollStation {
    address public owner;
    uint256 public startTime;
    uint256 public endTime;

    string[] public candidateNames;
    mapping(string => bool) public isCandidate;
    mapping(string => uint256) public voteCount;
    mapping(address => bool) public hasVoted;

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this function");
        _;
    }

    modifier votingActive() {
        require(block.timestamp >= startTime, "Voting has not started yet");
        require(block.timestamp <= endTime, "Voting has ended");
        _;
    }

    // constructor: set owner and voting duration
    // _votingDurationSeconds: e.g. 1 day = 86400
    constructor(uint256 _votingDurationSeconds) {
        owner = msg.sender;
        startTime = block.timestamp;
        endTime = block.timestamp + _votingDurationSeconds;
    }

    // add a candidate (only owner)
    function addCandidate(string memory _candidateName) public onlyOwner {
        require(bytes(_candidateName).length > 0, "Candidate name is empty");
        require(!isCandidate[_candidateName], "Candidate already exists");

        candidateNames.push(_candidateName);
        isCandidate[_candidateName] = true;
    }

    // remove a candidate (only owner)
    // gas‑saving pattern: overwrite with last element, then pop
    function removeCandidate(string memory _candidateName) public onlyOwner {
        require(isCandidate[_candidateName], "Candidate does not exist");

        uint256 len = candidateNames.length;
        for (uint256 i = 0; i < len; i++) {
            if (
                keccak256(bytes(candidateNames[i])) ==
                keccak256(bytes(_candidateName))
            ) {
                candidateNames[i] = candidateNames[len - 1];
                candidateNames.pop();
                break;
            }
        }

        isCandidate[_candidateName] = false;
        voteCount[_candidateName] = 0;
    }

    // vote for a candidate (each address can vote only once, and only during voting period)
    function vote(string memory _candidateName) public votingActive {
        require(isCandidate[_candidateName], "Candidate does not exist");
        require(!hasVoted[msg.sender], "You have already voted");

        voteCount[_candidateName] += 1;
        hasVoted[msg.sender] = true;
    }

    // get all candidate names
    function getCandidates() public view returns (string[] memory) {
        return candidateNames;
    }

    // get vote count for a candidate
    function getVoteCount(string memory _candidateName)
        public
        view
        returns (uint256)
    {
        return voteCount[_candidateName];
    }

    // check if voting is currently active
    function isVotingActive() public view returns (bool) {
        return block.timestamp >= startTime && block.timestamp <= endTime;
    }
}
