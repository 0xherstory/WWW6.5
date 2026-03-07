// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract PollStation{
    string[] public candidateNames;
    mapping(string => uint256) voteCount;

    function addCandidateNames(string memory _candidatesNames) public{
        candidateNames.push(_candidatesNames);
        voteCount[_candidatesNames]=0;
        //添加一个候选人。第一步：加入候选人数组； 第二步：初始化票数为0
    }

    function getcandidateNames() public view returns(string[] memory){
        return candidateNames;
        //返回所有候选人的名字列表。
    }

    function vote(string memory _candidateNames) public {
        voteCount[_candidateNames] += 1;
        /*给某个候选人投一票。这个函数：
            修改区块链状态
            会产生 transaction
            需要支付 Gas */
    }

    function getVote(string memory _candidateNames)public view returns (uint256){
        return voteCount[_candidateNames];
        //查询某个候选人的票数。
    }
}