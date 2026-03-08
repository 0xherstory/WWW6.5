//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleIOUApp{

    //we need: owner, a list of firends, balance, debts, registered
    address public owner;
    address[] public friends;

    mapping(address => bool) public registeredFirends;
    mapping(address => uint256) public balance;
    mapping(address => mapping(address=>uint256)) debt;

    constructor(){
        owner = msg.sender;
        //don't forget add the owner into the firends list
        friends.push(msg.sender);
        registeredFirends[msg.sender] = true;
    }

    //limit of authority
    modifier onlyOwner(){
        require(msg.sender == owner, "only owner can perform this action");
        _;
    }

    modifier onlyRegisteredFirends(){
        require(registeredFirends[msg.sender],"you are not regitered");
        _;
    }

    //add firends
    function addFirends(address _user) public onlyOwner(){
        //check the address
        require(_user != address(0), "Invalid address");
        //check the status of register
        require(!registeredFirends[_user],"already registered");

        friends.push(_user);
        registeredFirends[_user] = true;
    }

    //deposit real Ether
    function depositEther() public payable onlyRegisteredFirends(){
        require(msg.value > 0,"Invalid amount, must send ETH");
        balance[msg.sender] +=  msg.value; //this contract get the ETH
    }

    //record debts
    function recordDebts(address _debtor, uint256 _amount) public onlyRegisteredFirends(){
        //check address
        require(_debtor != address(0), "invalid address");
        require(registeredFirends[_debtor], "setor is not registered");
        require(_debtor != msg.sender, "you can't record the debts to your self");//it occurs me to prevent from this wrong operation!
        //check amount
        require(_amount > 0, "invalid amount");

        
        //record
        debt[_debtor][msg.sender] += _amount;
    }

    //pay the debt using  contrat interal balance
    function payViaBalance(address _creditor, uint256 _amount) public onlyRegisteredFirends(){
        //check address
        require(_creditor != address(0), "invalid address");
        require(registeredFirends[_creditor], "setor is not registered");
        //check amount
        require(_amount > 0, "invalid amount");
        //check the amount is less than the debt
        require(debt[msg.sender][_creditor]>=_amount,"incorrect amount");
        //check the balance is sufficient
        require(balance[msg.sender] > _amount, "insufficient balance");

        //update balance
        balance[msg.sender] -= _amount;
        balance[_creditor] += _amount;

        //update debts
        debt[msg.sender][_creditor] -= _amount;

    }

    //pay the debts via [transfer()] a new function! a built-in function!
    function transferEther(address payable _creditor, uint256 _amount) public onlyRegisteredFirends(){
        //check address
        require(_creditor != address(0), "invalid address");
        require(registeredFirends[_creditor], "recipient is not registered");
        //check amount
        require(_amount > 0, "invalid amount");
        //check the amount is less than the debt
        require(debt[msg.sender][_creditor]>=_amount,"incorrect amount");
        //check the balance is sufficient
        require(balance[msg.sender] > _amount, "insufficient balance");

        //update debts
        debt[msg.sender][_creditor] -= _amount; 
        //update balance
        balance[msg.sender] -= _amount;
        balance[_creditor] += _amount; //

        //_creditor get the real ETH
        _creditor.transfer(_amount); 
    }

    //pay the debts via [call()] a new function! a built-in function，more basic compared with transfer()!
    function payEtherViaCall(address payable _creditor, uint256 _amount)public onlyRegisteredFirends(){
        //check address
        require(_creditor != address(0), "invalid address");
        require(registeredFirends[_creditor], "recipient is not registered");
        //check amount
        require(_amount > 0, "invalid amount");
        //check the amount is less than the debt
        require(debt[msg.sender][_creditor]>=_amount,"incorrect amount");
        //check the balance is sufficient
        require(balance[msg.sender] > _amount, "insufficient balance");

        (bool success,) = _creditor.call{value:_amount}("");
        require(success, "Transferfailed");
        //update debts
        debt[msg.sender][_creditor] -= _amount; 
        //update balance
        balance[msg.sender] -= _amount;
        balance[_creditor] += _amount;

    }

    //withdraw balance(the reak ETH) 
    function withdraw(uint _amount) public onlyRegisteredFirends(){
        //check the amount
        require(_amount > 0, "invalid amount");
        require(balance[msg.sender] >= _amount,"insufficient balance");

        (bool success,) = payable(msg.sender).call{value:_amount}(""); //payable with a given address [payable _to ] is different with msg.sender[payable(mag.sender)]
        require(success,"withdraw failed");

        balance[msg.sender] -= _amount;

    }

    //check your balance
    function checkBalance() public view returns(uint256){
        return balance[msg.sender];
    }

    //check the debt record
    function checkDebt(address _debtor, address _creditor) public view returns(uint256){
        //check address
        require(_debtor != address(0), "invalid address");
        require(registeredFirends[_debtor], "recipient is not registered");

        require(_creditor != address(0), "invalid address");
        require(registeredFirends[_debtor], "recipient is not registered");

        return debt[_debtor][_creditor];
    }


}

//owner: 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4
//friend1: 0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2