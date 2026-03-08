// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract CunQianGuan{
    address public bankManager;//部署合约的人，有管理员权限
    address[] members;//数组，用来保存所有加入的人
    mapping(address => bool) public registeredMembers;//映射，快速检查某人是否已被批准
    mapping(address => uint256)balance;//每个成员存了多少钱


        //用修饰符定义经理和已被批准的成员：
        modifier onlyBankManager(){
            require(msg.sender == bankManager, "Only bankManager can perform this action.");
            _;
        }
        
        modifier onlyRegisteredMember(){
            require(registeredMembers[msg.sender], "Member have not registered.");
            _;
        }


// 3. 构造函数（仅初始化，不嵌套任何函数）
    constructor() {
        bankManager = msg.sender;
        // 修正逻辑：添加经理到成员列表时，同步更新映射
        registeredMembers[msg.sender] = true;
        members.push(msg.sender);
    }


        //添加新成员：
        function addMember(address _member) public onlyBankManager{
            require(_member != address(0), "Invalid address");//地址是否有效呢？
            require(_member != msg.sender, "BankManager is already a member.");//经理是否重复添加自己？
            require(!registeredMembers[_member], "Member already registered");//该成员是否已经存在？

            registeredMembers[_member] = true;
            members.push(_member);//批准该成员加入

        }

        //查看成员列表：
        function gerMembers() public view returns(address[] memory){
            return members;
        }

        //模拟存款过程：
        function deposit(uint256 _amount) public onlyRegisteredMember{
            require(_amount > 0, "Invalid amount");
            balance[msg.sender] += _amount;
        }
        //模拟取钱过程：
        function withdraw(uint256 _amount) public onlyRegisteredMember{
            require(_amount > 0, "Invalid amount");
            require(balance[msg.sender] >= _amount, "Insufficient balance");
            balance[msg.sender] -= _amount;
        }

        //存真正的以太币啦
        function depositAmountEther() public payable onlyRegisteredMember{
            require(msg.value > 0, "Invalid amount");//payable：该函数可以接受以太币
            balance[msg.sender] += msg.value;//msg.value：用户在交易中发送的以太币数量哦
        }
    }
