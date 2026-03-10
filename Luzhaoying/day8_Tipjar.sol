//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract TipJar {
    //合约管理者
    address public owner;
    //记录合约收到的所有小费总额（以 wei 为单位）。
    uint256 public totalTipsReceived;
    //一个映射，用于存储货币代码（如 "USD"）与其对应 ETH 汇率的数值。
    //例如，如果 1 USD = 0.0005 ETH，由于 Solidity 不支持小数，我们使用 5 * 10^14 来表示（因为 1 ETH = 10^18 wei，所以 0.0005 ETH = 5 * 10^14 wei）
    mapping(string => uint256) public conversionRates;
    //记录每个地址（用户）总共向合约发送了多少 wei 的小费。
    mapping(address => uint256) public tipPerPerson;
    // 一个字符串数组，存储所有受支持的货币代码列表。
    string[] public supportedCurrencies;  
    //记录每种货币收到的小费总金额（以该货币的单位计，例如 USD 的单位是“分”或“元”，取决于前端逻辑）。
    mapping(string => uint256) public tipsPerCurrency;
    
    constructor() {
        //将合约的部署者（msg.sender）设置为所有者。
        owner = msg.sender;
        //调用 addCurrency 函数，初始化几种默认支持的货币及其汇率。
        addCurrency("USD", 5 * 10**14);  // 1 USD = 0.0005 ETH
        addCurrency("EUR", 6 * 10**14);  // 1 EUR = 0.0006 ETH
        addCurrency("JPY", 4 * 10**12);  // 1 JPY = 0.000004 ETH
        addCurrency("INR", 7 * 10**12);  // 1 INR = 0.000007ETH ETH
    }
    //定义了一个名为 onlyOwner 的修饰符,检查调用者是否是合约所有者。如果不是，交易将回滚并显示错误信息。
    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can perform this action");
        _;
    }
    
    // 允许所有者添加新货币或更新现有货币的汇率
    function addCurrency(string memory _currencyCode, uint256 _rateToEth) public onlyOwner {
        require(_rateToEth > 0, "Conversion rate must be greater than 0");
        bool currencyExists = false;
        //检查传入的货币代码是否已存在于 supportedCurrencies 数组中,它通过比较字符串的 Keccak256 哈希值来实现。
        for (uint i = 0; i < supportedCurrencies.length; i++) {
            if (keccak256(bytes(supportedCurrencies[i])) == keccak256(bytes(_currencyCode))) {
                currencyExists = true;
                break;
            }
        }
        //如果货币不存在，则将其添加到数组中。
        if (!currencyExists) {
            supportedCurrencies.push(_currencyCode);
        }
        //更新或设置该货币的汇率。
        conversionRates[_currencyCode] = _rateToEth;
    }
    //根据存储的汇率，将指定数量的某种货币转换为等值的 ETH（以 wei 为单位）
    //view表示该函数只读取数据，不修改状态，因此调用它不需要支付 gas 费（在外部调用时）
    function convertToEth(string memory _currencyCode, uint256 _amount) public view returns (uint256) {
        //确保传入的货币是受支持的
        require(conversionRates[_currencyCode] > 0, "Currency not supported");
        //计算转换后的 ETH 数量（wei）。
        uint256 ethAmount = _amount * conversionRates[_currencyCode];
        return ethAmount;
        //If you ever want to show human-readable ETH in your frontend, divide the result by 10^18 :
    }
    
    // 允许用户直接发送 ETH 作为小费
    function tipInEth() public payable {
        //确保用户确实发送了 ETH（msg.value 大于 0）
        require(msg.value > 0, "Tip amount must be greater than 0");
        //增加该用户的小费总额记录
        tipPerPerson[msg.sender] += msg.value;
        //增加合约总小费记录
        totalTipsReceived += msg.value;
        //增加 ETH 类别的小费总额
        tipsPerCurrency["ETH"] += msg.value;
    }
    //允许用户使用其他货币发送小费
    function tipInCurrency(string memory _currencyCode, uint256 _amount) public payable {
        require(conversionRates[_currencyCode] > 0, "Currency not supported");
        require(_amount > 0, "Amount must be greater than 0");
        //计算用户声称的货币金额需要多少 ETH
        uint256 ethAmount = convertToEth(_currencyCode, _amount);
        //核心安全检查。确保用户实际发送的 ETH 数量（msg.value）与计算出的金额完全一致。如果不一致，交易回滚
        require(msg.value == ethAmount, "Sent ETH doesn't match the converted amount");
        tipPerPerson[msg.sender] += msg.value;
        totalTipsReceived += msg.value;
        tipsPerCurrency[_currencyCode] += _amount;
    }
    //提取小费
    function withdrawTips() public onlyOwner {
        //获取合约当前的 ETH 余额
        uint256 contractBalance = address(this).balance;
        //如果没有余额则无需提取。
        require(contractBalance > 0, "No tips to withdraw");
        (bool success, ) = payable(owner).call{value: contractBalance}("");
        //检查转账是否成功。
        require(success, "Transfer failed");
        totalTipsReceived = 0;
    }
    //允许当前所有者将所有权转让给新地址
    function transferOwnership(address _newOwner) public onlyOwner {
        require(_newOwner != address(0), "Invalid address");
        owner = _newOwner;
    }
    //辅助 Getter 函数，用于从外部（例如前端应用）读取合约状态。
    //返回受支持的货币代码列表
    function getSupportedCurrencies() public view returns (string[] memory) {
        return supportedCurrencies;
    }
    //返回合约当前的 ETH 余额
    function getContractBalance() public view returns (uint256) {
        return address(this).balance;
    }
    //查询特定地址的总贡献额
    function getTipperContribution(address _tipper) public view returns (uint256) {
        return tipPerPerson[_tipper];
    }
    //查询特定货币收到的总小费金额（以该货币单位计）
    function getTipsInCurrency(string memory _currencyCode) public view returns (uint256) {
        return tipsPerCurrency[_currencyCode];
    }
    //查询特定货币的 ETH 汇率
    function getConversionRate(string memory _currencyCode) public view returns (uint256) {
        require(conversionRates[_currencyCode] > 0, "Currency not supported");
        return conversionRates[_currencyCode];
    }
}