//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

//本项目：基于区块链的多币种打赏智能合约，支持两种方式打赏：ETH/法币

contract TipJar{
    //需要的数据结构
    address public owner;

    //各币种兑ETH的汇率
    mapping (string => uint256) public conversionRates;
   
   //支持的货币列表
    string[] public supportedCurrencies;

    //合约累计收到的ETH总打赏额
    uint256 public totalTipsReceived;

    //每个用户的累计ETH打赏额
    mapping (address => uint256) public  tipperContributions;

    //每种法币的打赏额
   mapping (string => uint256) public tipsPerCurrency;    

   constructor() {
    owner = msg.sender;

    addCurrency("USD", 5 * 10**14);
    addCurrency("EUR", 6 * 10**14);
    addCurrency("JPY", 4 * 10**12);
    addCurrency("GBP", 7 * 10**14);
}

   //管理员权限
   modifier onlyOwner(){
    require(msg.sender == owner,"Only owner can perform this action");
    _;
   }

   //添加/更新货币以及汇率
   //货币本来就存在，只需要更新，不存在则先将货币加入支持列表
   function addCurrency(string  memory _currencyCode, uint256 _rateToEth) public onlyOwner{
      //1.汇率>0
      require(_rateToEth > 0, "Rate must be greater than zero");
      //状态变量用来判断货币是否存在
      bool currencyExists = false;
      //查看货币是否存在，遍历货币列表
      for(uint256 i = 0; i < supportedCurrencies.length; i++){
         if(keccak256(bytes(supportedCurrencies[i])) == keccak256(bytes(_currencyCode))){
            currencyExists = true;
            break;
         }
      }
      //如果货币存在，更新汇率
      if(currencyExists){
         conversionRates[_currencyCode] = _rateToEth;
      }else{
         //如果货币不存在先加入列表
         supportedCurrencies.push(_currencyCode);
         //在加入汇率
         conversionRates[_currencyCode] = _rateToEth;
      }
      
   }
    
   //法定金额转换成ETH
   //参数类型 函数参数的默认数据位置	
   //数值类型（uint/int/address/bool等）calldata（外部函数）/memory（内部函数）数值类型是「值类型」，直接存储值，无需手动标注位置；
   //引用类型（string/array/struct/mapping等）无默认（必须显式标注)引用类型是「复杂类型」，需要明确告诉 EVM 数据存在哪里（memory/calldata/storage）；
   function convertToETH(string memory _currencyCode,uint256 _amount) public view returns (uint256){
      //1.汇率>0 
       require(conversionRates[_currencyCode] > 0,"Currency not supported");
        uint256 ethAmount = _amount * conversionRates[_currencyCode];
        return ethAmount;
   }
   

   //直接 ETH 打赏
   //打赏的 ETH 金额已经通过以太坊交易本身的 msg.value 传递，无需额外参数输入
   //msg.value 的单位是 wei（1 ETH = 10^18 wei），是 Solidity 内置的、全局可用的变量。
   function tipInEth() public payable {
    require(msg.value >0,"Tip amount must be greater than 0");
    tipperContributions[msg.sender] += msg.value;
    totalTipsReceived += msg.value;
    tipsPerCurrency["ETH"] += msg.value;
   }
   
   //用法币打赏
   function tipInCurrency(string memory _currencyCode,uint256 _amount) public payable {
     require(conversionRates[_currencyCode]>0,"Currency not supported");
     require(_amount >0,"Tip amount must be greater than 0");

     uint256 ethAmount = convertToETH(_currencyCode, _amount);
     //  msg.value 即随交易发送的实际 ETH）是否与预期金额匹配
     require(msg.value == ethAmount,"Insufficient ETH sent for the tip");
     tipperContributions[msg.sender] += msg.value;
     totalTipsReceived += msg.value;
     tipsPerCurrency["_currencyCode"] += _amount;
   }
   
   //提取合约 ETH	
   function withdrawTips() public onlyOwner {
    // 1. 获取合约当前的ETH余额,address(this).balance获取合约当前的 ETH 余额
    uint256 contractBalance = address(this).balance;
    // 2. 校验余额>0，避免无意义的提现操作
    require(contractBalance > 0, "No tips to withdraw");
    // 3. 把合约余额全部转账给所有者
    (bool success, ) = payable(owner).call{value: contractBalance}("");
    // 4. 校验转账是否成功
    require(success, "Transfer failed");
    // 5. 重置总打赏额为0（提现后清空统计）
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
    return tipperContributions[_tipper];
}

function getTipsInCurrency(string memory _currencyCode) public view returns (uint256) {
    return tipsPerCurrency[_currencyCode];
}

function getConversionRate(string memory _currencyCode) public view returns (uint256) {
    require(conversionRates[_currencyCode] > 0, "Currency not supported");
    return conversionRates[_currencyCode];
}




}