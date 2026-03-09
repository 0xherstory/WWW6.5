// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract TipJar{
    address public owner;
    uint256 public totalTipReceived;

    // For example, if 1 USD = 0.0005ETH, then the rate would be 5 * 10^14
    mapping (string => uint256) public conversionRates;
    mapping (address => uint256) public tipPerPerson;

    string[] public supportedCurrencies;
    mapping (string => uint256) public tipPerCurrency;

    constructor() {
        owner = msg.sender;
        addCurrency("USD",5*10**14); // 1 USD = 0.0005ETH
        addCurrency("EUR",6*10**14); // 1 EUR = 0.0006ETH
        addCurrency("JPY",4*10**12); // 1 JPY = 0.000004ETH
        addCurrency("INR",7*10**12); // 1 INR = 0.000007ETH 
    }

    modifier onlyOwner(){
        require(msg.sender == owner, "Only owner can perform this action");
        _;
    }

    // Add or update a supported currency
    function addCurrency(string memory _currencyCode, uint256 _rateToEth) public onlyOwner{
        require(_rateToEth>0, "Conversion rate must be greater than 0");
        bool currencyExists = false;
        for (uint i = 0; i<supportedCurrencies.length; i++){
            if (keccak256(bytes(supportedCurrencies[i])) == keccak256(bytes(_currencyCode))) {
                currencyExists = true;
                break;
            }
        }
        if (!currencyExists){
            supportedCurrencies.push(_currencyCode);
        }
        conversionRates[_currencyCode] = _rateToEth;
    }

    // Convert tool
    function convertToEth(string memory _currencyCode, uint256 _amount) public view returns(uint256){
        require(conversionRates[_currencyCode] > 0, "Currency not supported");
        uint256 ethAmount = _amount * conversionRates[_currencyCode];
        return ethAmount;
    }

    // Send a tip in ETH directly
    function tipInEth() public payable{
        require(msg.value > 0, "Tip amount must be greater than 0");
        tipPerPerson[msg.sender] += msg.value;
        totalTipReceived += msg.value;
        tipPerCurrency["ETH"] += msg.value;
    }

    function tipInCurrency(string memory _currencyCode, uint256 _amount) public payable{
        require(conversionRates[_currencyCode] > 0, "Currency not supported");
        require(_amount > 0, "Amount must be greater than 0");
        uint256 ethAmount = convertToEth(_currencyCode, _amount);
        require(msg.value == ethAmount, "Sent ETH doesn't match the converted amount");
        tipPerPerson[msg.sender] += msg.value;
        totalTipReceived += msg.value;
        tipPerCurrency[_currencyCode] += _amount;   
    }

    function withdrawTips() public onlyOwner{
        uint256 contractBalance = address(this).balance;
        require(contractBalance > 0, "No tips to withdraw");
        (bool success,) = payable(owner).call{value:contractBalance}("");
        require(success,"Transfer failed");
        // totalTipReceived = 0;  //not set zero, record historical tips
    }

    function transferOwnership(address _newOwner) public onlyOwner {
        require(_newOwner != address(0), "Invalid address");
        owner = _newOwner;
    }

    function getSupportedCurrencies() public view returns(string[] memory){
        return supportedCurrencies;
    }

    function getConstractBalance() public view returns (uint256) {
        return address(this).balance;
    }

    function getTipperContribution(address _tipper) public view returns (uint256) {
        return tipPerPerson[_tipper];
    }

    function getTipsInCurrency(string memory _currencyCode) public  view returns (uint256){
        return tipPerCurrency[_currencyCode];
    }

    function getConversionRate(string memory _currencyCode) public view returns (uint256){
        require(conversionRates[_currencyCode] > 0, "Currency not supported");
        return conversionRates[_currencyCode];
    }



    


}