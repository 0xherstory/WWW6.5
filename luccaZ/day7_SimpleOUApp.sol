//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleIOU {
  address public owner;

  //Track registered friends
  mapping(address => bool) public registeredFriends;
  address[] public friendList;

  //Track balance
  mapping(address => uint256) public balances;

  //Simple debt tracking
  mapping(address => mapping(address => uint256)) public debts; //debtor -> creditor -> amount

  constructor() {
    owner = msg.sender;
    registeredFriends[msg.sender] = true;
    friendList.push(msg.sender);
  }

  modifier onlyOwner() {
    require(msg.sender == owner, "Only owner can perform this action.");
    _;
  }

  modifier onlyRegistered() {
    require(registeredFriends[msg.sender], "You are not registered.");
    _;
  }

  //Register a new friend 
  function addFriend(address _friend) public onlyOwner {
    require(_friend != address(0), "Invalid address.");
    require(!registeredFriends[_friend], "Friend already registered.");

    registeredFriends[_friend] = true;
    friendList.push(_friend);
  }

  //deposit funds
  function depositIntoWallet() public payable onlyRegistered {
    require(msg.value > 0, "Must send ETH");
    balances[msg.sender] += msg.value;
    emit Transaction(msg.sender, address(this), msg.value, "Deposit");
  }

  //record that someone owes you money
  function recordDebt(address _debtor, uint256 _amount) public onlyRegistered {
    require(_debtor != address(0), "Invalid address.");
    require(registeredFriends[_debtor], "Address not registered.");
    require(_amount > 0, "Amount must be greater than 0.");

    debts[_debtor][msg.sender] += _amount;
  }

  //pay off debt using ginternal balance transfer
  function payFromWallet(address _creditor, uint256 _amount) public onlyRegistered {
    require(_creditor != address(0), "Invalid address.");
    require(registeredFriends[_creditor], "Creditor not registered.");
    require(_amount > 0, "Amount must be greater than 0.");
    require(debts[msg.sender][_creditor] >= _amount, "Debt amount incorrect.");
    require(balances[msg.sender] >= _amount, "Insufficient balance.");

    //Update balances and debt
    balances[msg.sender] -= _amount;
    balances[_creditor] += _amount;
    debts[msg.sender][_creditor] -= _amount;

    emit Transaction(msg.sender, _creditor, _amount, "DebtPayment");
  }

  //direct transfer method using transfer()
  function transferEther(address payable _to, uint256 _amount) public onlyRegistered {
    require(_to != address(0), "Invalid address.");
    require(registeredFriends[_to], "Recipient not registered.");
    require(balances[msg.sender] >= _amount, "Insufficient balance.");

    balances[msg.sender] -= _amount;
    _to.transfer(_amount);
    balances[_to] += _amount;

    emit Transaction(msg.sender, _to, _amount, "Transfer");
  }

  // alternative transfer method using call()
  function transferEtherViaCall(address payable _to, uint256 _amount) public onlyRegistered {
    require(_to != address(0), "Invalid address.");
    require(registeredFriends[_to], "Recipient not registered.");
    require(balances[msg.sender] >= _amount, "Insufficient balance.");

    balances[msg.sender] -= _amount;

    (bool success, ) = _to.call{value: _amount}("");
    require(success, "Ether transfer failed.");
    balances[_to] += _amount;

    emit Transaction(msg.sender, _to, _amount, "TransferViaCall");
  }

  //withdraw your balance, using call()
  function withdraw(uint256 _amount) public onlyRegistered {
    require(balances[msg.sender] >= _amount, "Insufficient balance.");
    balances[msg.sender] -= _amount;
    (bool success, ) = payable(msg.sender).call{value: _amount}("");
    require(success, "Withdrawal failed.");

    emit Transaction(msg.sender, payable(msg.sender), _amount, "Withdrawal");
  }

  //check your balance
  function checkBalance() public view onlyRegistered returns (uint256) {
    return balances[msg.sender];
  }

  //debt forgiveness - forgive a debt you are owed
  function forgiveDebt(address _debtor, uint256 _amount) public onlyRegistered {
    require(_debtor != address(0), "Invalid address.");
    require(registeredFriends[_debtor], "Debtor not registered.");
    require(debts[_debtor][msg.sender] >= _amount, "Amount exceeds debt.");
    debts[_debtor][msg.sender] -= _amount;
  }

  //group splits
  function splitExpense(uint256 _totalAmount, address[] memory _participants) public onlyRegistered {
    require(_totalAmount > 0, "Total amount must be greater than 0.");
    require(_participants.length > 0, "Must have at least one participant.");

    uint256 share = _totalAmount / _participants.length;

    for (uint256 i = 0; i < _participants.length; i++) {
      address participant = _participants[i];
      require(participant != address(0), "Invalid address.");
      require(registeredFriends[participant], "Participant not registered.");

      if (participant != msg.sender) {
        debts[participant][msg.sender] += share;
      }
    }
  }

  //event for logging transactions
  event Transaction(address indexed from, address indexed to, uint256 amount, string transactionType); 
}