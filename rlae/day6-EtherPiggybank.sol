// SPDX-License-Identifier:MIT
pragma solidity ^0.8.0;
contract EtherPiggybBank{
    address public bankmanager;
    address[]members;
    uint256 amount;
    mapping (address=>bool)public registeredmembers;
    mapping (address=>uint256)public balance;
    constructor(){
        bankmanager=msg.sender; 
        members.push(msg.sender); //only bankm can add people?
    }
    modifier onlybankmanager(){
        require (msg.sender==bankmanager,"only bank manager can do it"); 
        _;
    }
    modifier onlyregisteredmembers(){
        require (registeredmembers[msg.sender],"only registered member can withdarw"); 
        _;        
    }
    function addmembers(address _members) public onlybankmanager{
        require(_members!=address(0),"invalid address");// _members is input and need to be valid
        require(_members!=msg.sender,"manager is already a memeber");
        require(!registeredmembers[_members],"member is already registered");//registeredmembers[_members]==0 not the same, it is true or false
        registeredmembers[_members]=true;
        members.push(_members);
    }
    function getviewmembers()public view returns(address[]memory){
       return members;
    }
    function deposit(uint256 _amount)public onlyregisteredmembers{
        require(_amount>0,"depoist money should >0");
        balance[msg.sender]+=_amount; // use mapping for everyone's balance;

    }
    function withdraw(uint256 _amount)public onlyregisteredmembers{
    require(_amount>0,"withdraw money should >0");
    require(_amount<=balance[msg.sender],"not enought money");
    balance[msg.sender]-=_amount; 
    }
    function depositEther()public payable  onlyregisteredmembers{
    require(msg.value>0,"depoist money should >0");
    balance[msg.sender]+=msg.value; // use mapping for everyone's balance;

    }
    function withdrawEther()public payable onlyregisteredmembers{
    require(msg.value>0,"withdraw money should >0");
    require(msg.value<=balance[msg.sender],"not enought money");
    balance[msg.sender]-=msg.value; //

    }
}