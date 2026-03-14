//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleIOU{
     address public owner;

    //整一个朋友群组和加入状态
    mapping(address => bool) public registeredFriends;
    address[] public friendList;

    //成员跟余额映射一下
    mapping(address => uint256) public balances;

    //做一个嵌套映射，记录谁欠了谁多少钱
    mapping(address => mapping(address => uint256))public debts;//debts[债务人]「债权人」=债务金额；映射顺序是：债务人->债权人->债务金额

    //照常架构一下
    constructor(){
        owner = msg.sender;
        registeredFriends[msg.sender] = true;
        friendList.push(msg.sender);
    }

    modifier onlyOwner(){
        require(msg.sender == owner, "Only owner can perform this action");
        _;
    }

    modifier onlyRegistered(){
        require(registeredFriends[msg.sender], "You are not registered");
        _;
    }

    //加个好友进来，仅owner操作
    function addFriend(address _friend) public onlyOwner{
        require(_friend != address(0), "Invalid address");
        require(!registeredFriends[_friend], "Friend already registered");

        registeredFriends[_friend] = true;
        friendList.push(_friend);
    }

    //存钱到合约内部，用到payable
    function depositIntoWallet() public payable onlyRegistered {
        require(msg.value > 0, "Must send ETH");
        balances[msg.sender] += msg.value;
    }

    // 记录债务情况，调用者输入债务人和金额，缺审核机制
    function recordDebt(address _debtor, uint256 _amount) public onlyRegistered {
        require(_debtor != address(0), "Invalid address");
        require(registeredFriends[_debtor], "Address not registered");
        require(_amount > 0, "Amount must be greater than 0");
        
        debts[_debtor][msg.sender] += _amount; //谁欠了谁多少，债务更新
    }
    
    // 从合约内部调整债务和还款，由债务人调用，不涉及外部
    function payFromWallet(address _creditor, uint256 _amount) public onlyRegistered {
        require(_creditor != address(0), "Invalid address");
        require(registeredFriends[_creditor], "Creditor not registered");
        require(_amount > 0, "Amount must be greater than 0");
        require(debts[msg.sender][_creditor] >= _amount, "Debt amount incorrect"); //查验债务
        require(balances[msg.sender] >= _amount, "Insufficient balance");
        
        // 更新双方余额和债务
        balances[msg.sender] -= _amount;
        balances[_creditor] += _amount;
        debts[msg.sender][_creditor] -= _amount;
    }
    
    // 用transfer()转账，适用于只转账的情况，且不会返回转账情况，转账没成功直接不执行余额更新。
    function transferEther(address payable _to, uint256 _amount) public onlyRegistered { //涉及外部，用address payable验证地址是否能接收以太币
        require(_to != address(0), "Invalid address");
        require(registeredFriends[_to], "Recipient not registered");
        require(balances[msg.sender] >= _amount, "Insufficient balance");
        balances[msg.sender] -= _amount;
        _to.transfer(_amount); //外部转账操作
        balances[_to]+=_amount;
    }
    
    // 使用call()转账，可以转帐或合约，gas没有限制，且可以返回是否成功或更多信息，但需要防止重入攻击
    function transferEtherViaCall(address payable _to, uint256 _amount) public onlyRegistered {
        require(_to != address(0), "Invalid address");
        require(registeredFriends[_to], "Recipient not registered");
        require(balances[msg.sender] >= _amount, "Insufficient balance");
        
        balances[msg.sender] -= _amount;
        
        (bool success, ) = _to.call{value: _amount}(""); //执行转账操作，成功则返回true
        balances[_to]+=_amount;
        require(success, "Transfer failed"); //一道防线，如果返回false，则回滚之前的情况，余额不更新
    }
    
    // 提取余额
    function withdraw(uint256 _amount) public onlyRegistered {
        require(balances[msg.sender] >= _amount, "Insufficient balance");
        
        balances[msg.sender] -= _amount;
        
        (bool success, ) = payable(msg.sender).call{value: _amount}(""); //在这里验证地址是否可以接收以太币
        require(success, "Withdrawal failed");
    }
    
    // 查询余额
    function checkBalance() public view onlyRegistered returns (uint256) {
        return balances[msg.sender];
    }
        
}
