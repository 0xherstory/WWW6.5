// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleIOU {
    //状态变量，合约存储的核心数据
     address public owner; // 合约管理员(部署者)仅能注册新好友
     mapping(address => bool) public registeredFriends; // 记录已注册好友
     address[] public friendList; // 已注册好友的地址列表
     mapping(address => uint256) public balances; // 每个用户的存放在合约的ETH
     mapping(address => mapping(address => uint256)) public debts; //债务映射

     //构造函数，部署合约时自动执行
     constructor() {
        owner = msg.sender; // 部署者设为初始管理员
        registeredFriends[msg.sender] = true; // 管理员自己先注册为好友
        friendList.push(msg.sender); // 把管理员加入好友列表
    }

     //管理员权限能调用的函数
    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can perform this action");
        _; 
    }
     //已注册用户能调用的函数
    modifier onlyRegistered() {
        require(registeredFriends[msg.sender], "You are not registered");
        _; 
    }
     //管理员功能-注册新好友
    function addFriend(address _friend) public onlyOwner {
        require(_friend != address(0), "Invalid address"); // 禁止无效地址
        require(!registeredFriends[_friend], "Friend already registered"); // 防止重复注册

        registeredFriends[_friend] = true; // 标记该地址为已注册好友
        friendList.push(_friend); // 加入好友列表
    }
     //已注册用户功能
    function depositIntoWallet() public payable onlyRegistered {  //存钱-支付ETH到合约
        require(msg.value > 0, "Must send ETH"); // 必须发送大于0的ETH
        balances[msg.sender] += msg.value; // 内部钱包余额 += 本次发送的ETH金额
    }

    function recordDebt(address _debtor, uint256 _amount) public onlyRegistered { //用户借钱给别人
        require(_debtor != address(0), "Invalid address"); // 欠债人地址不能是空
        require(registeredFriends[_debtor], "Address not registered"); // 欠债人必须是已注册好友
        require(_amount > 0, "Amount must be greater than 0"); // 债务金额必须大于0

        debts[_debtor][msg.sender] += _amount; // 给指定欠债人增加一笔「欠我」的钱
    }

    function payFromWallet(address _creditor, uint256 _amount) public onlyRegistered {
        require(_creditor != address(0), "Invalid address"); // 债主地址不能是空
        require(registeredFriends[_creditor], "Creditor not registered"); // 债主必须是已注册好友
        require(_amount > 0, "Amount must be greater than 0"); // 还款金额必须大于0
        require(debts[msg.sender][_creditor] >= _amount, "Debt amount incorrect"); // 还款金额≤欠款
        require(balances[msg.sender] >= _amount, "Insufficient balance"); // 内部钱包余额足够
        
        //更新还款后的状态，我的余额少了，债主余额增加，债务减少
        balances[msg.sender] -= _amount;
        balances[_creditor] += _amount;
        debts[msg.sender][_creditor] -= _amount;
    }

    //用更安全的call方法
    function transferEtherViaCall(address payable _to, uint256 _amount) public onlyRegistered {
        require(_to != address(0), "Invalid address");
        require(registeredFriends[_to], "Recipient not registered");
        require(balances[msg.sender] >= _amount, "Insufficient balance");

        balances[msg.sender] -= _amount;
        // 调用call()方法转账，返回success状态，更兼容复杂合约
        (bool success, ) = _to.call{value: _amount}("");
        require(success, "Transfer failed"); // 转账失败则回滚

        balances[_to] += _amount;
    }

    //从内部钱包提现ETH到自己账户
    function withdraw(uint256 _amount) public onlyRegistered {
        require(balances[msg.sender] >= _amount, "Insufficient balance"); // 余额足够

        balances[msg.sender] -= _amount;
        // 用call()方法提现到自己地址（更安全）
        (bool success, ) = payable(msg.sender).call{value: _amount}("");
        require(success, "Withdrawal failed");
    }

    // 查看自己的内部钱包余额
    function checkBalance() public view onlyRegistered returns (uint256) {
        return balances[msg.sender];
    }
}