// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleIOU{
    address public owner;

    //Track registered friends
    mapping(address => bool) public registeredFriends;
    address[] public friendlist;

    //Track balances
    mapping(address => uint256) public balances;

    //Simple debt tracking
    mapping(address => mapping(address => uint256)) public debts; //debtor -> creditor -> amount

    constructor() {
        owner = msg.sender;
        registeredFriends[msg.sender] = true;
        friendlist.push(msg.sender);
    }
    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can perform this action");
        _;
    }

    modifier onlyRegistered() {
        require(registeredFriends[msg.sender], "You are not registered");
        _;
    
    }

    //Register a new friend
    function addFriend(address newfriend) public onlyOwner {
        require(newfriend != address(0), "Invalid address");
        require(!registeredFriends[newfriend], "Already registered");

        registeredFriends[newfriend] = true;
        friendlist.push(newfriend);
    }

    //Deposit funds to your balance
    function depositIntoWallet() public payable onlyRegistered {
        require(msg.value > 0, "Must send ETH");
        balances[msg.sender] += msg.value;
    }

    //Record that someone ownes you money 
    function recordDebt(address newdebtor, uint newamount) public onlyRegistered {
        require(newdebtor != address(0), "Invalid address");
        require(registeredFriends[newdebtor], "Address not registered");
        require(newamount > 0, "Amount must be greater than 0");

        debts[newdebtor][msg.sender] += newamount;
    }

    // Pay off debt using internal balance transfer
    function payFromWallet (address newcreditor, uint256 newamount) public onlyRegistered {
        require(newcreditor != address(0), "Invalid address");
        require(registeredFriends[newcreditor], "Creditor not registered");
        require(newamount > 0, "Amount must be greater than 0");
        require(debts[msg.sender][newcreditor] >= newamount, "Debt amount incorrect");
        require(balances[msg.sender] >= newamount, "Insufficient balance");

        //update balance and debt
        balances[msg.sender] -= newamount;
        balances[newcreditor] += newamount;
        debts[msg.sender][newcreditor] -=newamount;
    }

    //Direct transfer method using tranfer() -- Old way
    //function transfreEther(address payable newto, uint256 newamount) public onlyRegistered {
        //require(newto != address(0), "Invalid address");
        //require(registeredFriends[newto], "Recipient not registered");
        //require(balances[msg.sender] >= newamount, "Insufficient balance");
        //balances[msg.sender] -= newamount;
        //newto.transfer(newamount);
        //balances[newto] += newamount;
    //}

    //Alternative transfer method using call()
    function transferEtherViaCall(address payable newto, uint256 newamount) public onlyRegistered {
        require(newto != address(0), "Invalid address");
        require(registeredFriends[newto], "Recipient not registered");
        require(balances[msg.sender] >= newamount, "Insufficient balance");
        
        balances[msg.sender] -= newamount;
        (bool success,) = newto.call{value: newamount}("");
        balances[newto] += newamount;
        require(success, "Transfer failed");
    }

    //Withdraw your balance 
    function withdraw(uint256 newamount) public onlyRegistered {
        require(balances[msg.sender] >= newamount, "Insufficient balance");

        balances[msg.sender] -= newamount;

        (bool success, ) = payable(msg.sender).call{value: newamount}("");
        require(success, "Withdrawal failed");
    }

    //Check your balance
    function chackBalance()public view onlyRegistered returns (uint256) {
        return balances[msg.sender];
    }


}