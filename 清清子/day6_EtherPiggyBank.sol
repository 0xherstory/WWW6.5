//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract EtherPiggyBank{

    //there should be a bank manager who has the certain permissions
    //there should be an array for all members registered and a mapping whther they are registered or not
    //a mapping with there balances
    address public bankManager;//是部署合约的人。他拥有管理员权限——只有他可以批准新成员加入俱乐部。
    address[] members;//一个数组，用来保存所有加入的人。
    mapping(address => bool) public registeredMembers;//一个映射，可以让我们快速检查某人是否已被批准
    mapping(address => uint256) balance;//需要知道每位成员在这段时间里一共存了多少钱。

    constructor(){
        bankManager = msg.sender;
        members.push(msg.sender);//会把部署者加入 members 列表——所以他就是第一个存钱的人
    }

//在编写具体功能之前，我们要明确每个人能做什么。

    modifier onlyBankManager(){//这个修饰符确保只有经理可以调用某些函数——例如，添加新成员。
        require(msg.sender == bankManager, "Only bank manager can perform this action");
        _;
    }

    modifier onlyRegisteredMember() {//这个修饰符确保只有已被正式添加入列表的成员可以存钱或取钱。
        require(registeredMembers[msg.sender], "Member not registered");
        _;
    }
  
  //我们要检查：地址是否有效;经理没有重复添加自己;该成员是否已经存在.一切无误后，就可以批准这名新成员加入。
    function addMembers(address _member)public onlyBankManager{
        require(_member != address(0), "Invalid address");
        require(_member != msg.sender, "Bank Manager is already a member");
        require(!registeredMembers[_member], "Member already registered");
        registeredMembers[_member] = true;
        members.push(_member);
    }

//假设有人想看看当前小组里都有谁，或许是想确认自己是否已被添加
    function getMembers() public view returns(address[] memory){
        return members;
    }
    //deposit amount 
    // function depositAmount(uint256 _amount) public onlyRegisteredMember{
    //     require(_amount > 0, "Invalid amount");
    //     balance[msg.sender] = balance[msg.sender]+_amount;
   
    // }
    
    //deposit in Ether
    //这个函数：确保存入金额大于零;将该金额加到你的余额中
    function depositAmountEther() public payable onlyRegisteredMember{  
        require(msg.value > 0, "Invalid amount");
        balance[msg.sender] = balance[msg.sender]+msg.value;
   
    }
    
    //取钱（模拟）.我们要检查：金额是否有效,余额是否足够,最后把取的钱从你的余额里扣掉.
    function withdrawAmount(uint256 _amount) public onlyRegisteredMember{
        require(_amount > 0, "Invalid amount");
        require(balance[msg.sender] >= _amount, "Insufficient balance");
        balance[msg.sender] = balance[msg.sender]-_amount;
   
    }

    function getBalance(address _member) public view returns (uint256){
        require(_member != address(0), "Invalid address");
        return balance[_member];
    } 

}