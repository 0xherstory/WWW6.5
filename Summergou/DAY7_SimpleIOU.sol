// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleIOU { //群账单
    //定义管理员
    address public owner;
    //定义好友成员
    mapping (address => bool) public registeredFriends;
    address[] public friendList;
    //跟踪每位好友存入的钱
    mapping (address => uint256) public balances;
    //debts[debtor][creditor]=amount的嵌套映射：debtor欠creditor一共amount的钱
    mapping (address => mapping (address => uint256)) public debts;

    //构造函数——部署合约时，部署者称为owner
    constructor () {
        owner = msg.sender;
        registeredFriends[msg.sender] = true;
        friendList.push (msg.sender);
    }

    //控制访问（modifier）
    modifier onlyOwner() {
        require (msg.sender == owner, "Only owner can perform this action.");
        _;
    }
    modifier onlyRegistered() {
        require (registeredFriends[msg.sender], "You are not registered.");
        _;
    }

    //添加好友成员
    function addFriend (address _friend) public onlyOwner {
        require (_friend != address (0), "Invalid address.");
        require (!registeredFriends[_friend], "Friend already registered.");
        registeredFriends[_friend] = true;
        friendList.push (_friend);
    }

    //用户将ETH添加到其应用内余额
    function depositIntoWallet() public payable onlyRegistered {
        require (msg.value > 0, "Must send ETH."); //mgs.value表示保存该用户发送的ETH数量
        balances[msg.sender] += msg.value;
    }

    //记录账单债务情况
    function recordDebt (address _debtor, uint256 _amount) public onlyRegistered {
        require (_debtor != address (0), "Invalid address.");
        require (registeredFriends[_debtor], "Address not registered.");
        require (_amount > 0, "Amount must be greater than 0.");
        debts[_debtor][msg.sender] += _amount;
    }

    //使用存储的余额来偿还某人
    function payFromWallet (address _creditor, uint256 _amount) public onlyRegistered {
        require (_creditor != address (0), "Invalid address.");
        require (registeredFriends[_creditor], "Creditor not registered.");
        require (_amount > 0, "Amount must be greater than 0.");
        require (debts[msg.sender][_creditor] >= _amount, "Debt amount incorrect."); //检查自己欠对方的钱
        require (balances[msg.sender] >= _amount, "Insufficient balance."); //确保自己有足够的ETH来还钱
        balances[msg.sender] -= _amount;
        balances[_creditor] += _amount;
        debts[msg.sender][_creditor] -= _amount; //从债务中减去还了的钱
    }

    //转账给某人——transfer的方法
    function transferEther (address payable _to, uint256 _amount) public onlyRegistered {
        require (_to != address (0), "Invalid address.");
        require (registeredFriends[_to], "Recipient not registered.");
        require (balances[msg.sender] >= _amount, "Insufficient balance.");
        balances[msg.sender] -= _amount;
        _to.transfer(_amount); //transfer是solidit内置的方法，用于将ETH从合约发送到外部地址
        balances[_to] += _amount;
    }

    //将ETH发送给ta人——call的方法（可以与智能合约地址兼容）
    function transferEtherViaCall (address payable _to, uint256 _amount) public onlyRegistered {
        require (_to != address (0), "Invalid address.");
        require (registeredFriends[_to], "Recipient not registered.");
        require (balances[msg.sender] >= _amount, "Insufficient balance.");
        balances[msg.sender] -= _amount;
        (bool success,) = _to.call {value: _amount}(""); //call函数可以使用success变量检查是否成功
        balances[_to] += _amount;
        require (success, "Transfer failed.");
    }

    //用call的方法取钱
    function withdraw (uint256 _amount) public onlyRegistered {
        require (balances[msg.sender] >= _amount, "Insufficient balance.");
        balances[msg.sender] -= _amount;
        (bool success,) = payable(msg.sender).call {value: _amount}("");
        require (success, "withdrawal failed.");
    }

    //检查系统中有多少ETH
    function checkBalance() public view  onlyRegistered returns (uint256) {
        return balances[msg.sender];
    }
}
