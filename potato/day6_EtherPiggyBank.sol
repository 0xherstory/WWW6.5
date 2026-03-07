// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract EtherPiggyBank {
    address public bankManager;  
    address[] members;  
    mapping(address => bool) public registeredMembers;  
    mapping(address => uint256) balance;  
    
    constructor() {
        bankManager = msg.sender;
    }
    
    // 修饰符:只有管理员
    modifier onlyBankManager() {
        // 1. 检查当前调用者是否是管理员。用哪个全局变量代表当前调用者？
        require(msg.sender == bankManager, "Not the bank manager");
        _;
    }
    
    // 修饰符:只有注册成员
    modifier onlyRegisteredMember() {
        // 2. 从映射中检查当前调用者是否已注册。填入代表当前调用者的变量。
        require(registeredMembers[msg.sender], "Not a registered member");
        _;
    }
    
    // 添加成员(只有管理员)
    function addMembers(address _member) public onlyBankManager {
        require(!registeredMembers[_member], "Already registered");
        registeredMembers[_member] = true;
        // 3. 将新成员的地址追加到数组成员列表中，数组的追加方法是什么？
        members.push(_member);
    }
    
    // 获取所有成员
    function getMembers() public view returns (address[] memory) {
        return members;
    }
    
    // 记录存款(不真实转ETH,仅记账)
    function deposit(uint256 _amount) public onlyRegisteredMember {
        balance[msg.sender] += _amount;
    }
    
    // 真实存入ETH
    // 4. 想要真实接收以太坊，必须在函数声明中加上哪个“收款码”关键字？
    function depositAmountEther() public payable onlyRegisteredMember {
        // 5. 记录用户打进来的真实 ETH 数量。代表随交易发送的真实金额的全局变量是什么？
        balance[msg.sender] += msg.value;
    }
    
    // 提取(仅记账,不真实转ETH)
    function withdraw(uint256 _amount) public onlyRegisteredMember {
        // 6. 提款前的条件检查：确保余额 大于或等于 提取金额（填入比较运算符）
        require(balance[msg.sender] >= _amount, "Insufficient balance");
        balance[msg.sender] -= _amount;
    }

    
    

    // 目标：编写一个名为 getMyBalance 的函数（让普通成员查看自己的当前余额）
    // 指南：
    // a. 函数可见性应设为 public view。
    // b. 必须挂载修饰符，确保只有“注册成员”能调用它。
    // c. 函数不需要接收任何参数。
    // d. 函数需要返回 (returns) 一个 uint256 类型的值。
    // e. 在函数体内，从 balance 映射中查出并返回当前调用者的余额。
    
    function getMyBalance() public view onlyRegisteredMember returns (uint256) {
        return balance[msg.sender];
    } // public view: 只读不写，免费
}