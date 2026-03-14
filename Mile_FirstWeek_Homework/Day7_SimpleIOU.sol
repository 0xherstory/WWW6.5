//声明开源许可证协议
//SPDX-License-Identifier:MIT

//声明使用的Solidity编译器版本
pragma solidity ^0.8.0;

//定义合约名字:SimpleIOU=简单借据管理系统
contract SimpleIOU {

    //--------状态变量-合约里永久保存的数据--------------

    //合约所有者(管理员)
    address public owner;

    //映射表:记录地址是否是注册朋友
    mapping(address => bool) public registeredFriends;

    //数组:存储所有朋友列表
    address[] public friendList;

    //映射表:记录每个朋友的钱包余额(内部记账)
    mapping(address => uint256) private balances;

    //嵌套映射:记录债务关系 debts[欠债人][债权人] = 金额
    //例如: debts[Alice][Bob] = 100 表示 Alice 欠 Bob 100 wei
    mapping(address => mapping(address => uint256)) public debts;

    //--------事件(记录行为，方便查看历史)--------------

    //事件:添加新朋友时触发
    event FriendAdded(address indexed friend);

    //事件:存款成功时触发
    event Deposited(address indexed user, uint256 amount);

    //事件:记录债务时触发
    event DebtRecorded(address indexed debtor, address indexed creditor, uint256 amount);

    //事件:偿还债务时触发
    event DebtPaid(address indexed payer, address indexed receiver, uint256 amount);

    //事件:转账成功时触发
    event EtherTransferred(address indexed from, address indexed to, uint256 amount);

    //事件:提款成功时触发
    event Withdrawn(address indexed user, uint256 amount);

    //--------修饰符(权限检查工具)--------------------

    //修饰符:只有所有者能调用
    modifier onlyOwner() {
        require(msg.sender == owner, "Not the owner");
        _;
    }

    //修饰符:只有注册朋友能调用
    modifier onlyRegistered() {
        require(registeredFriends[msg.sender], "Not registered");
        _;
    }

    //--------构造函数(部署合约时自动执行一次)-----------

    constructor() {
        //部署者自动成为所有者
        owner = msg.sender;
    }

    //--------管理员功能:朋友管理----------------------

    //添加新朋友 (只有所有者)
    function addFriend(address _friend) external onlyOwner {
        require(_friend != address(0), "Invalid address");
        require(!registeredFriends[_friend], "Already registered");

        registeredFriends[_friend] = true;
        friendList.push(_friend);

        emit FriendAdded(_friend);
    }

    //获取所有朋友列表
    function getFriendList() external view returns (address[] memory) {
        return friendList;
    }

    //--------核心功能:存款---------------------------

    //存入ETH到钱包 (发送ETH到合约时自动触发)
    receive() external payable onlyRegistered {
        balances[msg.sender] += msg.value;
        emit Deposited(msg.sender, msg.value);
    }

    //显式函数存入ETH (调用此函数并附带ETH)
    function depositIntoWallet() external payable onlyRegistered {
        require(msg.value > 0, "Must send ETH");
        balances[msg.sender] += msg.value;
        emit Deposited(msg.sender, msg.value);
    }

    //--------核心功能:债务管理-----------------------

    //记录债务 (谁欠谁多少钱)
    //调用者作为债权人，记录 Debtor 欠自己的钱
    function recordDebt(address _debtor, uint256 _amount) external onlyRegistered {
        require(_debtor != address(0), "Invalid address");
        require(_debtor != msg.sender, "Cannot owe yourself");
        require(registeredFriends[_debtor], "Debtor not registered");
        require(_amount > 0, "Amount must be positive");

        debts[_debtor][msg.sender] += _amount;

        emit DebtRecorded(_debtor, msg.sender, _amount);
    }

    //查询特定债务关系
    function getDebt(address _debtor, address _creditor) external view returns (uint256) {
        return debts[_debtor][_creditor];
    }

    //从钱包支付债务 (内部转账，不转出合约)
    //场景: A 欠 B 钱，A 用自己在合约里的余额还给 B
    function payFromWallet(address _creditor, uint256 _amount) external onlyRegistered {
        require(_creditor != address(0), "Invalid address");
        require(registeredFriends[_creditor], "Creditor not registered");
        require(_amount > 0, "Amount must be positive");
        
        //检查余额是否充足
        require(balances[msg.sender] >= _amount, "Insufficient balance in wallet");
        
        //检查是否有足够的债务记录
        require(debts[msg.sender][_creditor] >= _amount, "No debt or insufficient debt recorded");

        //--------生效 (先更新状态)--------
        balances[msg.sender] -= _amount;
        balances[_creditor] += _amount;
        debts[msg.sender][_creditor] -= _amount;

        emit DebtPaid(msg.sender, _creditor, _amount);
    }

    //--------核心功能:转账与提款---------------------

    //使用 call 转账给其他地址 (推荐方式)
    //场景: 用户想把合约里的余额转给任意地址 (甚至是非注册用户)
    function transferEtherViaCall(address payable _to, uint256 _amount) external onlyRegistered {
        require(_to != address(0), "Invalid address");
        require(_amount > 0, "Amount must be positive");
        require(balances[msg.sender] >= _amount, "Insufficient balance");

        //--------检查 - 生效 - 交互--------
        
        //1. 生效
        balances[msg.sender] -= _amount;

        //2. 交互
        (bool success, ) = _to.call{value: _amount}("");
        require(success, "Transfer failed");

        emit EtherTransferred(msg.sender, _to, _amount);
    }

    //提取余额到自己的钱包
    function withdraw(uint256 _amount) external onlyRegistered {
        require(_amount > 0, "Amount must be positive");
        require(balances[msg.sender] >= _amount, "Insufficient balance");
        require(address(this).balance >= _amount, "Contract insufficient funds");

        //--------检查 - 生效 - 交互--------
        
        //1. 生效
        balances[msg.sender] -= _amount;

        //2. 交互
        (bool success, ) = payable(msg.sender).call{value: _amount}("");
        require(success, "Withdraw failed");

        emit Withdrawn(msg.sender, _amount);
    }

    //--------查询功能---------------------------------

    //查询当前调用者的余额
    function getBalance() external view returns (uint256) {
        return balances[msg.sender];
    }

    //查询指定用户的余额
    function getBalanceOf(address _user) external view returns (uint256) {
        return balances[_user];
    }

    //查询合约总余额 (真实持有的ETH)
    function getTotalBalance() external view returns (uint256) {
        return address(this).balance;
    }
}