import{_ as Y,l as B,m as j,o as G,c as K,a as e,w as p,v as w,b as r,k as s,n as m,p as c,t as v,d as y,q as A,r as E}from"./index-EE7T8a7d.js";import{K as L,F as X}from"./FullCodeModal-maEzWUm0.js";const z={class:"day-5-content"},H={class:"content-layout"},J={class:"left-column"},Q={class:"interaction-area"},Z={class:"interaction-controls"},_={class:"function-block"},tt={class:"input-group"},et={class:"function-block"},nt={class:"input-group label-input-row"},ot={class:"input-group"},st={class:"function-block"},rt={class:"input-group"},lt={class:"function-block"},at={class:"input-group label-input-row"},ut={class:"function-block query-block"},it={class:"result-display"},dt={class:"result-value"},k=`// SPDX-License-Identifier: MIT
// 声明Solidity版本，要求编译器版本在0.8.0或更高（但低于0.9.0）
pragma solidity ^0.8.0;

// 定义一个名为AdminOnly的合约，用于管理员权限控制的宝库管理
contract AdminOnly {
    // 状态变量区域
    
    // 声明公共地址变量，存储合约所有者的地址
    address public owner;
    
    // 声明公共无符号整数，存储宝库中的宝藏数量
    uint256 public treasureAmount;
    
    // 声明映射，存储每个地址的提款额度
    // 键是地址，值是该地址允许提取的宝藏数量
    mapping(address => uint256) public withdrawalAllowance;
    
    // 声明映射，记录每个地址是否已经提取过宝藏
    // 键是地址，值是布尔值（true表示已提取，false表示未提取）
    mapping(address => bool) public hasWithdrawn;
    
    // 构造函数：合约部署时执行一次，将部署者设置为所有者
    constructor() {
        owner = msg.sender;
    }
    
    // 修饰符：用于限制只有所有者才能调用某些函数
    // modifier 可以理解为函数的"前置条件检查"
    modifier onlyOwner() {
        // 检查调用者是否为所有者，如果不是则回滚交易并显示错误信息
        require(msg.sender == owner, "Access denied: Only the owner can perform this action");
        
        // _; 表示执行修饰符后的函数体
        // 这是修饰符的语法，表示"通过检查后，继续执行被修饰的函数"
        _;
    }
    
    // 添加宝藏函数：只有所有者可以调用
    // onlyOwner 修饰符确保只有所有者能执行此函数
    function addTreasure(uint256 amount) public onlyOwner {
        // 将指定数量的宝藏添加到宝库中
        treasureAmount += amount;
    }
    
    // 批准提款函数：只有所有者可以调用，用于给用户分配提款额度
    function approveWithdrawal(address recipient, uint256 amount) public onlyOwner {
        // 检查批准的额度是否不超过宝库中现有的宝藏数量
        require(amount <= treasureAmount, "Not enough treasure available");
        
        // 为指定地址设置提款额度
        withdrawalAllowance[recipient] = amount;
    }
    
    
    // 提取宝藏函数：任何人都可以调用，但只有有额度且未提取过的用户才能成功
    function withdrawTreasure(uint256 amount) public {

        // 如果调用者是所有者，允许直接提取任意数量（在宝库范围内）
        if(msg.sender == owner){
            // 检查提取数量是否不超过宝库现有数量
            require(amount <= treasureAmount, "Not enough treasury available for this action.");
            
            // 从宝库中扣除指定数量的宝藏
            treasureAmount-= amount;

            // 直接返回，不执行后面的普通用户提款逻辑
            return;
        }
        
        // 获取调用者的提款额度
        uint256 allowance = withdrawalAllowance[msg.sender];
        
        // 检查用户是否有提款额度（额度必须大于0）
        require(allowance > 0, "You don't have any treasure allowance");
        
        // 检查用户是否已经提取过宝藏（不能重复提取）
        require(!hasWithdrawn[msg.sender], "You have already withdrawn your treasure");
        
        // 检查宝库中是否有足够的宝藏
        require(allowance <= treasureAmount, "Not enough treasure in the chest");
        
        // 检查用户尝试提取的数量是否不超过其允许的额度
        require(allowance >= amount, "Cannot withdraw more than you are allowed");
        
        // 标记该用户已经提取过宝藏
        hasWithdrawn[msg.sender] = true;
        
        // 从宝库中扣除用户额度对应的宝藏数量
        treasureAmount -= allowance;
        
        // 将用户的提款额度清零
        withdrawalAllowance[msg.sender] = 0;
        
    }
    
    // 重置提款状态函数：只有所有者可以调用，用于重置某个用户的提款状态
    function resetWithdrawalStatus(address user) public onlyOwner {
        // 将指定用户的提款状态重置为false（允许再次提取）
        hasWithdrawn[user] = false;
    }
    
    // 转移所有权函数：只有所有者可以调用，用于将合约所有权转移给新所有者
    function transferOwnership(address newOwner) public onlyOwner {
        // 检查新所有者地址是否有效（不能是零地址）
        // address(0) 表示零地址，是一个无效的地址
        require(newOwner != address(0), "Invalid address");
        
        // 将所有者更新为新地址
        owner = newOwner;
    }
    
    // 获取宝藏详情函数：只有所有者可以调用，查看宝库中的宝藏数量
    function getTreasureDetails() public view onlyOwner returns (uint256) {
        // 返回宝库中的宝藏数量
        return treasureAmount;
    }
}`,pt={__name:"AdminOnly",setup(wt){const g=B(),{inputTreasureAmount:u,inputRecipient:l,inputAllowance:i,inputWithdrawAmount:d,inputNewOwner:a,owner:O,treasureAmount:h,userAddress:f,userAllowance:C,hasWithdrawn:T,addTreasure:W,approveWithdrawal:S,withdrawTreasure:x,resetWithdrawalStatus:N,transferOwnership:q,getTreasureDetails:D}=j(),b=E(!1),M=A(()=>{var n;return((n=g.dayProgress[5])==null?void 0:n.unlockedConcepts)||[]}),V=A(()=>{const n=g.dayProgress[5];return!n||n.totalConcepts===0?0:Math.floor(n.unlockedConcepts.length/n.totalConcepts*100)}),P=()=>{const n=Number(u.value);if(!n||n<=0){alert("请输入有效的宝藏数量！");return}W(n),u.value=""},R=()=>{if(!l.value.trim()){alert("请输入用户地址！");return}const n=Number(i.value);if(!n||n<=0){alert("请输入有效的提款额度！");return}S(l.value,n),l.value="",i.value=""},U=()=>{const n=Number(d.value);if(!n||n<=0){alert("请输入有效的提取数量！");return}x(f.value,n),d.value=""},$=()=>{N(f.value)},F=()=>{if(!a.value.trim()){alert("请输入新所有者地址！");return}q(a.value),a.value=""},I=()=>{const n=D();alert(`📊 宝藏详情

当前宝藏数量: ${n}`)};return(n,t)=>(G(),K("div",z,[e("div",H,[e("div",J,[e("div",Q,[t[36]||(t[36]=e("h3",null,"🎮 交互操作",-1)),e("div",Z,[e("div",_,[t[15]||(t[15]=e("h4",{class:"block-title"},"💎 添加宝藏",-1)),t[16]||(t[16]=e("code",{class:"function-signature"},"函数：addTreasure(uint256 amount)",-1)),e("div",tt,[t[14]||(t[14]=e("label",{for:"treasure-input"},"添加宝藏数量/Amount：",-1)),p(e("input",{id:"treasure-input","onUpdate:modelValue":t[0]||(t[0]=o=>m(u)?u.value=o:null),type:"number",placeholder:"请输入数量",onClick:t[1]||(t[1]=s(()=>{},["stop"]))},null,512),[[w,r(u)]])]),e("button",{onClick:s(P,["stop"]),class:"day-action-btn yellow"},"➕ 添加宝藏/AddTreasure")]),e("div",et,[t[19]||(t[19]=e("h4",{class:"block-title"},"✅ 批准提款",-1)),t[20]||(t[20]=e("code",{class:"function-signature"},"函数：approveWithdrawal(address recipient, uint256 amount)",-1)),e("div",nt,[t[17]||(t[17]=e("label",{for:"recipient-input"},"用户地址/Recipient：",-1)),p(e("input",{id:"recipient-input","onUpdate:modelValue":t[2]||(t[2]=o=>m(l)?l.value=o:null),type:"text",placeholder:"0x...",onClick:t[3]||(t[3]=s(()=>{},["stop"]))},null,512),[[w,r(l)]])]),e("button",{onClick:t[4]||(t[4]=s(o=>l.value="0x"+Array(40).fill(0).map(()=>Math.floor(Math.random()*16).toString(16)).join(""),["stop"])),class:"day-action-btn blue small",style:{"margin-bottom":"10px"}},"🎲 随机生成"),e("div",ot,[t[18]||(t[18]=e("label",{for:"allowance-input"},"提款额度/Allowance：",-1)),p(e("input",{id:"allowance-input","onUpdate:modelValue":t[5]||(t[5]=o=>m(i)?i.value=o:null),type:"number",placeholder:"请输入额度",onClick:t[6]||(t[6]=s(()=>{},["stop"]))},null,512),[[w,r(i)]])]),e("button",{onClick:s(R,["stop"]),class:"day-action-btn yellow"},"✅ 批准提款/ApproveWithdrawal")]),e("div",st,[t[22]||(t[22]=e("h4",{class:"block-title"},"💰 提取宝藏",-1)),t[23]||(t[23]=e("code",{class:"function-signature"},"函数：withdrawTreasure(uint256 amount)",-1)),e("div",rt,[t[21]||(t[21]=e("label",{for:"withdraw-input"},"提取数量/Amount：",-1)),p(e("input",{id:"withdraw-input","onUpdate:modelValue":t[7]||(t[7]=o=>m(d)?d.value=o:null),type:"number",placeholder:"请输入数量",onClick:t[8]||(t[8]=s(()=>{},["stop"]))},null,512),[[w,r(d)]])]),e("button",{onClick:s(U,["stop"]),class:"day-action-btn green"},"💰 提取宝藏/WithdrawTreasure"),e("button",{onClick:s($,["stop"]),class:"day-action-btn orange"},"🔄 重置提款状态/ResetStatus"),t[24]||(t[24]=e("code",{class:"function-signature"},"函数：resetWithdrawalStatus(address user)",-1))]),e("div",lt,[t[26]||(t[26]=e("h4",{class:"block-title"},"🔐 转移所有权",-1)),t[27]||(t[27]=e("code",{class:"function-signature"},"函数：transferOwnership(address newOwner)",-1)),e("div",at,[t[25]||(t[25]=e("label",{for:"new-owner-input"},"新所有者地址/New Owner：",-1)),p(e("input",{id:"new-owner-input","onUpdate:modelValue":t[9]||(t[9]=o=>m(a)?a.value=o:null),type:"text",placeholder:"0x...",onClick:t[10]||(t[10]=s(()=>{},["stop"]))},null,512),[[w,r(a)]])]),e("button",{onClick:t[11]||(t[11]=s(o=>a.value="0x"+Array(40).fill(0).map(()=>Math.floor(Math.random()*16).toString(16)).join(""),["stop"])),class:"day-action-btn blue small"},"🎲 随机生成"),e("button",{onClick:s(F,["stop"]),class:"day-action-btn red"},"🔐 转移所有权/TransferOwnership")]),e("div",ut,[t[28]||(t[28]=e("h4",{class:"block-title"},"📊 查询操作",-1)),t[29]||(t[29]=e("code",{class:"function-signature"},"函数：getTreasureDetails() returns (uint256)",-1)),e("button",{onClick:s(I,["stop"]),class:"day-action-btn cyan"},"📊 获取宝藏详情/GetDetails")])]),e("div",it,[t[35]||(t[35]=e("h4",null,"🏆 宝库状态",-1)),e("div",dt,[e("div",null,[t[30]||(t[30]=e("strong",null,"所有者/Owner：",-1)),c(v(r(O)||"未初始化"),1)]),e("div",null,[t[31]||(t[31]=e("strong",null,"宝藏数量/Treasure：",-1)),c(v(r(h)),1)]),e("div",null,[t[32]||(t[32]=e("strong",null,"当前用户地址/Your Address：",-1)),c(v(r(f)),1)]),e("div",null,[t[33]||(t[33]=e("strong",null,"提款额度/Allowance：",-1)),c(v(r(C)||0),1)]),e("div",null,[t[34]||(t[34]=e("strong",null,"已提取/Withdrawn：",-1)),c(v(r(T)?"是/Yes":"否/No"),1)])])])])]),y(L,{"current-day":5,"unlocked-concepts":M.value,"progress-percentage":V.value,"full-code":k,onShowFullCode:t[12]||(t[12]=o=>b.value=!0)},null,8,["unlocked-concepts","progress-percentage"])]),y(X,{show:b.value,title:"AdminOnly 完整代码",code:k,onClose:t[13]||(t[13]=o=>b.value=!1)},null,8,["show"])]))}},vt=Y(pt,[["__scopeId","data-v-288e277f"]]);export{vt as default};
