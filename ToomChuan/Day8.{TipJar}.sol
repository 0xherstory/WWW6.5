// SPDX-License-Identifier: MIT
pragma solidity ^0.8.31;

contract TipJar {
    address public owner;
    uint256 public totalTipsRecieved;
    mapping(string => uint256) public conversionRates; //mapping存储从货币代码到ETH的汇率
    string[] public supportedCurrencies; //string[]追踪所添加的所有货币代码，可以循环访问
    mapping(string => uint256) public tipsPerCurrency;

    mapping (address => uint256) public tipperContributions;//mapping存储每个地址发送的ETH
    mapping (address => uint256) public Tipcounts;//mapping存储发送的次数

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can perform this action");
        _;
    }

    function addCurrency(string memory _currencyCode, uint256 _rateToEth) public onlyOwner {
        require(_rateToEth > 0, "Conversion rate must be greater than 0");
        bool currencyExists = false;
        for (uint i = 0; i < supportedCurrencies.length; i++) {
            if (keccak256(bytes(supportedCurrencies[i])) == keccak256(bytes(_currencyCode))) {
                currencyExists = true;
                break;
            }
        }

        if (!currencyExists) {
            supportedCurrencies.push(_currencyCode);
        }

         conversionRates[_currencyCode] = _rateToEth;//添加新货币，现有的可以安全地更新费率
    }

        

       

        constructor() {
            owner = msg.sender;

            addCurrency("USD", 5 * 10**14);
            addCurrency("EUR", 6 * 10**14);
            addCurrency("JPY", 4 * 10**12);
            addCurrency("GBP", 7 * 10**14);
        }

        //将外币金额转换为ETH
        function conversionToEth(string memory _currencyCode, uint256 _amount) public view returns (uint256) {
            require (conversionRates[_currencyCode] > 0, "Currency not supported");

            uint256 ethAmount = _amount * conversionRates[_currencyCode];
            return ethAmount;
        }

        function tipInEth() public payable {
            require(msg.value > 0, "Tip amount must be greater than 0");

            tipperContributions[msg.sender] += msg.value;
            totalTipsRecieved += msg.value;
            tipsPerCurrency["ETH"] += msg.value;
        }

        function tipInCurrency(string memory _currencyCode, uint256 _amount) public payable {
            require(conversionRates[_currencyCode] > 0, "Currency not supported");
            require(_amount > 0 ,"Amount must be greater than 0");

            uint256 ethAmount = conversionToEth(_currencyCode, _amount);
            require(msg.value == ethAmount, "Sent ETH doesn't match the converted amount");

            tipperContributions[msg.sender] += msg.value;
            totalTipsRecieved += msg.value;
            tipsPerCurrency[_currencyCode] += _amount;
        }

        //提取小费
        function withdrawTips() public onlyOwner {
            uint256 contractBalance = address(this).balance;
            require(contractBalance > 0,"No tips to withdraw");

            (bool success, ) = payable(owner).call{value: contractBalance}("");
            require(success, "Transfer failed");

            totalTipsRecieved = 0;
        }

        function transferOwnership(address _newOwner) public onlyOwner {
            require(_newOwner != address(0), "Invalid address");
            owner = _newOwner;
        }
        
        //从合约中获取信息
        function gerSupportedCurrencies() public view returns (string[] memory) {
            return supportedCurrencies;
        }

        function getContractiBalance() public view returns(uint256) {
            return address(this).balance;
        }

        function getTipperContribution(address _tipper) public view returns (uint256) {
            return tipperContributions[_tipper];
        }

        function getTipsInCurrency(string memory _currencyCode) public view returns (uint256) {
            return tipsPerCurrency[_currencyCode];
        }

        function getConversionRates(string memory _currencyCode) public view returns (uint256) {
            require(conversionRates[_currencyCode] > 0, "Currency not supported");
            return conversionRates[_currencyCode];
        }
}