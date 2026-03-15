// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract UltimatePresidentIOU {
    address public owner; 
    mapping(address => bool) public registeredFriends; 
    mapping(address => uint256) public balances; 
    
    mapping(address => mapping(address => uint256)) public debts;

    uint256 public globalUnlockTime; 

    modifier onlyOwner() {
        require(msg.sender == owner, "Only President can do this!");
        _;
    }

    modifier onlyRegistered() {
        require(registeredFriends[msg.sender], "You are not in the group!");
        _;
    }

    constructor(uint256 _lockDuration) {
        owner = msg.sender;
        registeredFriends[msg.sender] = true;
        globalUnlockTime = block.timestamp + _lockDuration;
    }

    function addFriend(address _friend) public onlyOwner {
        require(_friend != address(0), "Invalid address");
        registeredFriends[_friend] = true;
    }

    function deposit() public payable onlyRegistered {
        require(msg.value > 0, "Must send ETH");
        balances[msg.sender] += msg.value;
    }

    function splitBillAutoPay(address[] memory _debtors, uint256 _totalAmount) public onlyRegistered {
        uint256 share = _totalAmount / (_debtors.length + 1);
        
        for (uint i = 0; i < _debtors.length; i++) {
            address debtor = _debtors[i];
            require(registeredFriends[debtor], "One debtor not registered");

            if (balances[debtor] >= share) {
                balances[debtor] -= share;
                balances[msg.sender] += share;
            } else {
                uint256 remainingDebt = share - balances[debtor];
                if (balances[debtor] > 0) {
                    balances[msg.sender] += balances[debtor];
                    balances[debtor] = 0;
                }
                debts[debtor][msg.sender] += remainingDebt;
            }
        }
    }

    function withdraw(uint256 _amount) public onlyRegistered {
        require(block.timestamp >= globalUnlockTime, "Group funds are still locked!");
        require(balances[msg.sender] >= _amount, "Insufficient balance");

        balances[msg.sender] -= _amount;

        (bool success, ) = payable(msg.sender).call{value: _amount}("");
        require(success, "Transfer failed");
    }

    function getMyDebtTo(address _creditor) public view returns (uint256) {
        return debts[msg.sender][_creditor];
    }
}
