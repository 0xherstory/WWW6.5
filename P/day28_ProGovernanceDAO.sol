// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;
interface IERC20 {
    function balanceOf(address account) external view returns (uint256);
    function transferFrom(address from, address to, uint256 amount) external returns (bool);
    function transfer(address to, uint256 amount) external returns (bool);
    function totalSupply() external view returns (uint256);
}
contract ProGovernanceDAO {
    enum ProposalState { Pending, Active, Defeated, Succeeded, Queued, Executed, Canceled }

    struct Proposal {
        uint256 id;
        address proposer;
        string description;
        uint256 forVotes;
        uint256 againstVotes;
        uint256 startTime;
        uint256 endTime;
        uint256 eta; 
        bool executed;
        bool canceled;
        uint256 deposit; 
    }
    address public admin;
    IERC20 public governanceToken;

    uint256 public proposalCount;
    uint256 public votingDelay = 1;
    uint256 public votingPeriod = 3 days; 
    uint256 public timelockDelay = 2 days; 
    uint256 public quorumPercentage = 4; 
    uint256 public proposalDeposit = 100 * 10**18;

    mapping(uint256 => Proposal) public proposals;
    mapping(uint256 => mapping(address => bool)) public hasVoted;
    event ProposalCreated(uint256 id, address proposer, string description);
    event VoteCast(address indexed voter, uint256 proposalId, bool support, uint256 weight);
    event ProposalQueued(uint256 id, uint256 eta);
    event ProposalExecuted(uint256 id);

    modifier onlyOwner() {
        require(msg.sender == admin, "Not admin");
        _;
    }

    constructor(address _token) {
        admin = msg.sender;
        governanceToken = IERC20(_token);
    }

    function createProposal(string memory _description) external returns (uint256) {
        require(governanceToken.transferFrom(msg.sender, address(this), proposalDeposit), "Deposit failed");

        proposalCount++;
        uint256 newId = proposalCount;

        Proposal storage p = proposals[newId];
        p.id = newId;
        p.proposer = msg.sender;
        p.description = _description;
        p.startTime = block.timestamp + votingDelay;
        p.endTime = block.timestamp + votingDelay + votingPeriod;
        p.deposit = proposalDeposit;

        emit ProposalCreated(newId, msg.sender, _description);
        return newId;
    }
    function castVote(uint256 _proposalId, bool _support) external {
        Proposal storage p = proposals[_proposalId];
        
        require(block.timestamp >= p.startTime && block.timestamp <= p.endTime, "Not in voting period");
        require(!hasVoted[_proposalId][msg.sender], "Already voted");
        uint256 weight = governanceToken.balanceOf(msg.sender);
        require(weight > 0, "No voting power");

        if (_support) {
            p.forVotes += weight;
        } else {
            p.againstVotes += weight;
        }

        hasVoted[_proposalId][msg.sender] = true;
        emit VoteCast(msg.sender, _proposalId, _support, weight);
    }
    function queue(uint256 _proposalId) external {
        require(state(_proposalId) == ProposalState.Succeeded, "Proposal not succeeded");
        
        Proposal storage p = proposals[_proposalId];
        p.eta = block.timestamp + timelockDelay;
        
        emit ProposalQueued(_proposalId, p.eta);
    }
    function execute(uint256 _proposalId) external {
        require(state(_proposalId) == ProposalState.Queued, "Proposal not queued");
        require(block.timestamp >= proposals[_proposalId].eta, "Timelock not expired");

        Proposal storage p = proposals[_proposalId];
        p.executed = true;
        governanceToken.transfer(p.proposer, p.deposit);

        emit ProposalExecuted(_proposalId);
    }
    function state(uint256 _proposalId) public view returns (ProposalState) {
        Proposal storage p = proposals[_proposalId];
        if (p.canceled) return ProposalState.Canceled;
        if (p.executed) return ProposalState.Executed;
        if (block.timestamp < p.startTime) return ProposalState.Pending;
        if (block.timestamp <= p.endTime) return ProposalState.Active;

        uint256 totalVotes = p.forVotes + p.againstVotes;
        uint256 quorum = (governanceToken.totalSupply() * quorumPercentage) / 100;

        if (totalVotes < quorum || p.forVotes <= p.againstVotes) {
            return ProposalState.Defeated;
        } else {
            return p.eta == 0 ? ProposalState.Succeeded : ProposalState.Queued;
        }
    }
    function updateQuorum(uint256 _newQuorum) external onlyOwner {
        require(_newQuorum <= 20, "Quorum too high"); 
        quorumPercentage = _newQuorum;
    }

    function updateDeposit(uint256 _newDeposit) external onlyOwner {
        proposalDeposit = _newDeposit;
    }
}