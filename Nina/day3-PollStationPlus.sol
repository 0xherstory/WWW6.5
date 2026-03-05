//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract PollStation{

    //声明candidateNames状态变量为string数组格式。当一个状态变量被声明为 public 时，Solidity 会自动为它创建一个同名的 Getter 函数；对于数组来说，输入uint256输出string，即可以查询第几位候选人的名字（始于0）。
    //声明voteCount状态变量为uint256格式且由string格式的数据映射
    string[] public candidateNames;
    mapping(string=>uint256) voteCount;
    //【改进1】防止同个地址重复投票，一个地址只能投一张票
    mapping(address=>bool) public hasVoted;
    //【改进2】防止给不存在于候选人列表中的人投票
    mapping(string=>bool) public candidateExists;

    //用户可公开调用addCandidateNames函数将候选人名字添加至candidateNames数组末尾，该候选人名字所映射的voteCount初始为0
    //通过.push在数组末尾添加值，而非覆盖。如果需要覆盖掉某位候选人的名字，可以通过uint256格式指定位置
    //【改进3】防止重复添加同一个候选人，即候选人列表中同一个名字只能出现一次。在调用addCandidateNames函数的时候，如果是第一次输入某个名字，该名字所映射的candidateExists（bool值）为初始值false，所以!candidateExists[_name]为true，可以继续执行代码---在存入candidateNames数组数据以及voteCount初始值的同时，也存入该名字所映射的candidateExists的bool值为true。当第二次输入同一个名字的时候，!candidateExists[_name]就是!true即false了，则提示"Candidate already exists!"并且程序中止。
    function addCandidateNames(string memory _candidateNames) public{
        require(!candidateExists[_candidateNames],"This candidate already exists!");
        candidateNames.push(_candidateNames);
        voteCount[_candidateNames]=0;
        candidateExists[_candidateNames]=true;
    }

    //用户可公开调用getCandidateNames函数查询到候选人名字数组
    function getCandidateNames() public view returns (string[] memory){
        return candidateNames;
    }

    //用户可公开调用vote函数，使某候选人票数+1
    function vote(string memory _candidateNames) public{
        //【改进2】检查候选人是否存在于列表
        require(candidateExists[_candidateNames],"This candidate does not exist!");
        //【改进1】检查该用户是否已经投过票，msg.sender是当前发起交易的用户的地址
        require(!hasVoted[msg.sender],"You have already voted. Each user can only vote once.");
        voteCount[_candidateNames]+=1;
        hasVoted[msg.sender]=true;
    }

    //用户可公开调用getVote函数查询到某位候选人的票数
    function getVote(string memory _candidateNames) public view returns (uint256){
        return voteCount [_candidateNames];
    }
}

