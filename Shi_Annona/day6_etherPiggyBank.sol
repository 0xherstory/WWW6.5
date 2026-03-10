//SPDX-License-Identifier:MIT
pragma solidity ^0.8.0;

//day6_etherPiggyBank.sol
//attention: I don't need a pair of parentheses
contract EtherPiggyBank{

    //We need: a bank manager, members, the balance of members, the status of register
    address public bankManager;
    address[] public members;
    mapping(address => uint256) balance;
    mapping (address => bool) registeredMember;

    constructor(){
        bankManager = msg.sender;
        //bank manager is one of the members
        members.push(bankManager);
        //don't forget the status of register
        registeredMember[ msg.sender] = true;
    }

    //limits of authority, use [modifier]
    modifier onlyBankManager(){
        require(msg.sender == bankManager,"Only bank manger can perform this action");
        _;
    }
       
    modifier onlyRegisteredMemerbs(){
        require(registeredMember[msg.sender],"Member not registered");
        _;
    }

    //add members only bank manager
    function addMembers(address _member) public onlyBankManager(){
        //check invalid address, already registered, bank manager
        require(_member != address(0), "Invalid address!");
        require(!registeredMember[_member],"already registered");
        require(_member != bankManager,"bank manager is already a member");

        members.push(_member);
        registeredMember[_member] = true;
    }

    //deposit real ether
    //Q:why it don't have any parameters in the parentheses after "depositEtherAmount"?
    //A:when it is a payable function, it don't need a parameter, cause users interact the contract through a wallet like MetaMask which has a "Value" textBox. Payable function get the amount from this "Value" textBox. 
    function depositEtherAmount() public payable onlyRegisteredMemerbs(){
        //check
        require(msg.value > 0, "Invalid amount");
        balance[msg.sender] = balance[msg.sender] + msg.value;
    }

    //withdraw amount(still munber game not real transation)
    function WithdrawAmount(uint256 _amount) public onlyRegisteredMemerbs(){
        //check the address
        require(registeredMember[msg.sender],"only registered member can perform this action");
        //check the amount
        require(_amount > 0,"Invalid amount");
        //check the deposit
        require(_amount <= balance[msg.sender],"Insufficient deposit" );

        balance[msg.sender] = balance[msg.sender] - _amount;
    }

    function getBalanceAmount(address _members) public view returns(uint256){
        require(_members != address(0),"Invalid address");
        return balance[_members];
    }

    //get members
    function getMembers() public view returns(address[] memory){
        return members;
    }

}


//0x5B38Da6a701c568545dCfcB03FcB875f56beddC4 -> bank manager
//0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2 -> member