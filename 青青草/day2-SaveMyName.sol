// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
contract Profile{
    string public QQC;
    string public web3developer;
    function add(string memory _QQC, string memory _web3developer)public {
       QQC = _QQC;
       web3developer = _web3developer;
    }
    function retrieve()public view returns (string memory, string memory) {
        return (QQC, web3developer);
    }
}