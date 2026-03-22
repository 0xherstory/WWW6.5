// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract TipJar {

    address public owner;
    uint256 public totalTipsReceived;
    string[] public supportedCurrencies;
    mapping(string => uint256) public conversionRates;
    mapping(address => uint256) public tipperContributions;//tipPerPerson
    mapping(string => uint256) public tipsPerCurrency;

    // 添加事件
    event TipReceived(address indexed tipper, string currencyCode, uint256 amount, uint256 ethValue);

    // 最小小费金额（0.001 ETH）
    uint256 public constant MIN_TIP_AMOUNT = 0.001 ether;

    constructor() {
        owner = msg.sender;
        // 5 × 10^14
        // 1 ETH = 10^18 Wei
        addCurrency("USD", 5 * 10 ** 14);  // 1 USD = 0.0005 ETH
        addCurrency("EUR", 6 * 10 ** 14);  // 1 EUR = 0.0006 ETH
        addCurrency("JPY", 4 * 10 ** 12);  // 1 JPY = 0.000004 ETH
        addCurrency("INR", 7 * 10 ** 12);  // 1 INR = 0.000007 ETH
    }

    modifier OnlyOwner {
        require(msg.sender == owner, "Only owner can perform this action");
        _;
    }

    // 仅所有者添加或更新币种与其兑 ETH 汇率
    function addCurrency(string memory _currencyCode, uint256 _rateToEth) public OnlyOwner {
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
        conversionRates[_currencyCode] = _rateToEth;
    }

    // 将法币金额按汇率换算为 Wei（ETH 最小单位）
    function convertToEth(string memory _currencyCode, uint256 _amount) public view returns (uint256) {
        require(conversionRates[_currencyCode] > 0, "Currency not supported");
        return _amount * conversionRates[_currencyCode];
    }

    // 直接以 ETH 打赏，累计到总额与按币种统计
    function tipInEth() public payable {
        require(msg.value >= MIN_TIP_AMOUNT, "Tip amount below minimum");
        totalTipsReceived += msg.value;
        tipsPerCurrency["ETH"] += msg.value;
        tipperContributions[msg.sender] += msg.value;
        emit TipReceived(msg.sender, "ETH", msg.value, msg.value);
    }

    // 指定法币金额打赏，需随交易附带等值 ETH
    function tipInCurrency(string memory _currencyCode, uint256 _amount) public payable {
        require(_amount > 0, "Amount must be greater than 0");
        uint256 ethAmount = convertToEth(_currencyCode, _amount);
        require(ethAmount == msg.value, "Sent ETH doesn't match the converted amount");
        require(msg.value >= MIN_TIP_AMOUNT, "Tip amount below minimum");
        totalTipsReceived += msg.value;
        tipsPerCurrency[_currencyCode] += msg.value;
        tipperContributions[msg.sender] += msg.value;
        emit TipReceived(msg.sender, _currencyCode, _amount, msg.value);
    }

    // 仅所有者提取合约内累计的打赏款项
    function withdrawTips() public OnlyOwner {
        uint256 contractBalance = address(this).balance;
        require(contractBalance > 0, "No tips to withdraw");
        (bool success,) = payable(owner).call{value: contractBalance}("");
        require(success, "Transfer failed");
        totalTipsReceived = 0;
    }

    // 转移合约所有权至新地址
    function transferOwnership(address _newOwner) public OnlyOwner {
        require(_newOwner != address(0), "Invalid address");
        owner = _newOwner;
    }

    // 获取当前支持的币种列表
    function getSupportedCurrencies() public view returns (string[] memory) {
        return supportedCurrencies;
    }

    // 查询合约当前持有的 ETH 余额
    function getContractBalance() public view returns (uint256) {
        return address(this).balance;
    }

    // 查询某地址累计打赏（以 Wei 计）
    function getTipperContribution(address _tipper) public view returns (uint256) {
        return tipperContributions[_tipper];
    }

    // 查询某币种累计打赏的名义金额
    function getTipsInCurrency(string memory _currencyCode) public view returns (uint256) {
        return tipsPerCurrency[_currencyCode];
    }

    // 查询某币种当前设置的兑 ETH 汇率
    function getConversionRate(string memory _currencyCode) public returns (uint256) {
        require(conversionRates[_currencyCode] > 0, "currency not supported");
        return conversionRates[_currencyCode];
    }

    // 移除不支持的货币
    function removeCurrency(string memory _currencyCode) public OnlyOwner {
        require(keccak256(bytes(_currencyCode)) != keccak256(bytes("ETH")), "Cannot remove ETH");
        require(conversionRates[_currencyCode] > 0, "Currency not supported");
        // 从数组中移除
        for (uint i = 0; i < supportedCurrencies.length; i++) {
            if (keccak256(bytes(supportedCurrencies[i])) == keccak256(bytes(_currencyCode))) {
                supportedCurrencies[i] = supportedCurrencies[supportedCurrencies.length - 1];
                supportedCurrencies.pop();
                break;
            }
        }
        delete conversionRates[_currencyCode];
    }

    // 实现部分提取功能
    function withdrawPartial(uint256 _amount) public OnlyOwner {
        require(_amount > 0, "Amount must be greater than 0");
        require(address(this).balance >= _amount, "Insufficient balance");

        (bool success,) = payable(owner).call{value: _amount}("");
        require(success, "Transfer failed");

        if (_amount >= totalTipsReceived) {
            totalTipsReceived = 0;
        } else {
            totalTipsReceived -= _amount;
        }
    }

}
