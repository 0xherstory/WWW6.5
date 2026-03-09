// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract TipJar {
  
    address public owner;
    // 存储从货币代码到ETH的汇率（例如：1 USD = 5e14 wei）
    mapping(string => uint256) public conversionRates;
    // 跟踪支持的所有货币代码
    string[] public supportedCurrencies;
    // 合约总共收到的ETH（以wei为单位）
    uint256 public totalTipsReceived;
    // 每个地址累计打赏的ETH金额
    mapping(address => uint256) public tipperContributions;
    // 每种货币对应的打赏总金额（ETH）
    mapping(string => uint256) public tipsPerCurrency;

    // 仅所有者可执行的修饰符
    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can perform this action.");
        _;
    }

    // 构造函数：初始化所有者和默认汇率
    constructor() {
        owner = msg.sender;
        // 汇率说明：1单位货币 = X wei（1 ETH = 1e18 wei）
        addCurrency("USD", 5 * 10**14); // 1 USD = 0.0005 ETH
        addCurrency("EUR", 6 * 10**14); // 1 EUR = 0.0006 ETH
        addCurrency("JPY", 4 * 10**12); // 1 JPY = 0.000004 ETH
        addCurrency("GBP", 7 * 10**14); // 1 GBP = 0.0007 ETH
    }

    // 添加/更新货币汇率
    function addCurrency(string memory _currencyCode, uint256 _rateToEth) public onlyOwner {
        require(_rateToEth > 0, "Conversion rate must be greater than 0");
        
        // 检查货币是否已存在
        bool currencyExists = false;
        for (uint256 i = 0; i < supportedCurrencies.length; i++) { 
            if (keccak256(bytes(supportedCurrencies[i])) == keccak256(bytes(_currencyCode))) {
                currencyExists = true;
                break;
            }
        }
        
        // 货币不存在则添加
        if (!currencyExists) {
            supportedCurrencies.push(_currencyCode);
        }
        
        // 设置汇率
        conversionRates[_currencyCode] = _rateToEth;
    }

    // 将指定货币金额转换为ETH（wei）
    function convertToETH(string memory _currencyCode, uint256 _amount) public view returns (uint256) {
        require(conversionRates[_currencyCode] > 0, "Currency not supported");
        // 计算：金额 * 汇率（1单位货币对应的wei数）
        uint256 ethAmount = _amount * conversionRates[_currencyCode];
        return ethAmount;
    }

    // 直接用ETH打赏
    function tipInEth() public payable {
        require(msg.value > 0, "Tip amount must be greater than 0");
        
        // 更新打赏记录
        tipperContributions[msg.sender] += msg.value;
        totalTipsReceived += msg.value;
        tipsPerCurrency["ETH"] += msg.value;
    }

    // 用指定货币打赏（自动转换为ETH）
    function tipInCurrency(string memory _currencyCode, uint256 _amount) public payable {
        require(conversionRates[_currencyCode] > 0, "Currency not supported");
        require(_amount > 0, "Amount must be greater than 0");
        
        // 转换为ETH金额（wei）
        uint256 ethAmount = convertToETH(_currencyCode, _amount);
        require(msg.value == ethAmount, "Sent ETH doesn't match the converted amount");
        
        // 更新打赏记录
        tipperContributions[msg.sender] += msg.value;
        totalTipsReceived += msg.value;
        tipsPerCurrency[_currencyCode] += ethAmount; 
    }

    // 提现所有打赏金额
    function withdrawTips() public onlyOwner {
        uint256 contractBalance = address(this).balance;
        require(contractBalance > 0, "No tips to withdraw");
        
        // 发送ETH给所有者（使用call确保兼容性）
        (bool success, ) = payable(owner).call{value: contractBalance}("");
        require(success, "Transfer failed");
        
        // 重置打赏统计
        totalTipsReceived = 0;
        
    }

    // 转让合约所有权
    function transferOwnership(address _newOwner) public onlyOwner {
        require(_newOwner != address(0), "Invalid address");
        owner = _newOwner;
    }

    // 获取所有支持的货币列表
    function getSupportedCurrencies() public view returns (string[] memory) {
        return supportedCurrencies;
    }

    // 获取合约当前ETH余额
    function getContractBalance() public view returns (uint256) {
        return address(this).balance;
    }

    // 获取指定地址的累计打赏金额
    function getTipperContribution(address _tipper) public view returns (uint256) {
        return tipperContributions[_tipper]; 
    }

    // 获取指定货币的累计打赏金额（ETH）
    function getTipsInCurrency(string memory _currencyCode) public view returns (uint256) {
        return tipsPerCurrency[_currencyCode];
    }

    // 获取指定货币的汇率
    function getConversionRate(string memory _currencyCode) public view returns (uint256) {
        require(conversionRates[_currencyCode] > 0, "Currency not supported");
        return conversionRates[_currencyCode];
    }
}