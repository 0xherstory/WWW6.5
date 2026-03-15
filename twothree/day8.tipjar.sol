// SPDX-License-Identifier:  MIT
 pragma solidity ^0.8.0;
//
 contract TipJar {
    address public owner;//定义合约所有者地址变量
    mapping(string => uint256) public conversionRates;//货币兑换率映射
    string[] public supportedCurrencies;//支持货币的字符串数组
    uint256 public totalTipReceived;//接收小费总额
    mapping(address => uint256) public tipperContributions;//按地址记录贡献
    mapping(string => uint256) public tipsPerCurrency;//按货币记录小费

    modifier onlyOwner() {
        require(msg.sender == owner, "Not the owner");
        _;
    }

    constructor() {
    owner = msg.sender;
    addCurrency("ETH", 1 ether);
 }
//22 行开始是添加货币的函数
//23 行先假设这货币不存在。
//24 到 28 行是在已有的货币列表里找，如果找到了就标记存在并停止查找。
 function addCurrency(string memory _currencyCode, uint256 _rateToEth) public onlyOwner {
    bool exists = false;
    for(uint i = 0; i < supportedCurrencies.length;i++) {
        if (keccak256(bytes(supportedCurrencies[i])) == keccak256(bytes(_currencyCode))) {
            exists = true;
            break;
        }
    }
    //32 行把新货币加到支持货币列表，
    //33 行设置这个新货币和以太坊的兑换率，
    //34 和 35 行结束函数。就是给合约添加一种新货币及其兑换率。
    if (!exists) {
        supportedCurrencies.push(_currencyCode);
         conversionRates[_currencyCode] = _rateToEth;
    } 
 }

  // 新增核心函数：接收ETH小费
    function tipInEth() public payable {
        // 1. 校验支付金额大于0
        require(msg.value > 0, "Tip amount must be greater than 0");
        
        // 2. 更新总小费接收额（以wei为单位）
        totalTipReceived += msg.value;
        
        // 3. 记录该支付者的累计贡献
        tipperContributions[msg.sender] += msg.value;
        
        // 4. 按ETH币种统计小费（这里msg.value就是ETH的wei数，直接累加）
        tipsPerCurrency["ETH"] += msg.value;
    }

     // 新增核心函数：以指定货币支付小费（实际转账ETH，按兑换率折算）
    function tipInCurrency(string memory _currencyCode) public payable {
        // 1. 基础校验：支付金额大于0
        require(msg.value > 0, "Tip amount must be greater than 0");
        
        // 2. 校验货币是否支持
        bool isSupported = false;
        for(uint i = 0; i < supportedCurrencies.length; i++) {
            if (keccak256(bytes(supportedCurrencies[i])) == keccak256(bytes(_currencyCode))) {
                isSupported = true;
                break;
            }
        }
        require(isSupported, "Currency not supported");

        // 3. 避免重复调用ETH逻辑（直接复用tipInEth）
        if (keccak256(bytes(_currencyCode)) == keccak256(bytes("ETH"))) {
            tipInEth();
            return;
        }

        // 4. 获取该货币对ETH的兑换率（1单位货币 = X wei）
        uint256 rate = conversionRates[_currencyCode];
        require(rate > 0, "Invalid conversion rate");

        // 5. 计算本次支付对应的「原货币金额」（ETH金额 / 兑换率）
        // 注意：使用除法前确保能整除，或处理精度（这里用unchecked避免溢出，0.8+默认检查）
        uint256 currencyAmount = msg.value / rate;
        require(currencyAmount > 0, "ETH amount too small for this currency");

        // 6. 核心记账逻辑
        totalTipReceived += msg.value; // 总小费按ETH（wei）累加
        tipperContributions[msg.sender] += msg.value; // 支付者贡献按ETH记录
        tipsPerCurrency[_currencyCode] += currencyAmount; // 按原货币单位统计
    }
    // 新增：将指定货币的金额转换为ETH（以wei为单位）
    function convertToEth(string memory _currencyCode, uint256 _amount) public view returns (uint256) {
        // 检查货币是否支持
        bool isSupported = false;
        for(uint i = 0; i < supportedCurrencies.length; i++) {
            if (keccak256(bytes(supportedCurrencies[i])) == keccak256(bytes(_currencyCode))) {
                isSupported = true;
                break;
            }
        }
        require(isSupported, "Currency not supported");

        // 获取该货币对ETH的兑换率（1单位货币 = X wei）
        uint256 rate = conversionRates[_currencyCode];
        require(rate > 0, "Invalid conversion rate");

        // 计算转换后的ETH数量（wei）：金额 * 兑换率
        uint256 ethAmount = _amount * rate;
        return ethAmount;
    }
//
    function withdrawTips() public onlyOwner {
        uint256 contractBalance = address(this).balance;//获取合约当前的余额
        require(contractBalance > 0, "No tips to withdraw");//提取资金

        (bool success, ) = payable(owner).call{value: contractBalance}("");//提取小费
        require(success, "Transfer failed");//检查 45 行的转账操作是否成功
    }

    function transferOwnership(address _newOwner) public onlyOwner { //转移合约的所有权
            require(_newOwner != address(0), "Invalid address");//检查新的所有者地址是否有效
            owner = _newOwner;
    }
//这个函数用来查看合约有多少钱，调用它就能得到合约当前的余额。
        function getSupportedCurrencies() public view returns (string[] memory) {
            return supportedCurrencies;
        }
//就是查看合约里有多少币，调用这个功能就能知道 。      
        function getContractBalance() public view returns (uint256) {
            return address(this).balance;
        }
//传入打赏者地址，返回该打赏者对应的贡献值，函数是只读的，不改变合约状态。
        function getTipperContribution(address _tipper) public view returns (uint256) {
            return tipperContributions[_tipper];
        }
//输入货币代码，就能查到这种货币有多少小费 。
        function getTipsInCurrency(string memory _currencyCode) public view returns (uint256) {
            return tipsPerCurrency[_currencyCode];
        }
//输入货币代码，就能查到它和以太坊的兑换比例 。
        function getConversionRate(string memory _currencyCode) public view returns (uint256) {
            return conversionRates[_currencyCode];
        }
 }

 