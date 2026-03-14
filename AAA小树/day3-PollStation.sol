// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;
//contract Vote {
//    uint public voteCount;
//    mapping(address => bool) public voted;//防止重复(bool两个值：true  （是）false （否）)
//    function vote() public {
//        require(!voted[msg.sender], "Already voted");//！投过就拒绝
//        voted[msg.sender] = true;
//        voteCount++;
//    }
//}
contract PollStation{
//使用数组（完整访问
    string[] public candidateNames;
    //使用印射（即时访问拉取
    mapping(string => uint256) voteCount;

    function addCandidateNames(string memory _candidateNames) public{
        candidateNames.push(_candidateNames);
        voteCount[_candidateNames] = 0;
    }
   //检索候选人 
    function getcandidateNames() public view returns (string[] memory){
        return candidateNames;
    }
//开始投票
    function vote(string memory _candidateNames) public{
        voteCount[_candidateNames] += 1;
    }
//view票数
    function getVote(string memory _candidateNames) public view returns (uint256){
        return voteCount[_candidateNames];
    }

}