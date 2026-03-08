// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
contract EtherPiggyBank{
    address public bankManager;
    address[] members;
    mapping (address=>bool) public registerMembers;
    mapping (address=>uint256) balance;
    constructor(){
        bankManager=msg.sender;
        members.push(msg.sender);
    }
    modifier onlyBankManager(){
        require(bankManager==msg.sender,"Only bank manager can perform this action");
        _;
    }
    modifier onlyRegisteredMember(){
        require(registerMembers[msg.sender],"Member is not registered");
        _;}

    function addMembers(address _member) public onlyBankManager{
        require(_member!=address(0),"Invalid address");
        require(_member!=msg.sender,"Bank manager is already a member");
        require(!registerMembers[_member],"Member is already registered");
        registerMembers[_member]=true;
        members.push(_member);
    }
    function getMembers()public view returns (address[] memory){
        return members;
    }
    function depositAmount(uint256 _amount)public onlyRegisteredMember{
        require(_amount>0,"Invalid amount");
        balance[msg.sender]+=_amount;
        //balance[msg.sender]=balance[msg.sender]+_amount;

    }
    function depositEther(uint256 _amount)public payable onlyRegisteredMember{
        require(_amount>0,"Invalid amount");
        balance[msg.sender]+=msg.value;
    }
    function withdraw(uint256 _amount) public onlyRegisteredMember{
        require(_amount>0,"Invalid amount");
        require(balance[msg.sender]>=_amount,"Insufficient funds");
        balance[msg.sender]-=_amount;
    }
    function getBalance(address _member)public view returns(uint256){
        require(_member!=address(0),"Invalid address");
        return balance[msg.sender];
    }
}


// address 1:0x03C6FcED478cBbC9a4FAB34eF9f40767739D1Ff7
// address 2:0x5c6B0f7Bf3E7ce046039Bd8FABdfD3f9F5021678
// address 3:0x1aE0EA34a72D944a8C7603FfB3eC30a6669E454C