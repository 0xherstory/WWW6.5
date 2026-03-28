// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// 导入OpenZeppelin的ERC20标准接口（母合约，兼容所有治理代币）
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
// 导入OpenZeppelin的重入防护母合约（防重入攻击，安全核心）
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";

/// @title DecentralizedGovernance - 去中心化DAO治理合约（带时间锁、法定人数、提案押金）
contract DecentralizedGovernance is ReentrancyGuard {
    // ==================== 状态变量：存储治理核心数据 ====================
    IERC20 public governanceToken; // 治理代币（社区代币，用来投票）

    // ==================== 提案结构体：存储每个提案的详细信息 ====================
    struct Proposal {
        address proposer;        // 提案创建者
        string description;       // 提案描述
        uint256 forVotes;         // 支持票数量
        uint256 againstVotes;    // 反对票数量
        uint256 startTime;       // 投票开始时间
        uint256 endTime;         // 投票结束时间
        bool executed;           // 是否已经执行
        bool canceled;           // 是否被取消
        uint256 timelockEnd;     // 时间锁结束时间（执行前等待的时间）
    }

    // 存储所有提案：提案ID => 提案详情
    mapping(uint256 => Proposal) public proposals;
    // 存储投票记录：提案ID => 用户地址 => 是否已经投票
    mapping(uint256 => mapping(address => bool)) public hasVoted;

    // ==================== 治理参数（管理员可调整） ====================
    uint256 public nextProposalId;          // 下一个提案的ID（自动递增）
    uint256 public votingDuration;          // 投票持续时间（秒，比如7天=604800）
    uint256 public timelockDuration;        // 时间锁时长（秒，比如2天=172800）
    address public admin;                   // 管理员地址（部署者）
    uint256 public quorumPercentage;        // 法定人数比例（%，比如20=20%，提案通过需要的最低投票比例）
    uint256 public proposalDepositAmount;   // 创建提案需要的押金（治理代币数量）

    // ==================== 事件：记录所有操作，链上可查、全程透明 ====================
    event ProposalCreated(
        uint256 indexed proposalId,
        address indexed proposer,
        string description
    ); // 提案创建成功

    event Voted(
        uint256 indexed proposalId,
        address indexed voter,
        bool support,
        uint256 weight
    ); // 用户投票成功

    event ProposalExecuted(uint256 indexed proposalId); // 提案执行成功
    event QuorumNotMet(uint256 indexed proposalId); // 提案未达到法定人数，取消
    event ProposalTimelockStarted(uint256 indexed proposalId); // 时间锁启动

    // ==================== 权限修饰器：只有管理员能调用 ====================
    modifier onlyAdmin() {
        require(msg.sender == admin, "Not admin");
        _;
    }

    // ==================== 构造函数：部署合约时初始化 ====================
    constructor(
        address _governanceToken,    // 治理代币合约地址
        uint256 _votingDuration,     // 投票时长（秒）
        uint256 _timelockDuration,   // 时间锁时长（秒）
        uint256 _quorumPercentage,   // 法定人数比例（%，比如20=20%）
        uint256 _proposalDepositAmount // 提案押金（治理代币数量）
    ) {
        require(_governanceToken != address(0), "Invalid token"); // 代币地址不能是零地址
        require(_votingDuration > 0, "Invalid duration"); // 投票时长必须大于0
        // 法定人数比例0-100%，防止乱设置
        require(_quorumPercentage > 0 && _quorumPercentage <= 100, "Invalid quorum");

        governanceToken = IERC20(_governanceToken);
        votingDuration = _votingDuration;
        timelockDuration = _timelockDuration;
        admin = msg.sender;
        quorumPercentage = _quorumPercentage;
        proposalDepositAmount = _proposalDepositAmount;
    }

    // ==================== 功能1：创建提案（核心功能，押押金，防重入） ====================
    function createProposal(string memory description) external nonReentrant returns (uint256) {
        require(bytes(description).length > 0, "Empty description"); // 提案描述不能为空

        // 如果有押金要求，用户必须押足够的治理代币
        if (proposalDepositAmount > 0) {
            require(
                governanceToken.balanceOf(msg.sender) >= proposalDepositAmount,
                "Insufficient balance for deposit"
            );
            // 把押金转到合约里（用transferFrom，标准ERC20函数）
            governanceToken.transferFrom(msg.sender, address(this), proposalDepositAmount);
        }

        // 生成新的提案ID
        uint256 proposalId = nextProposalId++;

        // 初始化提案信息
        proposals[proposalId] = Proposal({
            proposer: msg.sender,
            description: description,
            forVotes: 0,
            againstVotes: 0,
            startTime: block.timestamp,
            endTime: block.timestamp + votingDuration,
            executed: false,
            canceled: false,
            timelockEnd: 0
        });

        emit ProposalCreated(proposalId, msg.sender, description);
        return proposalId;
    }

    // ==================== 功能2：用户投票（支持/反对，代币加权，防重入） ====================
    function vote(uint256 proposalId, bool support) external nonReentrant {
        Proposal storage proposal = proposals[proposalId];

        // 投票必须在投票时间内
        require(block.timestamp >= proposal.startTime, "Not started");
        require(block.timestamp <= proposal.endTime, "Ended");
        // 提案不能已经执行/取消
        require(!proposal.executed, "Already executed");
        require(!proposal.canceled, "Canceled");
        // 用户不能重复投票
        require(!hasVoted[proposalId][msg.sender], "Already voted");

        // 投票权重 = 用户持有的治理代币数量（1 token = 1票）
        uint256 weight = governanceToken.balanceOf(msg.sender);
        require(weight > 0, "No voting power"); // 必须有代币才能投票

        // 标记用户已经投票
        hasVoted[proposalId][msg.sender] = true;

        // 累加支持/反对票
        if (support) {
            proposal.forVotes += weight;
        } else {
            proposal.againstVotes += weight;
        }

        emit Voted(proposalId, msg.sender, support, weight);
    }

    // ==================== 功能3：结算提案，决定通过/不通过（防重入） ====================
    function finalizeProposal(uint256 proposalId) external nonReentrant {
        Proposal storage proposal = proposals[proposalId];

        // 必须是投票结束状态才能结算
        require(block.timestamp > proposal.endTime, "Voting not ended");
        require(!proposal.executed, "Already executed");
        require(!proposal.canceled, "Canceled");

        // 计算总票数、总代币供应量、法定人数要求
        uint256 totalVotes = proposal.forVotes + proposal.againstVotes;
        uint256 totalSupply = governanceToken.totalSupply();
        uint256 quorumRequired = (totalSupply * quorumPercentage) / 100; // 法定人数 = 总代币 × 法定比例 / 100

        // 检查是否达到法定人数，且支持票 > 反对票
        if (totalVotes >= quorumRequired && proposal.forVotes > proposal.againstVotes) {
            if (timelockDuration > 0) {
                // 有时间锁：启动时间锁，等待执行
                proposal.timelockEnd = block.timestamp + timelockDuration;
                emit ProposalTimelockStarted(proposalId);
            } else {
                // 无时间锁：直接执行提案
                proposal.executed = true;
                _refundDeposit(proposalId);
                emit ProposalExecuted(proposalId);
            }
        } else {
            // 未达到法定人数/支持票不足：取消提案，退还押金
            proposal.canceled = true;
            _refundDeposit(proposalId);
            emit QuorumNotMet(proposalId);
        }
    }

    // ==================== 功能4：执行提案（时间锁后，核心功能，防重入） ====================
    function executeProposal(uint256 proposalId) external nonReentrant {
        Proposal storage proposal = proposals[proposalId];

        // 必须有时间锁，且时间锁已结束
        require(proposal.timelockEnd > 0, "No timelock set");
        require(block.timestamp >= proposal.timelockEnd, "Timelock not ended");
        require(!proposal.executed, "Already executed");
        require(!proposal.canceled, "Canceled");

        // 标记提案为已执行
        proposal.executed = true;
        // 退还提案押金
        _refundDeposit(proposalId);

        emit ProposalExecuted(proposalId);
    }

    // ==================== 内部函数：退还提案押金（零警告，防重入） ====================
    function _refundDeposit(uint256 proposalId) internal {
        if (proposalDepositAmount > 0) {
            Proposal storage proposal = proposals[proposalId];
            // ✅ 用call替代弃用的transfer，加require保证转账成功（零警告）
            (bool success, ) = payable(proposal.proposer).call{value: proposalDepositAmount}("");
            require(success, "Failed to refund deposit to proposer");
        }
    }

    // ==================== 功能5：查询提案结果（外部查看用） ====================
    function getProposalResult(uint256 proposalId) external view returns (
        bool passed,
        uint256 forVotes,
        uint256 againstVotes,
        bool executed
    ) {
        Proposal memory proposal = proposals[proposalId];
        passed = proposal.forVotes > proposal.againstVotes;
        return (passed, proposal.forVotes, proposal.againstVotes, proposal.executed);
    }

    // ==================== 功能6：管理员调整法定人数比例 ====================
    function setQuorumPercentage(uint256 _newQuorum) external onlyAdmin {
        require(_newQuorum > 0 && _newQuorum <= 100, "Invalid quorum");
        quorumPercentage = _newQuorum;
    }

    // ==================== 功能7：管理员调整提案押金金额 ====================
    function setProposalDepositAmount(uint256 _newAmount) external onlyAdmin {
        proposalDepositAmount = _newAmount;
    }

    // ==================== 功能8：管理员调整投票时长 ====================
    function setVotingDuration(uint256 _newDuration) external onlyAdmin {
        require(_newDuration > 0, "Invalid duration");
        votingDuration = _newDuration;
    }

    // ==================== 功能9：管理员调整时间锁时长 ====================
    function setTimelockDuration(uint256 _newDuration) external onlyAdmin {
        timelockDuration = _newDuration;
    }
}