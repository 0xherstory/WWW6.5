// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract PullStation{
    string[] public candidateNames;
    mapping(string=>uint256) voteCount;

    //添加owner控制，只有owner可以添加候选人
    address public owner;
    constructor() {
        owner = msg.sender; // 部署合约的地址 = owner
    }

    //添加候选人
    function candidateAdd(string memory _candidateNames) public{
        require(msg.sender==owner,"Only owner can add candidate");
        require(!checkIfValid(_candidateNames),"candidate already exist.");
        candidateNames.push(_candidateNames); 
    }
    //获取所有候选人
    function candidateGet() public view returns(string[]memory){
        return candidateNames;
    }
    //投票
    function vote(string memory _candidateNames)public{
        require(hasVoted[msg.sender]==false,"has been voted"); //判断是否已经投过票了]);
        require(!checkIfValid(_candidateNames),"candidate not exist");
        voteCount[_candidateNames]++;
        hasVoted[msg.sender]=true;
    }
    //查看某个候选人的票数
    function check(string memory _candidateNames) public view returns(uint256){
        return voteCount[_candidateNames];
    }
    //防止重复投票
    mapping(address => bool) public hasVoted;
    //检查候选人是否存在
    function checkIfValid(string memory _candidateNames) public view returns(bool){
        for(uint256 i=0;i<candidateNames.length;i++){
            if(keccak256(bytes(candidateNames[i]))==keccak256(bytes(_candidateNames))){
                return true;
            }
        }
        return false;
    }
    //删除候选人
    function removeCandidate(string memory name)public {
        require(msg.sender==owner,"Only owner can remove candidate");
        require(checkIfValid(name),"candidate is not exist.");
    //    require(msg.sender==chairperson,"only chairperson can remove candidate.");
        for(uint256 i=0;i<candidateNames.length;i++){
            if(keccak256(bytes(candidateNames[i]))==keccak256(bytes(name))){
                candidateNames[i]=candidateNames[candidateNames.length-1];
                candidateNames.pop();
                break;
            }
        }
    }
    //添加一个函数返回获胜者(票数最多的候选人)
    function checkWinner () public view returns(string memory){
        uint256 maxVotes = 0;
        uint256 winnerIndex = 0;
        for (uint256 i = 0; i < candidateNames.length; i++) {
            if (voteCount[candidateNames[i]] > maxVotes) {
                maxVotes = voteCount[candidateNames[i]];
                winnerIndex = i;
            }
        }
        return candidateNames[winnerIndex];

    }

    //使用struct存储候选人信息(名字、票数、描述等)
    

}