//SPDX-License-Identifier:MIT
pragma solidity ^0.8.0;

//This contract is used to caculate mutil kinds of currency convert into ETH.
//Tips sponsers still should have account of wallet
//They just don't know the rate between their currency and ETH
contract TipJar{
    //we need: owner, total tips recieved, supported currency
    address public owner;
    uint256 public totalTipRecieved;
    string[] private supportedCurrency;

    //we need mapping: rates, tips of per person, tips of per kind of currency
    mapping(string => uint256) rates;
    mapping(address => uint256) tipsPerPerson;
    mapping(string => uint256) tipsPerCurrency;

    //constructor: owner, default currency and rate;
    constructor(){
        owner = msg.sender;
        //I used tried to add the default currency like this, but it occurs me I can use the add fucntion 
        //supportedCurrency.push("ETH");
        //rates["ETH"] = 10^18;
        addCurrency("ETH", 10**18); 
        addCurrency("USD", 5 * 10**14);  // 1 USD = 0.0005 ETH
        addCurrency("EUR", 6 * 10**14);  // 1 EUR = 0.0006 ETH
        addCurrency("JPY", 4 * 10**12);  // 1 JPY = 0.000004 ETH
        addCurrency("INR", 7 * 10**12);  // 1 INR = 0.000007ETH ETH

    }
    //limits of authority
    modifier onlyOwner(){
        require(msg.sender == owner,"only owner can perform this action");
        _;
    }

    //add support currency and its rate
    //I found I don't have to add paretheses after my modifier(But if I did, it's ok)
    //Now I get the convenience of using  mapping string => bool.
     
    function addCurrency(string memory _currencyCode, uint256 _rate) public onlyOwner{
        require(_rate>0," rate must be greater than 0");
        bool currencyExit = false;
        //check the currency exist, use [for]
        for(uint256 i=0; i < supportedCurrency.length ;i++){
            if(keccak256(bytes(_currencyCode)) == keccak256(bytes(supportedCurrency[i]))){
                currencyExit = true;
                break;
            }
        } 

        //alternate : 
        //if(rates[_currencyCode] > 0){
            //currencyExit = true;
        //}
        //require(!currencyExit,"currency already record");


        if(!currencyExit){
            supportedCurrency.push(_currencyCode);
        }

        rates[_currencyCode] = _rate;

    }

    //get the amount of the currency converted to eth
    function getConvertToEth(string memory _currencyCode, uint256 _amount) public view returns(uint256){
        require(rates[_currencyCode] > 0,"this currency is not supported");
        require(_amount > 0,"amount must be greater than 0");

        uint256 amountEth = _amount * rates[_currencyCode];

        return amountEth;
    }

    //send tip in ETH
    function tipInEth() public payable{
        require(msg.value > 0, "value must be greater than 0");
        tipsPerPerson[msg.sender] += msg.value;
        totalTipRecieved += msg.value;
        tipsPerCurrency["ETH"] += msg.value;
    }

    //send tip in currency
    function tipInCurrency(string memory _currencyCode, uint256 _amount) public payable{
        require(_amount > 0,"amount must be greater than 0");
        require(rates[_currencyCode] > 0,"this currency is not supported");
        uint256 EthAmount = getConvertToEth(_currencyCode, _amount);
        require(EthAmount == msg.value," ETH value doesn't match the converted amount");
        tipsPerPerson[msg.sender] += msg.value;
        totalTipRecieved += msg.value;
        tipsPerCurrency["ETH"] += msg.value;
    }

 

    //withdraw all tips,
    function withdrawAllTips() public onlyOwner{
        //1. address(this)​
        //this: In Solidity, thisis a reference pointing to the current contract instance, much like thisin object-oriented programming points to the current object.
        //address(this): This converts the contract instance into an address type, yielding the blockchain address of the current contract.
        //Example: If your contract is deployed at 0x742d35Cc6634C0532925a3b844Bc9e..., then address(this)is that address.

        //2. .balance​

        //This is a member property​ of the address type. It returns the Ether balance of that address, measured in wei​ (1 ETH = 10^18 wei).
        //It is a read-only property​ and can be queried without consuming any Gas.

        uint TotalEth = address(this).balance;//this is new
        
        (bool success,) = payable(owner).call{value: TotalEth}("");
        require(success,"withdraw failed");
        totalTipRecieved -= 0;
    }

    function transferOwner(address _newOwner) public onlyOwner{
        require(_newOwner != address(0),"invalid address");
        owner = _newOwner;
    }
    //see the list of supported currency
    function getSupportedCurrency()public view returns(string[] memory){
        return supportedCurrency;
    }

    function getContractBalance() public view returns (uint256) {
        return address(this).balance;
    }
    
   
    function getTipperContribution(address _tipper) public view returns (uint256) {
        return tipsPerPerson[_tipper];
    }
    

    function getTipsInCurrency(string memory _currencyCode) public view returns (uint256) {
        return tipsPerCurrency[_currencyCode];
    }

    function getConversionRate(string memory _currencyCode) public view returns (uint256) {
        require(rates[_currencyCode] > 0, "Currency not supported");
        return rates[_currencyCode];
    }
}