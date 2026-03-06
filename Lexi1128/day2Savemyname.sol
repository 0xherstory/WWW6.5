//SPDX-License-Identifier:MIT
pragma solidity ^0.8.0;
contract Savemyname{
    string name;
    string bio;
    function add(string memory aaaname ,string memory aaabio)public {
        name=aaaname;
        bio=aaabio;
        }
function retrieve()public view returns(string memory,string memory){
    return(name,bio);
}
}