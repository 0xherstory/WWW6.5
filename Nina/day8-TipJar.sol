//这是一个收集小费的智能合约，可以收集ETH或法币，owner可以将小费以ETH提取出来

//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract TipJar {
    address public owner;
    string[] public supportedCurrencies;  // List of supported currencies
    mapping(string => uint256) public conversionRates; // 映射货币到ETH的汇率. 1ETH=10^18Wei. For example, if 1 USD = 0.0005 ETH, then the rate would be 5 * 10^14
    mapping(address => uint256) public tipPerPerson; // 每个地址在小费中发送了多少ETH
    mapping(string => uint256) public tipsPerCurrency; // 每种货币的小费金额
    uint256 public totalTipsReceived; // 合约总体上收集了多少ETH（以Wei为单位）

    constructor() {
        owner = msg.sender;
        addCurrency("USD", 5 * 10**14);  // 1 USD = 0.0005 ETH
        addCurrency("EUR", 6 * 10**14);  // 1 EUR = 0.0006 ETH
        addCurrency("JPY", 4 * 10**12);  // 1 JPY = 0.000004 ETH
        addCurrency("INR", 7 * 10**12);  // 1 INR = 0.000007ETH ETH
    }
    
    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can perform this action");
        _;
    }
    
    // Add or update a supported currency rate
    function addCurrency(string memory _currencyCode, uint256 _rateToEth) public onlyOwner {
        require(_rateToEth > 0, "Conversion rate must be greater than 0"); // 要求汇率非负，一个快速的安全检查
        bool currencyExists = false; // 声明一个临时变量bool值，初始值为false。因为只在本函数中需要这个变量，不需要永久存储，不需要设置为状态变量浪费gas费（修改昂贵）。
        for (uint i = 0; i < supportedCurrencies.length; i++) {
            if (keccak256(bytes(supportedCurrencies[i])) == keccak256(bytes(_currencyCode))) {
                currencyExists = true;
                break;
            }
        } 
        /*避免重复添加相同货币：
        通过for循环处理数组遍历，从第0个到最后1个。
        bytes()把字符串转成原始的字节数据。keccak256()是一个内置的加密哈希函数，把任意长度的内容变成一个固定长度的“数字指纹”。
        如果==成立，将临时变量currencyExists标记为true，并且中止for循环。【如果没有break，会继续完成遍历，浪费gas费。】
        */
        if (!currencyExists) {
            supportedCurrencies.push(_currencyCode);
        } // 如果它是新货币，即 currencyExists 变量保持 false，我们将该货币添加到 supportedCurrencies 列表中
        conversionRates[_currencyCode] = _rateToEth; // 无论新旧货币，都会设置或更新汇率
    }
    /* 如果使用映射mapping：
    设置状态变量 -> mapping(string => bool) public currencyExists; 
    function addCurrency(string memory _currencyCode, uint256 _rateToEth) public onlyOwner {
        require(_rateToEth > 0, "Conversion rate must be greater than 0"); 
        if(!currencyExists[_currencyCode]) {
            supportedCurrencies.push(_currencyCode); 
            currencyExists[_currencyCode] = true; //只有新币加进数组并标记为true //初始化的货币在constructor()调用addCurrency时已标记为true
        conversionRates[_currencyCode] = _rateToEth; //无论新旧货币，都会设置或更新汇率
    
    mapping虽然需要多保存一个映射状态变量，但它省去了for的昂贵循坏gas费，更加稳定安全。使用for循环遍历数组，随着数组扩大，交易消耗的gas越来越多，可能受到gas limit攻击而交易失败。而mapping直接判断某个元素的状态，消耗的gas恒定且低廉，交易安全性更高。
    */
    
    function convertToEth(string memory _currencyCode, uint256 _amount) public view returns (uint256) {
        require(conversionRates[_currencyCode] > 0, "Currency not supported"); //如果该币种未登记过汇率，conversionRates会返回默认值0，require函数判断0>0为false，因此不执行convertToEth函数并出现文字提示
        uint256 ethAmount = _amount * conversionRates[_currencyCode];
        return ethAmount;
        //如果需要人类可读的ETH而非Wei，请在前端除以10^18. 不要在Solidity合约中操作，Solidity仅支持整数，任何少于 1 ETH 的东西都会四舍五入为 0.
    }
    
    // Send a tip in ETH directly
    function tipInEth() public payable {
        require(msg.value > 0, "Tip amount must be greater than 0");
        tipPerPerson[msg.sender] += msg.value;
        totalTipsReceived += msg.value;
        tipsPerCurrency["ETH"] += msg.value;
    }
    
    function tipInCurrency(string memory _currencyCode, uint256 _amount) public payable {
        require(conversionRates[_currencyCode] > 0, "Currency not supported");
        require(_amount > 0, "Amount must be greater than 0");
        uint256 ethAmount = convertToEth(_currencyCode, _amount);
        require(msg.value == ethAmount, "Sent ETH doesn't match the converted amount"); //检查随交易发送的实际ETH是否与预期金额匹配
        tipPerPerson[msg.sender] += msg.value;
        totalTipsReceived += msg.value;
        tipsPerCurrency[_currencyCode] += _amount;
    }

    function withdrawTips() public onlyOwner {
        uint256 contractBalance = address(this).balance; 
            // address(this): 指代当前这个合约自己的地址。
            //.balance: 这是 Solidity 内置的属性，用来查看这个地址里现在存了多少 Wei (ETH)。
        require(contractBalance > 0, "No tips to withdraw"); 
        (bool success, ) = payable(owner).call{value: contractBalance}("");
        require(success, "Transfer failed");
        totalTipsReceived = 0;
    }
  
    function transferOwnership(address _newOwner) public onlyOwner {
        require(_newOwner != address(0), "Invalid address");
        owner = _newOwner;
    }

    function getSupportedCurrencies() public view returns (string[] memory) {
        return supportedCurrencies;
    }
    
    function getContractBalance() public view returns (uint256) {
        return address(this).balance;
    }
    
    function getTipperContribution(address _tipper) public view returns (uint256) {
        return tipPerPerson[_tipper];
    }
    
    function getTipsInCurrency(string memory _currencyCode) public view returns (uint256) {
        return tipsPerCurrency[_currencyCode];
    }

    function getConversionRate(string memory _currencyCode) public view returns (uint256) {
        require(conversionRates[_currencyCode] > 0, "Currency not supported");
        return conversionRates[_currencyCode];
    }
}