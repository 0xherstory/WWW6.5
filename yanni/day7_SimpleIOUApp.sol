//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract simpleIOU{
    address public owner;

    //Track registered friends
    mapping(address => bool) public registeredFriends;
    address[] public friendList;

    //Track balances
    mapping(address => uint256) public balances;

    //Simple debt tracking;debtor -> creditor -> amount
    mapping(address => mapping(address => uint256)) public debts;

    constructor(){
        owner = msg.sender;
        registeredFriends[msg.sender] = true;
        friendList.push(msg.sender);

    }

    modifier Owner(){
        require(msg.sender == owner, "Only owner can perform this action");
        _;
    }

    modifier Registered(){
        require(registeredFriends[msg.sender], "You are not registered.");
        _;
    }

    //register a new friend
    function addFriend(address _friend) public Owner{
        require(_friend != address(0),"Invalid address");
        require(!registeredFriends[_friend], "Friend already registered");

        registeredFriends[_friend] = true;
        friendList.push(_friend);
    }

    //Deposit funds to wallet
    function depositToWallet() public payable Registered{
        require(msg.value > 0, "Must send ETH.");
        balances[msg.sender] += msg.value;

    }

    //Record debts
    function recordDebts(address _debtor, uint256 _amount) public Registered{
        require(_debtor != address(0), "Invalid address");
        require(registeredFriends[_debtor], "Address not registered.");
        require(_amount > 0, "Amount must be greater than 0.");

        debts[_debtor][msg.sender] += _amount;
    }

    //Pay within the contract
    function payFromWallet(address _creditor, uint256 _amount) public Registered{
        require(_creditor != address(0),  "Invalid address.");
        require(registeredFriends[_creditor], "Creditor not registered.");
        require(_amount > 0, "Amount must be greater than 0.");
        require(debts[msg.sender][_creditor] >= _amount, "Debt amount incorrect.");
        require(balances[msg.sender] >= _amount, "Insufficient balance.");

        balances[msg.sender] -= _amount;
        balances[_creditor] += _amount;
        debts[msg.sender][_creditor] -= _amount;
    }
    
    //Transfer Ether to address  
    function transferEther(address payable _to, uint256 _amount) public Registered{
        require(_to != address(0), "Invalid address.");
        require(registeredFriends[_to], "Recipient not registered.");
        require(balances[msg.sender] >= _amount, "Insufficient balance.");

        balances[msg.sender] -= _amount;
        _to.transfer(_amount);
        balances[_to] += _amount;
    }

    //Call transfer
     function transferEtherViaCall(address payable _to, uint256 _amount) public Registered {
        require(_to != address(0), "Invalid address.");
        require(registeredFriends[_to], "Recipient not registered.");
        require(balances[msg.sender] >= _amount, "Insufficient balance.");
        
        balances[msg.sender] -= _amount;
        
        (bool success, ) = _to.call{value: _amount}("");
        balances[_to]+=_amount;
        require(success, "Transfer failed.");
    }
    // Withdraw balance
    function withdraw(uint256 _amount) public Registered {
        require(balances[msg.sender] >= _amount, "Insufficient balance.");
        
        balances[msg.sender] -= _amount;
        
        (bool success, ) = payable(msg.sender).call{value: _amount}("");
        require(success, "Withdrawal failed.");
    }
    
    // Check balance
    function checkBalance() public view Registered returns (uint256) {
        return balances[msg.sender];
    }
}
   