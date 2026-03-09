// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract TipJar{

address public owner;
mapping (string => uint256 )public conversionRates;
string[]public supportedCurrencies;
uint256 public totalTipsReceived;
mapping (address=>uint256)public tipperContributions;
mapping(string=>uint256) public tipsPerCurrency;

modifier onlyOwner(){
    require (msg.sender==owner,"not the owner");
    _;
}

constructor (){
    owner=msg.sender;
    addCurrency("ETH",1 ether);
}

function addCurrency(string memory _currencyCode,uint256 _rateToEth) public onlyOwner{
    bool exists = false;
    for(uint i =0 ; i < supportedCurrencies.length;i++){
        if(keccak256(bytes(supportedCurrencies[i])) == keccak256 (bytes(_currencyCode))){
            exists=true;
            break;

        }
    }

    if(!exists ){
        supportedCurrencies.push(_currencyCode);
    }
    conversionRates[_currencyCode]=_rateToEth; 
}

function convertToEth(string memory _currencyCode , uint256 _amount)public view returns(uint256){
    uint256 rate =conversionRates[_currencyCode];
    require(rate > 0 ,"currency not supported");
    return (_amount * 1 ether) / rate;
}
function tipInEth() public payable {
    require(msg.value > 0, "Must send ETH");
        
    totalTipsReceived += msg.value;
    tipperContributions[msg.sender] += msg.value;
    tipsPerCurrency["ETH"] += msg.value;
}

function withdrawTips() public onlyOwner {
    uint256 contractBalance = address(this).balance;
    require(contractBalance > 0, "No tips to withdraw");
    
    (bool success, ) = payable(owner).call{value: contractBalance}("");
    require(success, "Transfer failed");}

function transferOwnership(address _newOwner) public onlyOwner {
    require(_newOwner != address(0), "Invalid address");
    owner = _newOwner;
    }

    function getSupportedCurrencies()public view returns(string[] memory){
    return supportedCurrencies;
} 

   
    
function getContractBalance() public view returns (uint256) {
    return address(this).balance;
}
    
function getTipperContribution(address _tipper) public view returns (uint256) {
    return tipperContributions[_tipper];
}
    
function getTipsInCurrency(string memory _currencyCode) public view returns (uint256) {
    return tipsPerCurrency[_currencyCode];
    }
    
 function getConversionRate(string memory _currencyCode) public view returns (uint256) {
    return conversionRates[_currencyCode];
    }

}