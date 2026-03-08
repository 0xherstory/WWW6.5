// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
 * @title EtherPiggyBank
 * @author mumu
 * @notice 提一个共享储蓄池,管理员可以添加成员,成员可以存入ETH并查看余额。
 * @dev 注意:这个简化版本只记录余额,没有实现真实的ETH提取功能(实际应用需要使用address.transfer()或address.call{value: amount}(""))。
 */

contract EtherPiggyBank{
    address public bankManager; // 银行管理员
    address[] members; // 成员列表
    mapping(address => bool) public registeredMemberMap; // 成员注册状态
    mapping(address => uint) balanceMap; // map: 成员-》用户余额；

    constructor(){
        bankManager = msg.sender; // 首次部署的用户为管理员
    }

    // managerOnly
    modifier managerOnly(){
        require(msg.sender == bankManager, "Not the bank manager");
        _;
    }

    // registeredMemberOnly
    modifier registeredMemberOnly(){
        require(registeredMemberMap[msg.sender], "Not a registered member");
        _;
    }

    // 添加成员
    function addMember(address _newMember) public managerOnly {
        require(!registeredMemberMap[_newMember], "Already exist"); 
        registeredMemberMap[_newMember] = true;
        members.push(_newMember);       
    }

    // 获取所有成员
    function getAllMembers() public view returns (address[] memory){
        return members;
    }

    // 用户进行存款（仅记账，没有真正交易
    function deposit(uint _amonut) public registeredMemberOnly {
        balanceMap[msg.sender] += _amonut;
    }

    // 真实存入ETH
    function depositAmountEther() public payable registeredMemberOnly{
        balanceMap[msg.sender] += msg.value;
    }

    // 用户提款(仅记账)
    function withdrawEther(uint _amount) public registeredMemberOnly{
        require(balanceMap[msg.sender] >= _amount, "Insufficient balance");
        balanceMap[msg.sender] -= _amount;
    }

    // 真是提取函数
    function withdrawAmountEther(uint _amount) public registeredMemberOnly{
        require(balanceMap[msg.sender] >= _amount, "Insufficient balance");
        balanceMap[msg.sender] -= _amount;

        (bool success, ) = payable(msg.sender).call{value: _amount}("");
        require(success, "Transfer failed");
    }

    // 获取调用者的余额
    function getBalance() public view registeredMemberOnly returns (uint){
        return balanceMap[msg.sender];
    }

    // 获取合约的总余额
    function getTotalBalance() public view managerOnly returns (uint){
        uint totalBalances = 0;
        for(uint i = 0; i < members.length; i++) {
            totalBalances += balanceMap[members[i]];
        }
        return totalBalances;
    }

    // 移除成员
    function removeMember(address _member) public managerOnly{
        require(registeredMemberMap[_member], "target member is not exist");
        registeredMemberMap[_member] = false;
    }

    // 添加事件记录存款和提取操作？ todo

}

/**
知识点：
1. 一个函数可以被多个modifier修饰，依次执行
2. payable 修饰符允许函数接受ETH；向非payable函数发送ETH，交易会失败
    constructor也可以被payable修饰。
3. address类型也有payable和non-payable之分
4. 使用payable时，最好使用msg.value
5. 转账的三种方式：
    transfer()	    2300 gas    自动revert	⭐⭐
    send()	        2300 gas	返回false	⭐
    call{value}()	所有gas	     返回bool	⭐⭐⭐⭐⭐。最推荐

5. ETH单位：
    1 ETH = 1,000,000,000,000,000,000 wei (10^18)
    1 ETH = 1,000,000,000 gwei (10^9) - gas价格常用单位（k m g）
    Solidity中可以使用:1 ether, 1 gwei, 1 wei
    msg.value始终是wei单位

5. 如果添加事件记录。
 */