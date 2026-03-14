//SPDX-License-Identifier:MIT
//首先先告知开源
pragma solidity ^0.8.0;//定义solidity 的使用版本
contract PollStation{   //定义智能合约
    string[] public candidateNames;  //储存多个字符串 用string【】  candidateNames智能合约名字  公开
    mapping(string=>uint256) voteCount; //映射 string(存储字符 =》 数字(投票票数)  ) //储存投票票数
    function addCandidateNames(string memory _addCandidateNames) public{ //开始定义智能合约的功能
    //addCandidateNames 是给这个功能取得名字 相当于python中def addCandidateNames()  _addCandidateNames相当于占位符
    //类似于python中的 input（） 能够读取输入了什么

        candidateNames.push(_addCandidateNames);//把候选人名字输入到程序中 函数名字.push(占位符)  
        voteCount[_addCandidateNames]=0;//把候选人名字初始化为0
    }
    function getcandidateNames() public view returns (string[] memory ){ //功能获取候选人名字然后储存
        return candidateNames;//输出候选人名字
    }
    function vote(string memory _candidateNames) public {
        voteCount[_candidateNames]+=1;
    }
    function getVote(string memory _candidateNames)  public view returns(uint256){
        return voteCount[_candidateNames];
    } 
}
