// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
contract simpleIOU{
    address public owner;
    mapping(address=>bool) public registeredFriends;
    address[] public friendList;
    mapping (address=>uint256) public balances;
    mapping (address=>mapping (address=>uint256) )public debts;

    constructor(){
        owner=msg.sender;
        registeredFriends[msg.sender]=true;
        friendList.push(msg.sender);
    }

    modifier onlyOwner(){
        require(msg.sender==owner,"Only the owner can call this function");
        _;
    }
    modifier onlyRegistered(){
        require(registeredFriends[msg.sender],"You're not registered");
        _;
    }

    function addFriend(address _friend)public onlyOwner{
        require(_friend!=address(0),"Invalid Address");//!registeredFriends[_friend]
        registeredFriends[_friend]=true;
        friendList.push(_friend);
    }
    function depositIntoWallet()public payable onlyRegistered{
        require(balances[msg.sender]>0,"Must enter a valid amount");
        balances[msg.sender] +=msg.value;
    }
    function recordDebt(address _debtor, uint256 _amount)public onlyRegistered{
        require(_debtor!=address(0),"Invalid address");
        require(registeredFriends[_debtor],"Address is not registered");
        require(_amount>0,"Must enter a valid number");
        debts[_debtor][msg.sender]+=_amount;
    }
    function payFromWallet(address _creditor, uint256 _amount)public onlyRegistered{
        require(_creditor!=address(0),"Invalid address");
        require(!registeredFriends[_creditor],"Address is already taken");
        require(_amount>0,"Must be greater than 0");
        require(debts[msg.sender][_creditor]>=_amount,"Debt amount is incorrect");
        require(balances[msg.sender]>=_amount,"Insufficient balance");
        balances[msg.sender]-=_amount;
        balances[_creditor]+=_amount;
        debts[msg.sender][_creditor]-=_amount;
    }
    function transferEther(address payable _to, uint256 _amount)public onlyRegistered{
        require(_to !=address(0),"Invalid address");
        require(registeredFriends[_to],"Reciepient is not registered");
        require(balances[msg.sender]>=_amount,"Insufficient balance");
        balances[msg.sender]-=_amount;
        _to.transfer(_amount);
    }
    function transferEtherViaCall(address payable _to, uint256 _amount)public onlyRegistered{
        require(_to !=address(0),"Invalid address");
        require(registeredFriends[_to],"Reciepient is not registered");
        require(balances[msg.sender]>=_amount,"Insufficient balance");
        balances[msg.sender]-=_amount;
        (bool success,)=_to.call{value:_amount}("");
        require(success,"Failed to transfer Ether");
    }
    function withdraw(uint256 _amount) public onlyRegistered{
        require(balances[msg.sender]>=_amount,"Insufficient balance");
        balances[msg.sender] -= _amount;
        (bool success, ) = payable(msg.sender).call{value: _amount}("");
        require(success,"Failed to withdraw");
    }
    function checkBalance()public view onlyRegistered returns(uint256) {
        return balances[msg.sender];
    }
}

//0x5B38Da6a701c568545dCfcB03FcB875f56beddC4
//friend:0x78731D3Ca6b7E34aC0F824c42a7cC18A495cabaB
