//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract EtherPiggyBank {

    address public bankManager;
    address[] internal members; //默认为internal, 只有内部（此合约和子合约）能访问
    mapping(address => bool) public registeredMembers; //判断是否为成员
    mapping(address => uint256) internal balance; //用户钱包
    

    //构建银行管理者,并加入成员列表
    constructor() {
        bankManager = msg.sender;
        members.push(msg.sender);
        registeredMembers[msg.sender] = true;
    }

    //银行管理者权限
    modifier onlyBankManager() {
        require(msg.sender == bankManager, "Only bank manager can perform this action.");
        _;
    } 

    //成员权限
    modifier onlyRegisteredMember() {
        require(registeredMembers[msg.sender], "Only bank members can perform this action.");
        _;
    }

    //添加成员（条件：仅限管理者，成员地址不为黑洞，成员不在成员列表中）
    function addMembers(address _member) public onlyBankManager{
        require(address(_member) != address(0), "Invalid address");
        require(!registeredMembers[_member], "Member is already registered.");
        registeredMembers[_member] = true;
        members.push(_member);
    }

    //获取成员列表
    function getMembers() public view returns(address[] memory) {
        return members;
    }

    //存钱（仅限成员）
    function depositAmountEther() public payable onlyRegisteredMember { //payable为“允许支付”的关键字，用户在发起交易时，将金额放入交易的 Value 字段
        require(msg.value > 0, "You need to send some ETH"); // msg.value 可以获取用户发送了多少 ETH
        balance[msg.sender] += msg.value;
    }

    //取钱（仅限成员）
    function withdrawAmount(uint256 _amount) public onlyRegisteredMember {
        require(balance[msg.sender] >= _amount, "No enough balance");
        require(_amount > 0, "Invalid amount");
        balance[msg.sender] -= _amount;

        // 补充以下，钱才会真的打回到用户的钱包里！
        //(bool success, ) = payable(msg.sender).call{value: _amount}("");
        //require(success, "Transfer failed");
    }

    //查看余额
    function getBalance(address _member) public view returns(uint256) {
        require(registeredMembers[_member], "Member doesn't exist.");
        return balance[_member];
    }

}