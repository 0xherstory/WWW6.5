// SPDX-License-Identifier:MIT

pragma solidity ^0.8.0;

//创建一个自助打赏系统
//谁创建谁是管理员，合约初始需包含 用户地址，累计的打赏金额，不同人给的打赏金额，不同货币下的打赏金额，不同货币的汇率
// 管理员权限：添加和新增货币；权限转移；提现打赏金额
// 普通人权限：查看货币汇率，谁在打赏，打赏的金额，总打赏金额，进行打赏（直接打赏，需汇率转换），汇率转换（可查看）

contract TipsJar{

    address public owner;
    uint256 public TotalTips;

    mapping(address => uint256) public TotalTipsList; //不同用户下的打赏金额
    mapping(string => uint256) public TipsCurrencylist;// 不同货币下的打赏金额
    string[] public supportsCurrency;// 货币列表
    mapping(string => uint256) public CurrencyRates;// 不同货币的汇率

    constructor() {
        owner = msg.sender;
        addCurrency("USD",5 * 10** 4);
        addCurrency("EUR", 6 * 10**14);
        addCurrency("INR", 7 * 10**12);
        addCurrency("JPY", 4 * 10**12);
    }
    modifier onlyOwner() {
        require( msg.sender == owner, "Only owner can perform this action");
        _;
    }

    //添加货币
    function addCurrency(string memory _currency, uint256 _rates) public onlyOwner() {
        require(_rates > 0, "Conversion rate must be greater than 0");

        bool isCurrency = false; // 像一张白纸，等待被"染色",如果是true,就是写满了

        for (uint256 i = 0; i < supportsCurrency.length; i++) {
            if (keccak256(bytes(supportsCurrency[i])) == keccak256(bytes(_currency))) {
                isCurrency = true;
                break; // 逐一扫描，找到了对应货币，结束
            }
            }
            if (!isCurrency) {
                supportsCurrency.push(_currency);
            }
            CurrencyRates[_currency] = _rates;// 没有找到，填写对应的货币和汇率
            }
        

    
    // 汇率转换
    function transferRate(string memory _currency, uint256 _amount) public view returns(uint256) {
        require(CurrencyRates[_currency] > 0 ,"Currency not supported");
        require(_amount > 0 , "Amount must be greater than 0");
        uint256 ethAmount = CurrencyRates[_currency] * _amount;
        return ethAmount;
    }

    // 别人如何打赏，直接打赏，或汇率转换打赏

    function Intips() public payable {
        require(msg.value > 0 ,"Amount must be greater than 0 ");
        TotalTips += msg.value;
        TotalTipsList[msg.sender] += msg.value;
        TipsCurrencylist["ETH"] += msg.value;
        
    }

    function Mediumtips(string memory _currencyTypes, uint256 _amount) public payable {
        require(CurrencyRates[_currencyTypes] > 0,"Currency not supported" );
        require(_amount > 0,"Amount must be greater than 0");
        uint256 ethAmount = transferRate(_currencyTypes, _amount);

        require(msg.value == ethAmount,"Sent ETH doesn't match the converted amount");

        TotalTips += msg.value;
        TotalTipsList[msg.sender] += msg.value ;
        TipsCurrencylist[_currencyTypes] += msg.value;
        
    }

    //提取所有消费
    function withdrawalTips() public onlyOwner {
        uint256 TipsBalance = address(this).balance;

        require(TipsBalance > 0,"No tips to withdraw");
       ( bool success , ) = payable(owner).call{value: TipsBalance}("");

       require(success,"Transfer failed");
       TotalTips = 0;
    }
    //转移所有权
    function transferRight(address _newOwner) public onlyOwner{
        require(_newOwner != address(0),"Invalid address");
        owner = _newOwner;
    }
    //查询货币汇率，谁在打赏，打赏的金额，总打赏金额
    //查询货币类型
    function getSupportCurency() public view returns(string[] memory){
        return supportsCurrency;
    }
    //查询账户余额
    function Tipsbalance() public view returns(uint256){
        return address(this).balance;
    }

    //查询指定用户打赏金额
    function getUser(address  _user) public view returns(uint256){
        return TotalTipsList[_user];
    }
    // 查询货币对应汇率
    function getCurrencyRate(string memory _currency) public view returns(uint256){
        require(CurrencyRates[_currency] > 0,"Currency not supported");
        return CurrencyRates[_currency];
    }
    //查询指定货币的打赏金额
    function getDifCurrenyAmount(string memory _currency) public view returns(uint256){
        return TipsCurrencylist[_currency];
    }
}