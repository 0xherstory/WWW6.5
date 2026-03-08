// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleIOU {
    address public owner;
    mapping(address => bool) public registeredFriends;
    address[] public friendList;
    mapping(address => uint256) public balances;
    
    // 嵌套映射:记录债务关系 (张三 欠 李四 100块)
    // 修正：全部使用类型来声明
    mapping(address => mapping(address => uint256)) public debts;
    
    constructor() { owner = msg.sender; }
    
    modifier onlyOwner() { require(msg.sender == owner, "Not the owner"); _; }
    modifier onlyRegistered() { require(registeredFriends[msg.sender], "Not registered"); _; }
    
    // 添加朋友
    function addFriend(address _friend) public onlyOwner {
        require(!registeredFriends[_friend], "Already registered");
        registeredFriends[_friend] = true;
        friendList.push(_friend);
    }
    
    // 存入ETH到钱包
    function depositIntoWallet() public payable onlyRegistered {
        balances[msg.sender] += msg.value;
    }
    
    // 记录债务(谁欠谁多少钱)
    function recordDebt(address _debtor, uint256 _amount) public onlyRegistered {
        // 修正：_debtor 欠 msg.sender(当前调用者) 钱
        debts[_debtor][msg.sender] += _amount;
    }
    
    // 从钱包支付债务
    function payFromWallet(address _creditor, uint256 _amount) public onlyRegistered {
        require(balances[msg.sender] >= _amount, "Insufficient balance");
        require(debts[msg.sender][_creditor] >= _amount, "No debt to pay");
        
        balances[msg.sender] -= _amount;
        balances[_creditor] += _amount;
        debts[msg.sender][_creditor] -= _amount;
    }
    
    // 保留的原代码：使用传统的 transfer 转账
    function transferEther(address payable _to, uint256 _amount) public onlyRegistered {
        require(balances[msg.sender] >= _amount, "Insufficient balance");
        balances[msg.sender] -= _amount;
        _to.transfer(_amount);
    }
    
    function transferEtherViaCall(address payable _to, uint256 _amount) public onlyRegistered {
        require(balances[msg.sender] >= _amount, "Insufficient balance");
        balances[msg.sender] -= _amount;
        
        // .call 返回两个值：第一个是布尔值(成功与否)，第二个是返回的数据(我们这里不需要，所以用逗号留空了)
        (bool success, ) = _to.call{value: _amount}("");
        require(success, "Transfer failed");
    }
    
    // 提取余额
    // 修正：改回了 uint256，补上了 require 结尾的分号
    function withdraw(uint256 _amount) public onlyRegistered {
        require(balances[msg.sender] >= _amount, "Insufficient balance");
        balances[msg.sender] -= _amount;

        (bool success, ) = payable(msg.sender).call{value: _amount}("");
        require(success, "Transfer failed");
    }

    function getDebt(address _debtor, address _creditor) public view returns (uint256){
        return debts[_debtor][_creditor];
    }
}