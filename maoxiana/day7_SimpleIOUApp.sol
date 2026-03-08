//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleIOUApp {

    address public owner;//拥有者
    mapping(address => bool) public registeredFriends;//是否注册了好友
    address[] public friendList;//好友列表
    mapping(address => uint256) public balances;//余额
    //debts[debtor][creditor] = amount;  debts[0xAsha][0xRavi] = 1.5 ether; 表示Asha欠Ravi 1.5 ether
    mapping (address => mapping(address => uint256)) public debts;//债务

    constructor() {
        owner = msg.sender;
        registeredFriends[owner] = true;//标记部署者为已注册好友
        friendList.push(owner);//好友列表添加部署者
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this action");
        _;
    }

    modifier onlyRegistered(){
        require(registeredFriends[msg.sender], "You are not registered.");
        _;
    }

    //添加好友
    function addFriend(address _friend)public onlyOwner {
        require(_friend != address(0), "Invalid address.");
        require(!registeredFriends[_friend], "Friend already registered.");
        
        registeredFriends[_friend] = true;//标记好友为已注册
        friendList.push(_friend);//好友列表添加好友
        
    }

    //存入ETH到钱包 payable意味着可以接收 ETH
    function depositIntoWallet() public payable onlyRegistered {
        require(msg.value > 0, "Must send ETH.");//必须发送>0的ETH
        balances[msg.sender] += msg.value;//金额将添加到调用者内部余额
    }

    //记录债务
    function recordDebt(address _debtor,uint256 _amount) public onlyRegistered {
        require(_debtor != address(0), "Invalid address.");
        require(registeredFriends[_debtor], "Address not registered.");//债务人必须是注册好友
        require(_amount > 0, "Amount must be greater than 0.");//债务金额必须大于0

        debts[_debtor][msg.sender] += _amount;//记录债务，债务人对记录者的债务增加
    }

    //从钱包支付债务,还款给债权人，支付金额不能超过债务金额，支付金额不能超过余额
    function  payFromWallet(address _creditor, uint256 _amount) public onlyRegistered {
        require(_creditor != address(0), "Invalid address."); 
        require(registeredFriends[_creditor], "Creditor not registered.");//债权人必须是注册好友
        require(_amount > 0, "Amount must be greater than 0.");//支付金额必须大于0
        require(debts[msg.sender][_creditor] >= _amount, "Debt amount incorrect.");//支付金额不能超过债务金额
        require(balances[msg.sender] >= _amount, "Insufficient balance.");//余额不足

        //减少支付者的余额
        balances[msg.sender] -= _amount;
        //增加债权人的余额
        balances[_creditor] += _amount;
        //债务减少
        debts[msg.sender][_creditor] -= _amount;

    }
    
    //改动1 注释掉此函数，改用transferEtherViaCall()函数实现转账功能，transfer目前编译会报错，已被官方标记为弃用：Warning: 'transfer' is deprecated and scheduled for removal. Use 'call{value: }("")' instead.
    // //转账ETH给好友，好友之间转账不涉及债务关系，只是简单的余额转移
    // function transferEther(address payable _to, uint256 _amount) public onlyRegistered {
    //     require(_to != address(0), "Invalid address.");
    //     require(registeredFriends[_to], "Recipient not registered.");//接收者必须是注册好友
    //     require(balances[msg.sender] >= _amount, "Insufficient balance.");//余额不足

    //     //减少发送者的余额
    //     balances[msg.sender] -= _amount;
    //     //transfer() 是一种内置的 Solidity 方法，用于将 ETH 从合约发送到外部地址。
    //     _to.transfer(_amount);
    //     //增加接收者的余额
    //     balances[_to] += _amount;
        
    // }

    //使用 call() 转账ETH给好友，call() 是一种更底层的 Solidity 方法，用于将 ETH 从合约发送到外部地址。相比 transfer()，call() 更灵活，可以指定更多的参数，但也需要更小心地处理返回值和错误。
    function transferEtherViaCall(address payable _to,uint256 _amount)public onlyRegistered {
        require(_to != address(0), "Invalid address.");
        require(registeredFriends[_to], "Recipient not registered.");//接收者必须是注册好友
        require(balances[msg.sender] >= _amount, "Insufficient balance.");//余额不足

        //减少发送者的余额
        balances[msg.sender] -= _amount;
        // 但使用 call 时务必先更新内部状态⬆，防止重入漏洞
        (bool success, ) = _to.call{value: _amount}("");
        // 改动2//增加接收者的余额 真实的ETH转帐成功了，钱包余额不应该增加，因为钱包余额是用户在合约中的内部记录，而不是实际的ETH余额。只有当用户从合约中提取ETH时，才会减少合约中的余额并增加用户的外部地址余额。因此，在使用call()转账后，不应该直接增加接收者的内部余额。
        // balances[_to] += _amount;
        require(success, "Transfer failed.");
        
    }

    //从钱包提取ETH
    function withdraw(uint256 _amount) public onlyRegistered {

        require(balances[msg.sender] >= _amount, "Insufficient balance.");//余额不足

        //减少用户的余额
        balances[msg.sender] -= _amount;
        //将ETH转回用户地址
        (bool success, ) = msg.sender.call{value: _amount}("");
        require(success, "Withdrawal failed.");
    }

    function checkBalance() public view onlyRegistered returns (uint256) {
        return balances[msg.sender];//返回调用者的余额
    }




}