import{_ as ne,l as se,x as oe,o as l,c as i,a as t,w as p,v as m,k as o,p as b,b as r,t as a,g as C,F as D,i as M,d as V,r as u,q as O}from"./index-EE7T8a7d.js";import{K as re,F as le}from"./FullCodeModal-maEzWUm0.js";const ie={class:"day-7-content"},ae={class:"content-layout"},ue={class:"left-column"},de={class:"interaction-area"},pe={class:"interaction-controls"},me={class:"function-block"},ce={class:"input-group label-input-row"},be={class:"function-block"},fe={class:"input-group"},ve={class:"function-block"},ge={class:"input-group"},ye={class:"input-group"},ke={class:"function-block"},Ce={class:"input-group"},we={class:"input-group"},_e={class:"function-block"},Ae={class:"input-group"},Fe={class:"input-group"},qe={class:"button-group"},xe={class:"function-block query-block"},Te={class:"input-group"},Ie={class:"button-group"},De={key:0,class:"balance-result"},Me={class:"result-display"},Ee={class:"result-value"},Ue={class:"info-item"},Se={class:"info-item"},Ve={class:"info-item"},Oe={key:0,class:"sub-section"},Re={key:1,class:"sub-section debts-section"},He={key:0,class:"list-item"},Be={key:0,class:"list-item credit-item"},R=`//SPDX-License-Identifier: MIT

// 声明Solidity版本，要求编译器版本在0.8.0或更高（但低于0.9.0）
pragma solidity ^0.8.0;

// 定义一个名为SimpleIOU的合约，用于朋友间的借条（IOU）管理
contract SimpleIOU{
    // 声明合约所有者的地址
    address public owner;
    
    // 跟踪已注册的朋友
    // 映射：地址 -> 是否已注册（布尔值）
    mapping(address => bool) public registeredFriends;
    
    // 地址数组：存储所有已注册朋友的地址列表
    address[] public friendList;
    
    // 跟踪每个朋友的余额
    // 映射：地址 -> 余额（以太币数量）
    mapping(address => uint256) public balances;
    
    // 简单的债务跟踪系统
    // 嵌套映射：债务人地址 -> 债权人地址 -> 欠款金额
    // 映射结构：mapping(键1 => mapping(键2 => 值))
    mapping(address => mapping(address => uint256)) public debts; // 债务人 -> 债权人 -> 金额
    
    // 构造函数：合约部署时执行一次，初始化合约
    constructor() {
        // 将部署合约的地址设置为所有者
        owner = msg.sender;
        
        // 将所有者注册为朋友（所有者默认是已注册用户）
        registeredFriends[msg.sender] = true;
        
        // 将所有者添加到朋友列表中
        friendList.push(msg.sender);
    }
    
    // 修饰符：限制只有所有者才能调用某些函数
    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can perform this action");
        _;
    }
    
    // 修饰符：限制只有已注册的朋友才能调用某些函数
    modifier onlyRegistered() {
        require(registeredFriends[msg.sender], "You are not registered");
        _;
    }
    
    // 添加新朋友函数：只有所有者可以调用，用于注册新朋友
    function addFriend(address _friend) public onlyOwner {
        // 检查朋友地址是否有效（不能是零地址）
        require(_friend != address(0), "Invalid address");
        
        // 检查该朋友是否已经注册
        require(!registeredFriends[_friend], "Friend already registered");
        
        // 将该地址标记为已注册朋友
        registeredFriends[_friend] = true;
        
        // 将该地址添加到朋友列表中
        friendList.push(_friend);
    }
    
    // 存款函数：将以太币存入你的钱包余额
    // payable 关键字表示该函数可以接收以太币
    function depositIntoWallet() public payable onlyRegistered {
        // 检查是否发送了以太币
        require(msg.value > 0, "Must send ETH");
        
        // 将发送的以太币数量累加到调用者的余额中
        balances[msg.sender] += msg.value;
    }
    
    // 记录债务函数：记录某人欠你钱
    function recordDebt(address _debtor, uint256 _amount) public onlyRegistered {
        // 检查债务人地址是否有效
        require(_debtor != address(0), "Invalid address");
        
        // 检查债务人是否已注册
        require(registeredFriends[_debtor], "Address not registered");
        
        // 检查金额是否大于0
        require(_amount > 0, "Amount must be greater than 0");
        
        // 记录债务：在嵌套映射中增加债务金额
        // 结构：debts[债务人][债权人] += 金额
        debts[_debtor][msg.sender] += _amount;
    }
    
    // 使用内部余额转账偿还债务
    function payFromWallet(address _creditor, uint256 _amount) public onlyRegistered {
        // 检查债权人地址是否有效
        require(_creditor != address(0), "Invalid address");
        
        // 检查债权人是否已注册
        require(registeredFriends[_creditor], "Creditor not registered");
        
        // 检查金额是否大于0
        require(_amount > 0, "Amount must be greater than 0");
        
        // 检查债务金额是否足够
        require(debts[msg.sender][_creditor] >= _amount, "Debt amount incorrect");
        
        // 检查余额是否足够
        require(balances[msg.sender] >= _amount, "Insufficient balance");
        
        // 更新余额和债务
        // 从债务人的余额中扣除金额
        balances[msg.sender] -= _amount;
        
        // 将金额添加到债权人的余额中
        balances[_creditor] += _amount;
        
        // 从债务记录中减少债务金额
        debts[msg.sender][_creditor] -= _amount;
    }
    
    // 直接转账方法：使用 transfer() 方法进行以太币转账
    function transferEther(address payable _to, uint256 _amount) public onlyRegistered {
        // 检查接收者地址是否有效
        require(_to != address(0), "Invalid address");
        
        // 检查接收者是否已注册
        require(registeredFriends[_to], "Recipient not registered");
        
        // 检查余额是否足够
        require(balances[msg.sender] >= _amount, "Insufficient balance");
        
        // 从发送者的余额中扣除金额
        balances[msg.sender] -= _amount;
        
        // 使用 transfer() 方法将以太币转账给接收者
        // transfer() 是一个安全的转账方法，会自动转发2300 gas
        _to.transfer(_amount);
        
        // 将金额添加到接收者的余额中
        balances[_to]+=_amount;
    }
    
    // 替代转账方法：使用 call() 方法进行以太币转账
    function transferEtherViaCall(address payable _to, uint256 _amount) public onlyRegistered {
        // 检查接收者地址是否有效
        require(_to != address(0), "Invalid address");
        
        // 检查接收者是否已注册
        require(registeredFriends[_to], "Recipient not registered");
        
        // 检查余额是否足够
        require(balances[msg.sender] >= _amount, "Insufficient balance");
        
        // 从发送者的余额中扣除金额
        balances[msg.sender] -= _amount;
        
        // 使用 call() 方法进行低级调用
        // call() 方法更灵活，可以设置 gas 限制
        // 返回值：success (bool) 表示调用是否成功
        // 第二个返回值是返回数据（这里不需要，用 _ 忽略）
        (bool success, ) = _to.call{value: _amount}("");
        
        // 将金额添加到接收者的余额中
        balances[_to]+=_amount;
        
        // 检查转账是否成功
        require(success, "Transfer failed");
    }
    
    // 提取函数：提取你的余额到外部钱包
    function withdraw(uint256 _amount) public onlyRegistered {
        // 检查余额是否足够
        require(balances[msg.sender] >= _amount, "Insufficient balance");
        
        // 从余额中扣除金额
        balances[msg.sender] -= _amount;
        
        // 使用 call() 方法将以太币转回给调用者
        // payable(msg.sender) 将地址转换为可支付地址
        (bool success, ) = payable(msg.sender).call{value: _amount}("");
        
        // 检查提取是否成功
        require(success, "Withdrawal failed");
    }
    
    // 查询余额函数：查看你的余额
    function checkBalance() public view onlyRegistered returns (uint256) {
        // 返回调用者的余额
        return balances[msg.sender];
    }
}`,Ne={__name:"SimpleIOUApp",setup(Pe){const E=se(),{owner:U,userAddress:k,friendsList:T,userBalance:H,debts:w,checkedBalance:S,iouAddFriend:B,iouDeposit:N,iouRecordDebt:P,iouPayDebt:W,iouTransferMethod:j,iouCallMethod:L,iouWithdraw:$,iouCheckBalance:h}=oe(),f=u(""),_=u(""),v=u(""),A=u(""),g=u(""),F=u(""),d=u(""),y=u(""),q=u(""),I=u(!1),K=O(()=>{var n;return((n=E.dayProgress[7])==null?void 0:n.unlockedConcepts)||[]}),X=O(()=>{const n=E.dayProgress[7];return!n||n.totalConcepts===0?0:Math.floor(n.unlockedConcepts.length/n.totalConcepts*100)}),x=n=>(n/1e18).toFixed(4),Y=()=>{if(!f.value.trim()){alert("请输入朋友地址！");return}B(f.value)?f.value="":alert("添加朋友失败！地址可能无效或已存在。")},z=()=>{const n=Number(_.value);if(!n||n<=0){alert("请输入有效的存入数量！");return}N(n)?_.value="":alert("存入失败！您可能不是注册用户。")},G=()=>{if(!v.value.trim()){alert("请输入债务人地址！");return}const n=Number(A.value);if(!n||n<=0){alert("请输入有效的欠款金额！");return}P(v.value,n),v.value="",A.value=""},J=()=>{if(!g.value.trim()){alert("请输入债权人地址！");return}const n=Number(F.value);if(!n||n<=0){alert("请输入有效的还款金额！");return}const e=W(g.value,n);e===!0?(g.value="",F.value=""):alert(e||"还款失败！")},Q=()=>{if(!d.value.trim()){alert("请输入接收者地址！");return}const n=Number(y.value);if(!n||n<=0){alert("请输入有效的转账金额！");return}const e=j(d.value,n);e===!0?(d.value="",y.value=""):alert(e||"转账失败！")},Z=()=>{if(!d.value.trim()){alert("请输入接收者地址！");return}const n=Number(y.value);if(!n||n<=0){alert("请输入有效的转账金额！");return}const e=L(d.value,n);e===!0?(d.value="",y.value=""):alert(e||"转账失败！")},ee=()=>{const n=Number(q.value);if(!n||n<=0){alert("请输入有效的提现金额！");return}const e=$(n);e===!0?q.value="":alert(e||"提现失败！")},te=()=>{h()};return(n,e)=>(l(),i("div",ie,[t("div",ae,[t("div",ue,[t("div",de,[e[52]||(e[52]=t("h3",null,"🎮 交互操作",-1)),t("div",pe,[t("div",me,[e[25]||(e[25]=t("h4",{class:"block-title"},"👥 添加朋友",-1)),e[26]||(e[26]=t("code",{class:"function-signature"},"函数：addFriend(address _friend)",-1)),t("div",ce,[e[24]||(e[24]=t("label",{for:"friend-input"},"朋友地址/Friend Address：",-1)),p(t("input",{id:"friend-input","onUpdate:modelValue":e[0]||(e[0]=s=>f.value=s),type:"text",placeholder:"0x...",onClick:e[1]||(e[1]=o(()=>{},["stop"]))},null,512),[[m,f.value]])]),t("button",{onClick:e[2]||(e[2]=o(s=>f.value="0x"+Array(40).fill(0).map(()=>Math.floor(Math.random()*16).toString(16)).join(""),["stop"])),class:"day-action-btn blue small"},"🎲 随机生成"),t("button",{onClick:o(Y,["stop"]),class:"day-action-btn orange"},"➕ 添加朋友/AddFriend")]),t("div",be,[e[28]||(e[28]=t("h4",{class:"block-title"},"💰 钱包存款",-1)),e[29]||(e[29]=t("code",{class:"function-signature"},"函数：depositIntoWallet() payable",-1)),t("div",fe,[e[27]||(e[27]=t("label",{for:"deposit-iou-input"},"存入数量(ETH)/Amount：",-1)),p(t("input",{id:"deposit-iou-input","onUpdate:modelValue":e[3]||(e[3]=s=>_.value=s),type:"number",placeholder:"请输入数量",min:"0",step:"0.01",onClick:e[4]||(e[4]=o(()=>{},["stop"]))},null,512),[[m,_.value]])]),t("button",{onClick:o(z,["stop"]),class:"day-action-btn orange"},"💰 存入ETH/Deposit")]),t("div",ve,[e[32]||(e[32]=t("h4",{class:"block-title"},"📝 记录债务",-1)),e[33]||(e[33]=t("code",{class:"function-signature"},"函数：recordDebt(address _debtor, uint256 _amount)",-1)),t("div",ge,[e[30]||(e[30]=t("label",{for:"debtor-input"},"债务人(谁欠你钱)/Debtor：",-1)),p(t("input",{id:"debtor-input","onUpdate:modelValue":e[5]||(e[5]=s=>v.value=s),type:"text",placeholder:"0x...",onClick:e[6]||(e[6]=o(()=>{},["stop"]))},null,512),[[m,v.value]])]),t("button",{onClick:e[7]||(e[7]=o(s=>v.value="0x"+Array(40).fill(0).map(()=>Math.floor(Math.random()*16).toString(16)).join(""),["stop"])),class:"day-action-btn blue small",style:{"margin-bottom":"10px"}},"🎲 随机生成"),t("div",ye,[e[31]||(e[31]=t("label",{for:"debt-amount-input"},"欠款金额(ETH)/Amount：",-1)),p(t("input",{id:"debt-amount-input","onUpdate:modelValue":e[8]||(e[8]=s=>A.value=s),type:"number",placeholder:"请输入数量",min:"0",step:"0.01",onClick:e[9]||(e[9]=o(()=>{},["stop"]))},null,512),[[m,A.value]])]),t("button",{onClick:o(G,["stop"]),class:"day-action-btn yellow"},"📝 记录债务/RecordDebt")]),t("div",ke,[e[36]||(e[36]=t("h4",{class:"block-title"},"💳 钱包还债",-1)),e[37]||(e[37]=t("code",{class:"function-signature"},"函数：payFromWallet(address _creditor, uint256 _amount)",-1)),t("div",Ce,[e[34]||(e[34]=t("label",{for:"creditor-input"},"债权人(你欠谁钱)/Creditor：",-1)),p(t("input",{id:"creditor-input","onUpdate:modelValue":e[10]||(e[10]=s=>g.value=s),type:"text",placeholder:"0x...",onClick:e[11]||(e[11]=o(()=>{},["stop"]))},null,512),[[m,g.value]])]),t("button",{onClick:e[12]||(e[12]=o(s=>g.value="0x"+Array(40).fill(0).map(()=>Math.floor(Math.random()*16).toString(16)).join(""),["stop"])),class:"day-action-btn blue small",style:{"margin-bottom":"10px"}},"🎲 随机生成"),t("div",we,[e[35]||(e[35]=t("label",{for:"pay-amount-input"},"还款金额(ETH)/Amount：",-1)),p(t("input",{id:"pay-amount-input","onUpdate:modelValue":e[13]||(e[13]=s=>F.value=s),type:"number",placeholder:"请输入数量",min:"0",step:"0.01",onClick:e[14]||(e[14]=o(()=>{},["stop"]))},null,512),[[m,F.value]])]),t("button",{onClick:o(J,["stop"]),class:"day-action-btn green"},"💳 钱包还债/PayDebt")]),t("div",_e,[e[40]||(e[40]=t("h4",{class:"block-title"},"🔄 直接转账",-1)),e[41]||(e[41]=t("code",{class:"function-signature"},[b("函数：transferEther(address payable _to, uint256 _amount)"),t("br"),b("函数：transferEtherViaCall(address payable _to, uint256 _amount)")],-1)),t("div",Ae,[e[38]||(e[38]=t("label",{for:"transfer-to-input"},"接收者/To Address：",-1)),p(t("input",{id:"transfer-to-input","onUpdate:modelValue":e[15]||(e[15]=s=>d.value=s),type:"text",placeholder:"0x...",onClick:e[16]||(e[16]=o(()=>{},["stop"]))},null,512),[[m,d.value]])]),t("button",{onClick:e[17]||(e[17]=o(s=>d.value="0x"+Array(40).fill(0).map(()=>Math.floor(Math.random()*16).toString(16)).join(""),["stop"])),class:"day-action-btn blue small",style:{"margin-bottom":"10px"}},"🎲 随机生成"),t("div",Fe,[e[39]||(e[39]=t("label",{for:"transfer-amount-input"},"转账金额(ETH)/Amount：",-1)),p(t("input",{id:"transfer-amount-input","onUpdate:modelValue":e[18]||(e[18]=s=>y.value=s),type:"number",placeholder:"请输入数量",min:"0",step:"0.01",onClick:e[19]||(e[19]=o(()=>{},["stop"]))},null,512),[[m,y.value]])]),t("div",qe,[t("button",{onClick:o(Q,["stop"]),class:"day-action-btn cyan"},"📤 Transfer 转账"),t("button",{onClick:o(Z,["stop"]),class:"day-action-btn magenta"},"📡 Call 低级调用转账")])]),t("div",xe,[e[43]||(e[43]=t("h4",{class:"block-title"},"📊 余额管理",-1)),e[44]||(e[44]=t("code",{class:"function-signature"},[b("函数：withdraw(uint256 _amount)"),t("br"),b("函数：checkBalance() view returns (uint256)")],-1)),t("div",Te,[e[42]||(e[42]=t("label",{for:"withdraw-iou-input"},"提现数量(ETH)/Amount：",-1)),p(t("input",{id:"withdraw-iou-input","onUpdate:modelValue":e[20]||(e[20]=s=>q.value=s),type:"number",placeholder:"请输入提现金额",min:"0",step:"0.01",onClick:e[21]||(e[21]=o(()=>{},["stop"]))},null,512),[[m,q.value]])]),t("div",Ie,[t("button",{onClick:o(ee,["stop"]),class:"day-action-btn red"},"🏧 提现/Withdraw"),t("button",{onClick:o(te,["stop"]),class:"day-action-btn cyan"},"💰 查询余额/CheckBalance")]),r(S)!==null?(l(),i("div",De," 查询结果："+a(x(r(S)))+" ETH ",1)):C("",!0)])]),t("div",Me,[e[51]||(e[51]=t("h4",null,"🤝 IOU 状态面板",-1)),t("div",Ee,[t("div",Ue,[e[45]||(e[45]=t("strong",null,"部署者(Owner)：",-1)),b(a(r(U).slice(0,12)||"未初始化")+"...",1)]),t("div",Se,[e[46]||(e[46]=t("strong",null,"当前操作地址：",-1)),b(a(r(k).slice(0,12))+"...",1)]),t("div",Ve,[e[47]||(e[47]=t("strong",null,"钱包余额(内部)：",-1)),b(a(x(r(H)))+" ETH",1)]),e[50]||(e[50]=t("hr",{class:"divider"},null,-1)),r(T).length>0?(l(),i("div",Oe,[t("strong",null,"已注册朋友 ("+a(r(T).length-1)+"个)：",1),(l(!0),i(D,null,M(r(T),(s,c)=>(l(),i("div",{key:c,class:"list-item"},a(s===r(U)?"Owner(自身)":s.slice(0,15)+"..."),1))),128))])):C("",!0),Object.keys(r(w)).length>0?(l(),i("div",Re,[e[48]||(e[48]=t("strong",null,"债务记录 (你欠谁)：",-1)),Object.keys(r(w)[r(k)]||{}).length===0?(l(),i("div",He,"无")):C("",!0),(l(!0),i(D,null,M(r(w)[r(k)],(s,c)=>(l(),i("div",{key:c,class:"list-item debt-item"}," 欠债权人: "+a(c.slice(0,10))+"... 金额: "+a(x(s))+" ETH ",1))),128)),e[49]||(e[49]=t("strong",{style:{"margin-top":"5px",display:"inline-block"}},"债权记录 (谁欠你)：",-1)),(l(!0),i(D,null,M(r(w),(s,c)=>(l(),i("div",{key:c},[s[r(k)]>0?(l(),i("div",Be," 债务人: "+a(c.slice(0,10))+"... 欠你: "+a(x(s[r(k)]))+" ETH ",1)):C("",!0)]))),128))])):C("",!0)])])])]),V(re,{"current-day":7,"unlocked-concepts":K.value,"progress-percentage":X.value,"full-code":R,onShowFullCode:e[22]||(e[22]=s=>I.value=!0)},null,8,["unlocked-concepts","progress-percentage"])]),V(le,{show:I.value,title:"SimpleIOU 完整代码",code:R,onClose:e[23]||(e[23]=s=>I.value=!1)},null,8,["show"])]))}},Le=ne(Ne,[["__scopeId","data-v-e1f42401"]]);export{Le as default};
