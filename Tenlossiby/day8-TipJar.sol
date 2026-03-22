//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract TipJar {
    // 合约的拥有者（管理员）地址
    address public owner;
    
    // 记录收到的打赏总金额
    uint256 public totalTipsReceived;
    
    // 汇率映射表：记录法币（如USD）到ETH的汇率
    // 例如，如果 1 USD = 0.0005 ETH，那么这里存储的是 5 * 10^14（以wei为单位）
    mapping(string => uint256) public conversionRates;

    // 记录每个地址（人）打赏的金额
    mapping(address => uint256) public tipPerPerson;
    
    // 当前支持的代币/货币列表
    string[] public supportedCurrencies;  // List of supported currencies
    
    // 记录每种货币收到的打赏总数
    mapping(string => uint256) public tipsPerCurrency;
    
    // 构造函数：在部署智能合约时执行且仅执行一次的初始化代码
    constructor() {
        owner = msg.sender; // 将调用该合约部署操作的用户设定为所有者(owner)
        // 初始化预设的各种货币的转换汇率
        addCurrency("USD", 5 * 10**14);  // 1 USD = 0.0005 ETH
        addCurrency("EUR", 6 * 10**14);  // 1 EUR = 0.0006 ETH
        addCurrency("JPY", 4 * 10**12);  // 1 JPY = 0.000004 ETH
        addCurrency("INR", 7 * 10**12);  // 1 INR = 0.000007ETH ETH
    }
    
    // 自定义修饰符（modifier）：用于函数前，用来检查运行之前的要求
    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can perform this action"); // 限制只有管理员才能使用
        _; // 代表继续执行接下来目标函数内部的代码
    }
    
    // Add or update a supported currency (增加或更新支持的币种以及对等汇率)
    // 注意这个函数挂载了 onlyOwner，确保只有管理员能够修改系统汇率
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
        conversionRates[_currencyCode] = _rateToEth;
    }
    
    // 核心换算模块：根据给定的法币代码及其金额，推算出需要多少ETH（也就是wei单位的数量）
    // 'view' 代表当前这个函数不会修改链上的状态变量，仅仅只是读取（读取了 conversionRates）
    function convertToEth(string memory _currencyCode, uint256 _amount) public view returns (uint256) {
        require(conversionRates[_currencyCode] > 0, "Currency not supported");
        uint256 ethAmount = _amount * conversionRates[_currencyCode]; // 汇率计算转换为Wei
        return ethAmount;
        //If you ever want to show human-readable ETH in your frontend, divide the result by 10^18 :
    }
    
    // Send a tip in ETH directly (发送ETH直接进行打赏)
    // payable 关键字：标记了该函数能够用来接收随交易发送的以太币 (msg.value)
    function tipInEth() public payable {
        require(msg.value > 0, "Tip amount must be greater than 0"); // 此处的 msg.value 就是附带发送进合约的以太金额 (单位：wei)
        tipPerPerson[msg.sender] += msg.value; // 计算打赏人的累计打赏额度
        totalTipsReceived += msg.value; // 在平台总收到的总额中追加
        tipsPerCurrency["ETH"] += msg.value; // 单独在ETH的货币类别中追加
    }
    
    // 通过指定的货币类型去计算所需要付出的ETH进行打赏
    // 参数包含用户选择发送的具体法币以及法币金额值
    function tipInCurrency(string memory _currencyCode, uint256 _amount) public payable {
        require(conversionRates[_currencyCode] > 0, "Currency not supported");
        require(_amount > 0, "Amount must be greater than 0");
        
        // 我们预计算出这段法币对应多少 wei
        uint256 ethAmount = convertToEth(_currencyCode, _amount);
        
        // 安全检查：强制校验用户实际上在调用这个智能合约发送来的以太坊(以wei计算)是否与算出来的等额一致，从而防止作恶或发错
        require(msg.value == ethAmount, "Sent ETH doesn't match the converted amount");
        
        tipPerPerson[msg.sender] += msg.value; // 记录个人贡献
        totalTipsReceived += msg.value; // 汇总总收益
        tipsPerCurrency[_currencyCode] += _amount; // 将它归档于该法币类目中进行统计
    }

    // 提现函数：该合约内有各种收到别人转进来的以太币资产，这个方法用于管理员将里面资金“转出”给管理员自己
    function withdrawTips() public onlyOwner {
        // address(this).balance：用于获取该智能合约本身在所在网络链上的剩余资金 (相当于该金库中有多少钱)
        uint256 contractBalance = address(this).balance;
        require(contractBalance > 0, "No tips to withdraw"); // 要求必须要能提到账的钱
        
        // 将普通地址 owner 变为 payable 对象后，采用底层 .call 发送指定额度的以太坊给目标；这种写法规避了较早出现的transfer的潜在缺点
        (bool success, ) = payable(owner).call{value: contractBalance}("");
        require(success, "Transfer failed"); // 若底层的 .call 方法调用失败就触发回滚交易(revert)来保障安全
        
        totalTipsReceived = 0; // 收账完毕，把收银台数据重置
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