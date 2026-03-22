// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


contract UltimateEfficientVoting {
    

    error NotChairperson();
    error InvalidProposal();
    error VotingNotStarted();
    error VotingEnded();
    error AlreadyVoted();
    error AlreadyExecuted();
    error DurationTooShort();

    struct Proposal {
        bytes32 name;      
        uint32 voteCount;   
        uint32 startTime;  
        uint32 endTime;  
        bool executed;   
    }

 
    address public immutable chairperson; 
    uint8 public proposalCount;
    
    mapping(uint8 => Proposal) public proposals;
    

    mapping(address => uint256) private voterRegistry;


    event ProposalCreated(uint8 indexed id, bytes32 name);
    event Voted(address indexed voter, uint8 indexed id);


    modifier onlyChairperson() {
        if (msg.sender != chairperson) revert NotChairperson();
        _;
    }

    constructor() {
        chairperson = msg.sender;
    }

    function createProposal(bytes32 name, uint32 duration) external onlyChairperson {
        if (duration == 0) revert DurationTooShort();
        
        uint8 id = proposalCount;
        

        Proposal storage p = proposals[id];
        p.name = name;
        p.startTime = uint32(block.timestamp);
        p.endTime = uint32(block.timestamp) + duration;

        unchecked { proposalCount++; }
        
        emit ProposalCreated(id, name);
    }

    function vote(uint8 proposalId) external {

        Proposal storage proposal = proposals[proposalId];
        uint32 endTime = proposal.endTime;
        uint32 startTime = proposal.startTime;


        if (proposalId >= proposalCount) revert InvalidProposal();
        if (block.timestamp < startTime) revert VotingNotStarted();
        if (block.timestamp > endTime) revert VotingEnded();


        uint256 voterData = voterRegistry[msg.sender];
        uint256 mask = 1 << proposalId;
        if ((voterData & mask) != 0) revert AlreadyVoted();


        voterRegistry[msg.sender] = voterData | mask;
        

        unchecked {
            proposal.voteCount++;
        }

        emit Voted(msg.sender, proposalId);
    }


    function executeProposal(uint8 proposalId) external onlyChairperson {
        if (proposalId >= proposalCount) revert InvalidProposal();
        
        Proposal storage proposal = proposals[proposalId];
        if (block.timestamp <= proposal.endTime) revert VotingNotStarted();
        if (proposal.executed) revert AlreadyExecuted();

        proposal.executed = true;

    }

    function hasVoted(address voter, uint8 proposalId) external view returns (bool) {
        return (voterRegistry[voter] & (1 << proposalId)) != 0;
    }
}