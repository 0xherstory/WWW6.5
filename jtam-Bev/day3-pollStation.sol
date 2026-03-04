//SPDX-License-Identifier:MIT
//这是我的许可证书

pragma solidity ^0.8.0;

contract pollStation {

    string[]public candidateNames;
    mapping (string=>uint256) voteCount;

//防作弊机制。建立一个谁投过票的记录表

    mapping (address=>bool) public hasVoted;
//bool值是true和false。


//防止给没在名单里的人投票
    mapping (string =>bool) public isRegistered;

    //bool 值 默认为假
    function addCandiateNames(string memory _candidateNames) public{
        candidateNames.push(_candidateNames);

        voteCount[_candidateNames]=0;

        isRegistered[ _candidateNames]= true;

    
    }

    function getcandidateNames() public view returns (string []memory){

      return candidateNames;

    }

    function vote(string memory _candidateNames) public {
//防止多投的逻辑是要先检查是否投过票， 没投过放行；反之，阻止并提示
    require (!hasVoted[msg.sender],"Erroe:You have alredy voted!");
//!=not. 
        voteCount[ _candidateNames]+=1;

        hasVoted [msg.sender] =true;
    }

    function getVote(string memory _candidateNames)public view returns (uint256) {
        return voteCount[ _candidateNames];
    
    }



}


















