//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleIOU {
    address public owner;
    mapping(address => bool) public registeredFriends;
    address[] public friendList;
    mapping(address => uint256) public balances;
    mapping(address => mapping(address => uint256)) public debts; //debtor -> creditor ->amount

    constructor(){
        owner = msg.sender;
        registeredFriends[msg.sender] = true;
        friendList.push(msg.sender);
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can perform this action.");
        _;
    }
    modifier onlyRegistered() {
        require(registeredFriends[msg.sender], "You are not registered.");
        _;
    }

    //Register a new friend
    function addFriend(address _friend) public onlyOwner {
        require(_friend !=address(0), "Invalid address");
        require(!registeredFriends[_friend], "Friend already registered");
        registeredFriends[_friend] = true;
        friendList.push(_friend);
    }

    //成员使用功能如下
    //功能一 从外部钱包存钱进余额
    //Deposit funds to your balance
    function depositIntoWallet() public payable onlyRegistered {
        require(msg.value > 0, "Must send ETH");
        balances[msg.sender] += msg.value;
    }

    //功能二 债权人登记借款与债务人通过余额调整还款
    //Record that someone owed you money
    function recordDebt(address _debtor, uint256 _amount) public onlyRegistered {
        require(_debtor != address(0), "Invalid address");
        require(registeredFriends[_debtor], "Debtor not registered");
        require(_amount > 0, "Amount must be greater than 0");
        debts[_debtor][msg.sender] += _amount;
    }
    //Pay off debt using internal balance transfer 钱始终在合约上，只是双方余额数字增减
    function payFromWallet(address _creditor, uint256 _amount) public onlyRegistered {
        require(_creditor != address(0), "Invalid address");
        require(registeredFriends[_creditor], "Creditor not registered");
        require(_amount >0, "Amount must be greater than 0");
        require(debts[msg.sender][_creditor] >= _amount, "Debt amount incorrect");
        require(balances[msg.sender] >= _amount, "Insufficient balance");
        balances[msg.sender] -= _amount;
        balances[_creditor] += _amount;
        debts[msg.sender][_creditor] -= _amount;
    }

    //功能三 向已登记朋友的外部钱包转账
    //Transfer method using transfer() 从合约向creditor钱包转账【方法一】
     function transferEther(address payable _to, uint256 _amount) public onlyRegistered {
        require(_to != address(0), "Invalid address");
        require(registeredFriends[_to], "Recipient not registered");
        require(balances[msg.sender] >= _amount, "Insufficient balance");
        balances[msg.sender] -= _amount;
        _to.transfer(_amount);
     }
    //Alternative transfer method using call() 【方法二】
    function transferEtherViaCall(address payable _to, uint256 _amount) public onlyRegistered {
        require(_to != address(0), "Invalid address");
        require(registeredFriends[_to], "Recipient not registered");
        require(balances[msg.sender] >= _amount, "Insufficient balance");
        balances[msg.sender] -= _amount;
        (bool success,) = _to.call{value: _amount}(""); //success是声明在函数内部的临时变量（bool值），.call动作实现则其为true
        require(success, "Transfer failed"); //要求success为true，整个函数才算成功；若为false，程序中止，函数内前面的操作也撤回，恢复到调用此函数前的状态。在区块链上，一个函数里的所有操作要么全部成功，要么全部失败，没有中间状态。
    }

    //功能四 从自己的余额中取钱出来
    //Withdraw your balance using transfer() 【方法一】
    function withdraw(uint256 _amount) public onlyRegistered {
        require(balances[msg.sender] >= _amount, "Insufficient balance");
        balances[msg.sender] -= _amount;
        payable(msg.sender).transfer(_amount); //payable(msg.sender)将msg.sender转换为payable地址，允许从合约转账到外部地址
    }
    //Withdraww using call() 【方法二】
    function withdrawViaCall(uint256 _amount) public onlyRegistered {
        require(balances[msg.sender] >= _amount, "Insufficient balance");
        balances[msg.sender] -= _amount;
        (bool success,) = payable(msg.sender).call{value: _amount}("");
        require(success, "Withdrawal failed");
    }

    //功能五 查看自己的余额
    function checkBalance() public view onlyRegistered returns (uint256) {
        return balances[msg.sender];
    }

    //功能六 查看完整的注册成员名单
    function getFriendList() public view onlyRegistered returns (address[] memory) {
        return friendList;
    }

}

/*payable修饰函数：允许调用者从自己钱包转账进合约（外部→合约）。
  payable修饰地址：允许调用者从合约转账进该地址（合约→外部），通过transfer()或send()。

  transfer()需要payable实现转账：为保障安全性，编译器认为，除非显式说明payable，否则普通地址没有收钱功能，不提供.transfer方法。
    transfer()`传统上被认为是安全的，原因是：
    - 如果发送失败，它【自动恢复】
    - 它【仅向接收者转发 2300 gas】——刚好足以接收 ETH，但不足以执行任何其他代码（防止重入攻击）
  call()不需要payable：call属于底层调用，绕过了编译器的类型检查，更高兼容性和灵活性；当然也带来了风险，需要手动检查（比如通过require函数）。*/