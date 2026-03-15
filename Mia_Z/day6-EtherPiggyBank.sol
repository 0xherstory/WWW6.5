//SPDX-License-Identifier:MIT
pragma solidity ^0.8.0;


contract EtherPiggyBank{

    address public bankManager;

    address[] members;
    mapping(address =>bool) public registerMembers;
    mapping(address =>uint256) balance;

    constructor(){
        bankManager = msg.sender;
        members.push(msg.sender);

    }

    modifier onlyRegisteredMember(){
        require(registerMembers[msg.sender], "Only registered members can perform this action");
        _;
    }

    modifier onlyBankManager(){
        require(msg.sender == bankManager, "Only bank manager can perform this action");
        _;
    }
    //添加新成员
    function addMembers(address _member) public onlyBankManager {
        
        require(_member != address(0), "Invalid member address");
        require(_member != msg.sender, "Bank manager Already as a member");
        require(!registerMembers [_member], "Member already registered");
        registerMembers [_member] = true;
        members.push(_member);

    }

    //查看成员列表
    function getMembers() public view returns (address[] memory){
        return members;
    }

    //存款
    function depositAmountEther() public payable onlyRegisteredMember {
        require(msg.value > 0, "Invalid deposit amount");
        balance[msg.sender] += msg.value;
    }
    /** 
    function deposit() public onlyRegisteredMember {
        require(_amount > 0, "Invalid deposit amount");
        balance[msg.sender] += _amount;
    }
    */
    //取款
    function withdraw(uint256 _amount) public onlyRegisteredMember {
        require(_amount > 0, "Invalid withdrawal amount");
        require(balance[msg.sender] >= _amount, "Insufficient balance");
        balance[msg.sender] -= _amount;
    }
    
}

