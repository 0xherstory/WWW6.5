//声明开源许可证协议
//SPDX-License-Identifier:MIT

//声明使用的Solidity编译器版本
pragma solidity ^0.8.0;

//定义合约名字:AdminOnly=管理员权限控制合约
contract AdminOnly {

    //--------状态变量-------------------

    //合约拥有者(部署者，唯一的管理员)
    address public owner;

    //宝藏总量(合约里的资金池)
    uint256 public treasureAmount;

    //映射表:记录每个地址的提取额度
    mapping(address => uint256) public withdrawalAllowance;

    //映射表:记录地址是否已提取过(true=已提，false=未提)
    mapping(address => bool) public hasWithdrawn;

    //映射表:记录地址是否是注册用户
    mapping(address => bool) public isRegisteredUser;

    //--------事件-----------------------

    //事件:用户注册成功
    event UserRegistered(address indexed user);

    //事件:添加宝藏
    event TreasureAdded(uint256 amount, address indexed by);

    //事件:用户提取宝藏
    event Withdrawn(address indexed user, uint256 amount);

    //--------修饰符---------------------

    //修饰符:只有所有者能调用
    modifier onlyOwner() {
        require(msg.sender == owner, "Not owner");
        _;
    }

    //修饰符:只有注册用户能调用
    modifier onlyRegisteredUser() {
        require(isRegisteredUser[msg.sender], "User not registered");
        _;
    }

    //--------构造函数-------------------

    constructor() {
        //部署者自动成为所有者
        owner = msg.sender;
    }

    //--------管理员功能-----------------

    //注册新用户 (只有管理员能操作)
    function registerUser(address user) external onlyOwner {
        require(user != address(0), "Invalid address");
        require(!isRegisteredUser[user], "User already registered");

        isRegisteredUser[user] = true;
        emit UserRegistered(user);
    }

    //添加宝藏到池子 (只有管理员能操作)
    function addTreasure(uint256 amount) external onlyOwner {
        require(amount > 0, "Amount must be positive");
        
        treasureAmount += amount;
        emit TreasureAdded(amount, msg.sender);
    }

    //批准用户的提取额度 (只有管理员能操作)
    function approveWithdrawal(address recipient, uint256 amount) external onlyOwner {
        require(recipient != address(0), "Invalid address");
        require(isRegisteredUser[recipient], "User not registered");

        withdrawalAllowance[recipient] = amount;
    }

    //--------核心功能:提取--------------

    //提取宝藏 (只有注册用户，且有额度，且未提取过)
    function withdrawTreasure(uint256 amount) external onlyRegisteredUser {
        require(amount > 0, "Amount must be positive");
        require(amount <= withdrawalAllowance[msg.sender], "Insufficient allowance");
        require(!hasWithdrawn[msg.sender], "Already withdrawn");

        //1. 生效: 更新状态
        hasWithdrawn[msg.sender] = true;
        withdrawalAllowance[msg.sender] = 0; // 清空额度
        
        //注意：此处仅为逻辑演示，实际转账ETH需添加 transfer 代码
        // payable(msg.sender).transfer(amount); 
        // 为了符合教程核心逻辑，这里主要展示权限控制和状态变更

        emit Withdrawn(msg.sender, amount);
    }

    //--------查询功能-------------------

    //查看用户综合状态
    function getUserStatus(address user) external view returns (bool isReg, bool hasWd, uint256 allow) {
        return (isRegisteredUser[user], hasWithdrawn[user], withdrawalAllowance[user]);
    }
}