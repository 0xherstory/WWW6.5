//声明开源许可证协议
//SPDX-License-Identifier:MIT

//声明使用的Solidity编译器版本
pragma solidity ^0.8.0;

//定义合约名字:Voting=简易投票系统
contract Voting {

    //--------状态变量-------------------

    //合约拥有者(部署者，负责初始化)
    address public owner;

    //投票是否结束
    bool public votingEnded;

    //候选人列表
    string[] public candidates;

    //映射表:记录每个候选人的得票数 (索引 -> 票数)
    mapping(uint256 => uint256) public votesCount;

    //映射表:记录地址是否已投票 (防止重复投票)
    mapping(address => bool) public hasVoted;

    //映射表:记录地址投给了哪个候选人 (索引)
    mapping(address => uint256) public votedCandidateIndex;

    //--------事件-----------------------

    //事件:投票完成
    event Voted(address indexed voter, uint256 candidateIndex);

    //事件:投票结束
    event VotingEnded();

    //--------修饰符---------------------

    //修饰符:只有所有者能调用
    modifier onlyOwner() {
        require(msg.sender == owner, "Not owner");
        _;
    }

    //修饰符:投票正在进行中
    modifier votingActive() {
        require(!votingEnded, "Voting has ended");
        _;
    }

    //--------构造函数-------------------

    constructor(string[] memory _candidateNames) {
        owner = msg.sender;
        
        //部署时初始化候选人列表
        for (uint256 i = 0; i < _candidateNames.length; i++) {
            candidates.push(_candidateNames[i]);
            votesCount[i] = 0; // 初始化票数为0
        }
    }

    //--------核心功能:投票--------------

    //进行投票
    function vote(uint256 _candidateIndex) external votingActive {
        require(!hasVoted[msg.sender], "Already voted");
        require(_candidateIndex < candidates.length, "Invalid candidate index");

        //1. 记录投票状态
        hasVoted[msg.sender] = true;
        votedCandidateIndex[msg.sender] = _candidateIndex;

        //2. 增加候选人票数
        votesCount[_candidateIndex]++;

        emit Voted(msg.sender, _candidateIndex);
    }

    //--------管理员功能-----------------

    //结束投票 (只有所有者)
    function endVoting() external onlyOwner {
        require(!votingEnded, "Already ended");
        votingEnded = true;
        emit VotingEnded();
    }

    //--------查询功能-------------------

    //获取候选人总数
    function getCandidatesCount() external view returns (uint256) {
        return candidates.length;
    }

    //获取特定候选人的名字
    function getCandidateName(uint256 _index) external view returns (string memory) {
        require(_index < candidates.length, "Invalid index");
        return candidates[_index];
    }

    //查询获胜者 (返回得票最多的候选人索引)
    //注意:如果有平局，返回索引较小的那个
    function getWinner() external view returns (uint256 winningIndex) {
        require(votingEnded, "Voting not yet ended");
        
        uint256 maxVotes = 0;
        
        for (uint256 i = 0; i < candidates.length; i++) {
            if (votesCount[i] > maxVotes) {
                maxVotes = votesCount[i];
                winningIndex = i;
            }
        }
        
        return winningIndex;
    }

    //查询用户的投票详情
    function getUserVote(address _user) external view returns (bool voted, uint256 choice) {
        return (hasVoted[_user], votedCandidateIndex[_user]);
    }
}