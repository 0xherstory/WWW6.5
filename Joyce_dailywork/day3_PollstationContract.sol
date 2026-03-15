// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
contract Pollstation{
    string[] public candidateNames; //新建候选人数组
    mapping (string => uint256) voteCount; //映射（候选人——>票数）
    function addCandidateNames(string memory _candidateNames)
    public{
        candidateNames.push(_candidateNames);
        voteCount[_candidateNames] = 0;
    } //添加候选人

    function getcadidateName() public view returns (string[] memory)  {
    return candidateNames;
    } //检索候选人列表

    function vote( string memory _candidateNames) public {
        voteCount[_candidateNames] += 1;
    } //为候选人投票

    function getvote( string memory _candidateNames) public view returns(uint256) {
        return voteCount[_candidateNames];
    } //检查候选人票数
}

