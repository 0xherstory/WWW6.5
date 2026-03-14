//声明开源许可证协议
//SPDX-License-Identifier:MIT

//声明使用的Solidity编译器版本
pragma solidity ^0.8.0;

//定义合约名字:EtherPiggyBank=以太储蓄罐
contract EtherPiggyBank {

    //--------状态变量-------------------

    //银行管理员(部署者)
    address public bankManager;

    //成员列表
    address[] public members;

    //映射表:记录地址是否已注册
    mapping(address => bool) public registeredMembers;

    //映射表:记录每个成员的余额
    mapping(address => uint256) public balances;

    //--------事件-----------------------

    //事件:成员添加
    event MemberAdded(address indexed member);

    //事件:存款记录
    event Deposited(address indexed member, uint256 amount);

    //事件:提款记录
    event Withdrawn(address indexed member, uint256 amount);

    //--------修饰符---------------------

    //修饰符:只有管理员
    modifier onlyBankManager() {
        require(msg.sender == bankManager, "Not the bank manager");
        _;
    }

    //修饰符:只有注册成员
    modifier onlyRegisteredMember() {
        require(registeredMembers[msg.sender], "Not a registered member");
        _;
    }

    //--------构造函数-------------------

    constructor() {
        //部署者自动成为管理员
        bankManager = msg.sender;
    }

    //--------管理员功能-----------------

    //添加成员 (只有管理员)
    function addMembers(address _member) external onlyBankManager {
        require(!registeredMembers[_member], "Already registered");
        
        registeredMembers[_member] = true;
        members.push(_member);
        
        emit MemberAdded(_member);
    }

    //获取所有成员列表
    function getMembers() external view returns (address[] memory) {
        return members;
    }

    //--------核心功能:存款--------------

    //记录存款 (仅内部记账，不接收真实ETH)
    function deposit(uint256 _amount) external onlyRegisteredMember {
        require(_amount > 0, "Amount must be positive");
        
        balances[msg.sender] += _amount;
        
        emit Deposited(msg.sender, _amount);
    }

    //真实存入ETH (发送ETH到合约时自动触发)
    receive() external payable onlyRegisteredMember {
        balances[msg.sender] += msg.value;
        emit Deposited(msg.sender, msg.value);
    }

    //显式函数存入ETH (调用函数并附带ETH)
    function depositAmountEther() external payable onlyRegisteredMember {
        require(msg.value > 0, "Must send ETH");
        
        balances[msg.sender] += msg.value;
        
        emit Deposited(msg.sender, msg.value);
    }

    //--------核心功能:提款--------------

    //内部记账提款 (仅扣减余额，不转ETH)
    function withdraw(uint256 _amount) external onlyRegisteredMember {
        require(_amount > 0, "Amount must be positive");
        require(balances[msg.sender] >= _amount, "Insufficient balance");

        balances[msg.sender] -= _amount;
        //注意：这里只是记账减少，钱还在合约里
    }

    //真实提取ETH (将合约里的ETH转给用户)
    function withdrawEther(uint256 _amount) external onlyRegisteredMember {
        require(_amount > 0, "Amount must be positive");
        require(balances[msg.sender] >= _amount, "Insufficient balance");
        require(address(this).balance >= _amount, "Contract has insufficient funds");

        //1. 生效: 先更新状态 (防止重入攻击)
        balances[msg.sender] -= _amount;

        //2. 交互: 再进行转账 (使用安全的call方式)
        (bool success, ) = payable(msg.sender).call{value: _amount}("");
        require(success, "Transfer failed");

        emit Withdrawn(msg.sender, _amount);
    }

    //--------查询功能-------------------

    //查看当前调用者的余额
    function getBalance() external view returns (uint256) {
        return balances[msg.sender];
    }

    //查看合约总余额 (真实持有的ETH)
    function getTotalBalance() external view returns (uint256) {
        return address(this).balance;
    }
}