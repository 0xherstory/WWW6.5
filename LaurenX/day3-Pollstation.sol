// SPDX-License-Identifier:MIT
pragma solidity ^ 0.8.0 ;

contract PollStation{

string [] public candidateNames;//动态字符串数组
mapping(string => uint256) voteCount;//mapping 映射-记账本（把名字string对应到票数(uint256)

function addcandidateNameso(string memory _candidateNames) public {
    candidateNames .push (_candidateNames);//报名功能
}

function getcandidateNames() public view returns(string[] memory){
    return candidateNames;//查看名单
}

function vote(string memory _candidateNames)public{
    voteCount [_candidateNames]++;//投票+= 1
}

function getvote(string memory _candidateNames) public view returns(uint256){
    return voteCount [_candidateNames];//查询票数
}

}
