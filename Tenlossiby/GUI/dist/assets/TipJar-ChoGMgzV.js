import{_ as z,l as K,y as Y,o as u,c as a,a as t,z as v,b as o,F as E,i as k,t as l,p as h,w as C,v as P,k as d,A as $,g as f,d as H,r as p,q as R}from"./index-EE7T8a7d.js";import{K as j,F as X}from"./FullCodeModal-maEzWUm0.js";const G={class:"day-8-content"},Q={class:"content-layout"},Z={class:"left-column"},ee={class:"interaction-area"},te={class:"identity-toggle-bar"},ne={class:"toggle-buttons"},se={class:"function-block"},re={class:"currency-grid"},oe={class:"cur-name"},ie={class:"cur-val"},ue={class:"input-row"},ae={class:"input-group"},le={class:"input-row"},ce={class:"input-group"},de=["value"],pe={class:"input-group"},ve={key:0,class:"admin-warning"},me={key:0,class:"admin-warning"},ye={class:"result-display"},ge={class:"jar-status"},be={class:"status-item main"},Ce={class:"value"},fe={class:"status-item"},we={class:"value address-val"},Te={class:"status-item"},_e={class:"value address-val"},A=`//SPDX-License-Identifier: MIT
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

    // 提现函数：该合约内有各种收到别人转进来的以太币资产，这个方法用于管理员将里面资金"转出"给管理员自己
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
}`,Ee={__name:"TipJar",setup(ke){const w=K(),{owner:I,userAddress:S,isAdmin:c,totalTips:q,supportedCurrencies:O,conversionRates:U,tipJarToggleAdmin:J,tipJarTipInEth:x,tipJarTipInCurrency:D,tipJarWithdraw:M,formatBalance:N}=Y(),m=p(""),g=p("USD"),y=p(""),r=p(""),i=p(!1),b=p(!1),B=R(()=>{var n;return((n=w.dayProgress[8])==null?void 0:n.unlockedConcepts)||[]}),F=R(()=>{const n=w.dayProgress[8];return!n||n.totalConcepts===0?0:Math.floor(n.unlockedConcepts.length/n.totalConcepts*100)}),T=()=>{J()},V=()=>{const n=Number(m.value);if(!n||n<=0){r.value="❌ 请输入有效的打赏数量！",i.value=!0;return}x(n),r.value="✅ 打赏成功！",i.value=!1,m.value="",setTimeout(()=>{r.value=""},3e3)},W=()=>{const n=Number(y.value);if(!n||n<=0){r.value="❌ 请输入有效的金额！",i.value=!0;return}D(g.value,n)?(r.value="✅ 按汇率打赏成功！",i.value=!1,y.value=""):(r.value="❌ 打赏失败！",i.value=!0),setTimeout(()=>{r.value=""},3e3)},L=()=>{const n=M();n===!0?(r.value="✅ 提现成功！",i.value=!1):(r.value="❌ "+n,i.value=!0),setTimeout(()=>{r.value=""},3e3)};return(n,e)=>(u(),a("div",G,[t("div",Q,[t("div",Z,[t("div",ee,[e[20]||(e[20]=t("h3",null,"🎮 交互操作",-1)),t("div",te,[e[8]||(e[8]=t("span",{class:"identity-label"},"🎭 当前身份：",-1)),t("div",ne,[t("button",{class:v({active:!o(c)}),onClick:T},"👤 用户/User",2),t("button",{class:v({active:o(c)}),onClick:T},"👑 管理员/Admin",2)])]),t("div",se,[e[9]||(e[9]=t("h4",{class:"block-title"},"💹 汇率预览 (Mapping)",-1)),e[10]||(e[10]=t("code",{class:"function-signature"},"mapping(string => uint256) public conversionRates;",-1)),t("div",re,[(u(!0),a(E,null,k(o(U),(s,_)=>(u(),a("div",{key:_,class:"currency-card"},[t("span",oe,l(_),1),t("span",ie,l((s/1e18).toFixed(5))+" ETH",1)]))),128))])]),t("div",{class:v(["function-block",{"inactive-block":o(c)}])},[e[14]||(e[14]=t("h4",{class:"block-title"},"💰 投币打赏 (Act 2: Payable)",-1)),e[15]||(e[15]=t("div",{class:"function-signature"},[h(" 函数：tipInEth() public payable"),t("br"),h(" 函数：tipInCurrency(string _currency, uint256 _amount) payable ")],-1)),t("div",ue,[t("div",ae,[e[11]||(e[11]=t("label",null,"打赏 ETH 数量：",-1)),C(t("input",{"onUpdate:modelValue":e[0]||(e[0]=s=>m.value=s),type:"number",step:"0.01",min:"0",onClick:e[1]||(e[1]=d(()=>{},["stop"]))},null,512),[[P,m.value]])]),t("button",{onClick:d(V,["stop"]),class:"day-action-btn cyan"},"💎 直接打赏 ETH")]),e[16]||(e[16]=t("div",{class:"divider"},"或者按法币换算",-1)),t("div",le,[t("div",ce,[e[12]||(e[12]=t("label",null,"选择币种：",-1)),C(t("select",{"onUpdate:modelValue":e[2]||(e[2]=s=>g.value=s),onClick:e[3]||(e[3]=d(()=>{},["stop"]))},[(u(!0),a(E,null,k(o(O),s=>(u(),a("option",{key:s,value:s},l(s),9,de))),128))],512),[[$,g.value]])]),t("div",pe,[e[13]||(e[13]=t("label",null,"金额：",-1)),C(t("input",{"onUpdate:modelValue":e[4]||(e[4]=s=>y.value=s),type:"number",min:"1",onClick:e[5]||(e[5]=d(()=>{},["stop"]))},null,512),[[P,y.value]])]),t("button",{onClick:d(W,["stop"]),class:"day-action-btn cyan"},"🔥 按汇率打赏")]),o(c)?(u(),a("p",ve,"⚠️ 当前是管理员模式，请切回用户进行打赏体验")):f("",!0)],2),t("div",{class:v(["function-block admin-only",{"inactive-block":!o(c)}])},[e[17]||(e[17]=t("h4",{class:"block-title"},"🏦 金库管理 (Act 3: Admin)",-1)),e[18]||(e[18]=t("code",{class:"function-signature"},"函数：withdrawTips() public onlyOwner",-1)),e[19]||(e[19]=t("p",{class:"admin-hint"},"只有合约拥有者(Owner)可以提取累积的打赏金。",-1)),t("button",{onClick:d(L,["stop"]),class:"day-action-btn red"},"🔓 提取全部打赏 (Withdraw)"),o(c)?f("",!0):(u(),a("p",me,"⚠️ 只有管理员可以操作此区块"))],2),r.value?(u(),a("div",{key:0,class:v(["tip-message",{error:i.value}])},l(r.value),3)):f("",!0)]),t("div",ye,[e[24]||(e[24]=t("h4",null,"🍯 打赏罐实时状态",-1)),t("div",ge,[t("div",be,[e[21]||(e[21]=t("span",{class:"label"},"金库总余额 (ETH)",-1)),t("span",Ce,l(o(N)(o(q))),1)]),t("div",fe,[e[22]||(e[22]=t("span",{class:"label"},"管理员地址：",-1)),t("span",we,l(o(I)),1)]),t("div",Te,[e[23]||(e[23]=t("span",{class:"label"},"你的地址：",-1)),t("span",_e,l(o(S)),1)])])])]),H(j,{"current-day":8,"unlocked-concepts":B.value,"progress-percentage":F.value,"full-code":A,onShowFullCode:e[6]||(e[6]=s=>b.value=!0)},null,8,["unlocked-concepts","progress-percentage"])]),H(X,{show:b.value,title:"TipJar 完整代码",code:A,onClose:e[7]||(e[7]=s=>b.value=!1)},null,8,["show"])]))}},He=z(Ee,[["__scopeId","data-v-e511f5f1"]]);export{He as default};
