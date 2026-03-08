// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleIOU {
     mapping(address => mapping(address => uint256)) public debts;

    function issueIOU(address _debtor, uint256 _amount) public {
        debts[msg.sender][_debtor] += _amount;
    }

    function settleIOU(address _debtor, uint256 _amount) public {
        uint256 currentDebt = debts[msg.sender][_debtor];
        require(currentDebt >= _amount, "Not enough debt to settle");
        
        debts[msg.sender][_debtor] -= _amount;
    }

    function getDebt(address _creditor, address _debtor) public view returns (uint256) {
        return debts[_creditor][_debtor];
    }
}