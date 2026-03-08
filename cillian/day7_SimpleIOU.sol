//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

//此合约用于朋友之间记账，还钱

contract SimpleIOU {

    address public owner;
    
    mapping(address => bool) public registeredFriends; //是否注册
    address[] public friendList; //成员列表

    mapping(address => uint256) public balances; //账户余额
    mapping(address => mapping(address => uint256)) public debts; // 嵌套映射（Nested Mapping），债务人=>债权人=>债务金额
    
    //构建管理员，并加入成员列表
    constructor() {
        owner = msg.sender;
        registeredFriends[msg.sender] = true;
        friendList.push(msg.sender);
    }
        //管理员权限
        modifier onlyOwner(){
            require(msg.sender == owner, "Only owner can perform this action.");
            _;
        }

        //成员权限
        modifier onlyRegistered(){
            require(registeredFriends[msg.sender], "Only registered friends can perform this action");
            _;
        }

        //添加成员
        function addFriend(address _friend) public onlyOwner {
            require(address(_friend) != address(0), "Invalid address");
            require(!registeredFriends[_friend], "Friend already registered");

            registeredFriends[_friend] = true;
            friendList.push(_friend);
        }

        //存钱进钱包
        function depositIntoWallet() public payable onlyRegistered {
            require(msg.value > 0, "Invalid amount");

            balances[msg.sender] += msg.value;
        }

        //债权人记录债务
        function recordDebt(address _debtor, uint256 _amount) public onlyRegistered {
            require(_amount > 0, "Invalid amount");
            require(registeredFriends[_debtor],"Debtor not registered");

            debts[_debtor][msg.sender] += _amount;
        }

        //内部转账还债
        function payFromWallet(address _creditor, uint256 _amount) public onlyRegistered {
            require(address(_creditor) != address(0), "Invalid address");
            require(_amount > 0, "Invalid amount");
            require(balances[msg.sender] >= _amount, "Insufficient balance");
            require(registeredFriends[_creditor], "Creditor not registered");
            require(debts[msg.sender][_creditor] >= _amount, "Debt amount incorrect");

            balances[msg.sender] -= _amount;
            balances[_creditor] += _amount;
            debts[msg.sender][_creditor] -= _amount;
        }

        //传统转账还债（.transfer，固定2300gas限制）
        function transferEther(address payable _to, uint256 _amount) public onlyRegistered { //用to表示物理路径，需要把地址包装为可收钱的payable,在solidity的转账工具中经常使用to和from
            require(_to != address(0), "Invalid address");
            require(registeredFriends[_to], "Recipient not registered");
            require(balances[msg.sender] >= _amount, "Insufficient balance");
            
            balances[msg.sender] -= _amount;
            debts[msg.sender][_to] -= _amount;
            _to.transfer(_amount); //失败则会回滚（revert）
            // balances[_to] += _amount; 
        }

        //底层转账还债（.call，转发所有可用gas）
        function transferEtherViaCall(address payable _to, uint256 _amount) public onlyRegistered {
            require(_to != address(0), "Invalid address");
            require(registeredFriends[_to], "Recipient not registered");
            require(balances[msg.sender] >= _amount, "Insufficient balance");

            balances[msg.sender] -= _amount;
            debts[msg.sender][_to] -= _amount;
            (bool success,) = _to.call{value: _amount}(""); //call返回bool值给success变量，用于检验转账是否成功，这里省略了“，”后的返回数据，和函数签名（“”）
            require(success, "Transfer failed"); //失败则会回滚（revert）
            // balances[_to] += _amount;
        }
        
        //从合约账户取钱
        function withdraw(uint256 _amount) public onlyRegistered{
            require(_amount > 0, "Invalid amount");
            require(balances[msg.sender] >= _amount, "Insufficient balance");

            balances[msg.sender] -= _amount;
            (bool success, ) = payable(msg.sender).call{value: _amount}(""); //msg.sender为地址，需要包装成payable才可以收款
            require(success, "Withdraw failed");
        }

        //查看合约账户余额
        function checkBalance() public view onlyRegistered returns (uint256) {
        return balances[msg.sender];
        }

}



