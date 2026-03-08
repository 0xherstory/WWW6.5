//SPDX-License-Identifier:MIT
pragma solidity ^0.8.0;
contract Pollstation{
    string[]public candidatenames;
    mapping(string=>uint256)votecount;
    function addcandidatenames(string memory aacandidatenames)public {
        candidatenames.push(aacandidatenames);
        votecount[aacandidatenames]=0;
}
function getcandidatenames()public view returns (string[]memory){
    return candidatenames;
}
function vote (string memory aacandidatenames) public{
    votecount[aacandidatenames]+=1;
}
function getvote(string memory aacandidatenames)public view returns(uint256){
return votecount [aacandidatenames];
}
}