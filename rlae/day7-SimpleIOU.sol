// SPDX-License-Identifier:MIT
pragma solidity ^0.8.0;
contract SimpleIOU{
    address public owner;
    mapping (address=>bool)public registeredFriend;
    address[] friendList;
    mapping (address=>uint256)public balance;
    mapping(address=>mapping(address=>uint256))public debts;// loop mapping to track who owe who how much debts;mapping(A->(B->howmuch));
    constructor(){
        owner=msg.sender;
        registeredFriend[msg.sender]=true;
        friendList.push(msg.sender);//automatically registered for who deploy the contract
    }
    modifier onlyowner(){
        require (msg.sender==owner,"only owner can do it"); 
        _;
    }
    modifier onlyregisteredFriend(){
        require (registeredFriend[msg.sender],"only registered member can perform action"); 
        _;        
    }
    function addFriends(address _members) public onlyowner{
        require(_members!=address(0),"invalid address");// _members is input and need to be valid
        require(!registeredFriend[_members],"member is already registered");
        registeredFriend[_members]=true;
        friendList.push(_members);
    }
    function depositEther()public payable onlyregisteredFriend{
    require(msg.value>0,"depoist money should >0");
    balance[msg.sender]+=msg.value; // use mapping for everyone's balance;

    }
    function recorddebts(address _debtor,uint256 _amount)public onlyregisteredFriend { //debtor owe me money of _amount
    require(_debtor!=address(0),"invalid address");
    require(_amount>0,"debet money should >0");
    require(registeredFriend[_debtor],"debet should from registed friend");
    debts[_debtor][msg.sender]+= _amount; // use mapping for everyone's debts;_debtor owe msg.sender
    }
    function payfromwallet(address _creditor, uint256 _amount) public onlyregisteredFriend{
    require(_creditor!=address(0),"invalid address");
    require(_amount>0,"credit money should >0");
    require(registeredFriend[_creditor],"credit should from registed friend");
    require(debts[msg.sender][_creditor]>=_amount,"debet amount is wrong"); // msg.sender owe creditor
    require(balance[msg.sender]>=_amount," money is not enough");
    balance[msg.sender]-=_amount;
    balance[_creditor]+=_amount;
    debts[msg.sender][_creditor]-=_amount;
    }
    function transferEtherviaCall(address payable _to,uint256 _amount)public onlyregisteredFriend{
    require(_to!=address(0),"invalid address");
    require(registeredFriend[_to],"recipient should from registed friend");
    require(balance[msg.sender]>=_amount," money is not enough");
    balance[msg.sender]-=_amount;
    (bool success,)=_to.call{value:_amount}("");// make success true once the call is successful
    balance[_to]+=_amount;
    require(success,"trasnfer failed");

    }
    function withdraw(uint256 _amount)public  onlyregisteredFriend{
    require(_amount>0,"withdraw money should >0");
    require(balance[msg.sender]>=_amount," money is not enough"); 
    balance[msg.sender]-=_amount;
    (bool success,)=payable(msg.sender).call{value:_amount}("");// make success true once the call is successful
    require(success,"trasnfer failed");
    }
    function getviewbalance()public onlyregisteredFriend view returns(uint256){
       return balance[msg.sender];
    }
}


