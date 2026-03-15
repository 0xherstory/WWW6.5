import{_ as W,l as $,s as Q,o as u,c as d,a as t,w as g,v,k as o,p as m,t as l,b as r,g as E,F as j,i as K,d as A,r as p,q as x}from"./index-EE7T8a7d.js";import{K as Y,F as z}from"./FullCodeModal-maEzWUm0.js";const O={class:"day-6-content"},X={class:"content-layout"},J={class:"left-column"},Z={class:"interaction-area"},ee={class:"interaction-controls"},te={class:"function-block"},se={class:"input-group label-input-row"},ne={class:"function-block"},oe={class:"input-group"},re={class:"function-block"},le={class:"input-group"},ae={class:"function-block query-block"},ie={class:"input-group label-input-row"},ue={class:"function-block query-block"},de={class:"result-display"},me={class:"result-value"},pe={class:"info-item"},be={class:"info-item"},ce={class:"info-item"},ge={class:"info-item"},ve={key:0},fe={key:1,style:{"margin-top":"10px","padding-top":"10px","border-top":"1px solid #ddd"}},q=`//SPDX-License-Identifier: MIT

// 声明Solidity版本，要求编译器版本在0.8.0或更高（但低于0.9.0）
pragma solidity ^0.8.0;

// 定义一个名为EtherPiggyBank的合约，用于以太坊存钱罐银行功能
contract EtherPiggyBank{

    // 状态变量区域
    
    // 声明银行管理员的地址
    // 银行管理员具有特殊权限，可以添加新成员
    address public bankManager;
    
    // 声明地址数组，存储所有已注册的会员地址
    address[] members;
    
    // 声明映射，记录每个地址是否已注册为会员
    // 键是地址，值是布尔值（true表示已注册，false表示未注册）
    mapping(address => bool) public registeredMembers;
    
    // 声明映射，记录每个地址的账户余额
    // 键是地址，值是该地址的余额（以wei为单位）
    mapping(address => uint256) balance;

    // 构造函数：合约部署时执行一次，初始化银行管理员
    constructor(){
        // 将部署合约的地址设置为银行管理员
        bankManager = msg.sender;
        
        // 将银行管理员添加到会员数组中（管理员默认是会员）
        members.push(msg.sender);
    }

    // 修饰符：限制只有银行管理员才能调用某些函数
    modifier onlyBankManager(){
        // 检查调用者是否为银行管理员，如果不是则回滚交易
        require(msg.sender == bankManager, "Only bank manager can perform this action");
        
        // 继续执行被修饰的函数
        _;
    }

    // 修饰符：限制只有已注册的会员才能调用某些函数
    modifier onlyRegisteredMember() {
        // 检查调用者是否为已注册的会员，如果不是则回滚交易
        require(registeredMembers[msg.sender], "Member not registered");
        
        // 继续执行被修饰的函数
        _;
    }
  
    // 添加会员函数：只有银行管理员可以调用，用于添加新会员
    function addMembers(address _member)public onlyBankManager{
        // 检查新会员地址是否有效（不能是零地址）
        require(_member != address(0), "Invalid address");
        
        // 检查是否尝试添加银行管理员本人（管理员已经是会员）
        require(_member != msg.sender, "Bank Manager is already a member");
        
        // 检查该地址是否已经是注册会员
        require(!registeredMembers[_member], "Member already registered");
        
        // 将该地址标记为已注册会员
        registeredMembers[_member] = true;
        
        // 将该地址添加到会员数组中
        members.push(_member);
    }

    // 获取会员列表函数：任何人都可以调用，返回所有会员地址
    function getMembers() public view returns(address[] memory){
        // 返回会员地址数组
        return members;
    }
    
    // 注释掉的函数：原本用于存入代币数量（不涉及以太币）
    // function depositAmount(uint256 _amount) public onlyRegisteredMember{
    //     require(_amount > 0, "Invalid amount");
    //     balance[msg.sender] = balance[msg.sender]+_amount;
   
    // }
    
    // 存入以太币函数：只有已注册会员可以调用
    // payable 关键字表示该函数可以接收以太币
    function depositAmountEther() public payable onlyRegisteredMember{  
        // 检查发送的以太币数量是否大于0
        // msg.value 是调用函数时发送的以太币数量（以wei为单位）
        require(msg.value > 0, "Invalid amount");
        
        // 将发送的以太币数量累加到调用者的余额中
        balance[msg.sender] = balance[msg.sender]+msg.value;
   
    }
    
    // 提取金额函数：只有已注册会员可以调用，用于提取余额
    function withdrawAmount(uint256 _amount) public onlyRegisteredMember{
        // 检查提取金额是否大于0
        require(_amount > 0, "Invalid amount");
        
        // 检查调用者的余额是否足够
        require(balance[msg.sender] >= _amount, "Insufficient balance");
        
        // 从调用者的余额中扣除提取的金额
        balance[msg.sender] = balance[msg.sender]-_amount;
   
    }

    // 获取余额函数：任何人都可以调用，查询指定会员的余额
    function getBalance(address _member) public view returns (uint256){
        // 检查查询的地址是否有效
        require(_member != address(0), "Invalid address");
        
        // 返回指定会员的余额
        return balance[_member];
    } 
}`,ye={__name:"EtherPiggyBank",setup(ke){const k=$(),{bankManager:h,members:P,userAddress:T,userBalance:M,queryBalance:f,membersList:w,addMembers:_,depositEther:I,withdrawEth:S,getBalance:V,getMembers:D}=Q(),a=p(""),b=p(""),c=p(""),i=p(""),y=p(!1),F=x(()=>{var s;return((s=k.dayProgress[6])==null?void 0:s.unlockedConcepts)||[]}),H=x(()=>{const s=k.dayProgress[6];return!s||s.totalConcepts===0?0:Math.floor(s.unlockedConcepts.length/s.totalConcepts*100)}),C=s=>(s/1e18).toFixed(4),N=()=>{if(!a.value.trim()){alert("请输入会员地址！");return}_(a.value)?a.value="":alert("添加会员失败！地址可能无效或已存在。")},R=()=>{const s=Number(b.value);if(!s||s<=0){alert("请输入有效的存入数量！");return}I(s)?b.value="":alert("存入失败！您可能不是注册会员。")},G=()=>{const s=Number(c.value);if(!s||s<=0){alert("请输入有效的提取数量！");return}S(s)?c.value="":alert("提取失败！余额不足或未注册。")},L=()=>{if(!i.value.trim()){alert("请输入查询地址！");return}V(i.value)},U=()=>{D()};return(s,e)=>(u(),d("div",O,[t("div",X,[t("div",J,[t("div",Z,[e[33]||(e[33]=t("h3",null,"🎮 交互操作",-1)),t("div",ee,[t("div",te,[e[13]||(e[13]=t("h4",{class:"block-title"},"👥 添加会员",-1)),e[14]||(e[14]=t("code",{class:"function-signature"},"函数：addMembers(address _member)",-1)),t("div",se,[e[12]||(e[12]=t("label",{for:"member-input"},"会员地址/Member Address：",-1)),g(t("input",{id:"member-input","onUpdate:modelValue":e[0]||(e[0]=n=>a.value=n),type:"text",placeholder:"0x...",onClick:e[1]||(e[1]=o(()=>{},["stop"]))},null,512),[[v,a.value]])]),t("button",{onClick:e[2]||(e[2]=o(n=>a.value="0x"+Array(40).fill(0).map(()=>Math.floor(Math.random()*16).toString(16)).join(""),["stop"])),class:"day-action-btn blue small"},"🎲 随机生成"),t("button",{onClick:o(N,["stop"]),class:"day-action-btn magenta"},"➕ 添加会员/AddMembers")]),t("div",ne,[e[16]||(e[16]=t("h4",{class:"block-title"},"💵 存入以太币",-1)),e[17]||(e[17]=t("code",{class:"function-signature"},"函数：depositAmountEther() payable",-1)),t("div",oe,[e[15]||(e[15]=t("label",{for:"deposit-input"},"存入数量(ETH)/Amount：",-1)),g(t("input",{id:"deposit-input","onUpdate:modelValue":e[3]||(e[3]=n=>b.value=n),type:"number",placeholder:"请输入数量",min:"0",step:"0.01",onClick:e[4]||(e[4]=o(()=>{},["stop"]))},null,512),[[v,b.value]])]),t("button",{onClick:o(R,["stop"]),class:"day-action-btn magenta"},"💰 存入ETH/DepositEther")]),t("div",re,[e[19]||(e[19]=t("h4",{class:"block-title"},"💸 提取金额",-1)),e[20]||(e[20]=t("code",{class:"function-signature"},"函数：withdrawAmount(uint256 _amount)",-1)),t("div",le,[e[18]||(e[18]=t("label",{for:"withdraw-eth-input"},"提取数量(ETH)/Amount：",-1)),g(t("input",{id:"withdraw-eth-input","onUpdate:modelValue":e[5]||(e[5]=n=>c.value=n),type:"number",placeholder:"请输入数量",min:"0",step:"0.01",onClick:e[6]||(e[6]=o(()=>{},["stop"]))},null,512),[[v,c.value]])]),t("button",{onClick:o(G,["stop"]),class:"day-action-btn green"},"💸 提取ETH/WithdrawAmount")]),t("div",ae,[e[22]||(e[22]=t("h4",{class:"block-title"},"📊 查询余额",-1)),e[23]||(e[23]=t("code",{class:"function-signature"},"函数：getBalance(address _member) returns (uint256)",-1)),t("div",ie,[e[21]||(e[21]=t("label",{for:"query-balance-input"},"查询地址/Query Address：",-1)),g(t("input",{id:"query-balance-input","onUpdate:modelValue":e[7]||(e[7]=n=>i.value=n),type:"text",placeholder:"0x...",onClick:e[8]||(e[8]=o(()=>{},["stop"]))},null,512),[[v,i.value]])]),t("button",{onClick:e[9]||(e[9]=o(n=>i.value="0x"+Array(40).fill(0).map(()=>Math.floor(Math.random()*16).toString(16)).join(""),["stop"])),class:"day-action-btn blue small",style:{"margin-bottom":"10px"}},"🎲 随机生成"),t("button",{onClick:o(L,["stop"]),class:"day-action-btn cyan"},"📊 查询余额/GetBalance")]),t("div",ue,[e[24]||(e[24]=t("h4",{class:"block-title"},"📋 查询会员",-1)),e[25]||(e[25]=t("code",{class:"function-signature"},"函数：getMembers() returns (address[])",-1)),t("button",{onClick:o(U,["stop"]),class:"day-action-btn cyan"},"📋 获取会员列表/GetMembers")])]),t("div",de,[e[32]||(e[32]=t("h4",null,"🏦 银行状态",-1)),t("div",me,[t("div",pe,[e[26]||(e[26]=t("strong",null,"银行管理员/Bank Manager：",-1)),m(l(r(h)||"未初始化"),1)]),t("div",be,[e[27]||(e[27]=t("strong",null,"会员数量/Members Count：",-1)),m(l(r(P).length),1)]),t("div",ce,[e[28]||(e[28]=t("strong",null,"当前用户地址/Your Address：",-1)),m(l(r(T)),1)]),t("div",ge,[e[29]||(e[29]=t("strong",null,"您的余额/Your Balance：",-1)),m(l(C(r(M)))+" ETH ("+l(r(M))+" wei)",1)]),r(f)!==null?(u(),d("div",ve,[e[30]||(e[30]=t("strong",null,"查询结果/Query Result：",-1)),m(l(C(r(f)))+" ETH ("+l(r(f))+" wei)",1)])):E("",!0),r(w).length>0?(u(),d("div",fe,[e[31]||(e[31]=t("strong",null,"会员列表/Members List：",-1)),(u(!0),d(j,null,K(r(w),(n,B)=>(u(),d("div",{key:B,style:{"margin-left":"10px","font-size":"12px"}},l(B+1)+". "+l(n),1))),128))])):E("",!0)])])])]),A(Y,{"current-day":6,"unlocked-concepts":F.value,"progress-percentage":H.value,"full-code":q,onShowFullCode:e[10]||(e[10]=n=>y.value=!0)},null,8,["unlocked-concepts","progress-percentage"])]),A(z,{show:y.value,title:"EtherPiggyBank 完整代码",code:q,onClose:e[11]||(e[11]=n=>y.value=!1)},null,8,["show"])]))}},Ce=W(ye,[["__scopeId","data-v-926d58ee"]]);export{Ce as default};
