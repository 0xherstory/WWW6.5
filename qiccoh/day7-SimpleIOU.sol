//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleIOU{

    address public owner;

     //是否注册  注册列表
    mapping(address => bool) public registeredFriends;
    address[] public friendList;

    mapping(address => uint256) public balances;

     //嵌套映射 二元数组
    mapping(address => mapping(address => uint256)) public debts;

     
constructor() {
    owner = msg.sender;
    //给自己注册权
    registeredFriends[msg.sender] = true;
    friendList.push(msg.sender);
}

 //确保只有部署合约的人
modifier onlyOwner() {
    require(msg.sender == owner, "Only owner can perform this action");
    _;
}

 
modifier onlyRegistered() {
    require(registeredFriends[msg.sender], "You are not registered");
    _;
}

 
function addFriend(address _friend) public onlyOwner {
    require(_friend != address(0), "Invalid address");
    require(!registeredFriends[_friend], "Friend already registered");

    registeredFriends[_friend] = true;
    friendList.push(_friend);
}

 
function depositIntoWallet() public payable onlyRegistered {
    require(msg.value > 0, "Must send ETH");
    balances[msg.sender] += msg.value;
}

 
function recordDebt(address _debtor, uint256 _amount) public onlyRegistered {
   //地址是否有效？
    require(_debtor != address(0), "Invalid address");
  //地址是否注册
    require(registeredFriends[_debtor], "Address not registered");
    require(_amount > 0, "Amount must be greater than 0");
//_debtor欠msg.sender，_amount
    debts[_debtor][msg.sender] += _amount;
}

 //还钱
function payFromWallet(address _creditor, uint256 _amount) public onlyRegistered {
    require(_creditor != address(0), "Invalid address");
    require(registeredFriends[_creditor], "Creditor not registered");
    require(_amount > 0, "Amount must be greater than 0");
    //还的钱少了
    require(debts[msg.sender][_creditor] >= _amount, "Debt amount incorrect");
    //还款人的钱包够不够
    require(balances[msg.sender] >= _amount, "Insufficient balance");

    balances[msg.sender] -= _amount;
    balances[_creditor] += _amount;
    debts[msg.sender][_creditor] -= _amount;
}

//给他人发红包
// function transferEther(address payable _to, uint256 _amount) public onlyRegistered {
//     //收件人地址有效吗？
//     require(_to != address(0), "Invalid address");
//    //他们是否在群组中注册？
//     require(registeredFriends[_to], "Recipient not registered");
//    //您的余额中有足够的 ETH 吗？
//     require(balances[msg.sender] >= _amount, "Insufficient balance");

//     balances[msg.sender] -= _amount;
//     //将 ETH 从合约发送到接收者的地址。
//     _to.transfer(_amount);
//     balances[_to] += _amount;

//     //transfer()：将 ETH 从合约发送到外部地址，《= 2300 个 gas，否则转移失败，自动恢复
// }



function transferEtherViaCall(address payable _to, uint256 _amount) public onlyRegistered {
    require(_to != address(0), "Invalid address");
    require(registeredFriends[_to], "Recipient not registered");
    require(balances[msg.sender] >= _amount, "Insufficient balance");

    balances[msg.sender] -= _amount;
//比起transfer()，call无 gas 限制 ,使用success 变量检查作是否成功 、call() 使函数与智能合约地址兼容
    (bool success, ) = _to.call{value: _amount}("");
    balances[_to] += _amount;
    require(success, "Transfer failed");
}

 
function withdraw(uint256 _amount) public onlyRegistered {
    require(balances[msg.sender] >= _amount, "Insufficient balance");

    balances[msg.sender] -= _amount;
//使用call()将其发送回钱包
    (bool success, ) = payable(msg.sender).call{value: _amount}("");
    require(success, "Withdrawal failed");
}

 
function checkBalance() public view onlyRegistered returns (uint256) {
    return balances[msg.sender];
}




}