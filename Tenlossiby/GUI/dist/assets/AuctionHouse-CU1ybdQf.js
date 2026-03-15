import{_ as $,j as G,o as l,c as d,a as t,b as n,w as f,v as y,k as r,t as u,g as k,F as K,i as L,d as C,r as a}from"./index-EE7T8a7d.js";import{K as O,F as R}from"./FullCodeModal-maEzWUm0.js";const X={class:"day-4-content"},J={class:"content-layout"},Q={class:"left-column"},Y={class:"interaction-area"},Z={key:0,class:"interaction-controls"},ee={class:"input-group"},te={class:"input-group"},ne={key:1,class:"auction-status"},ie={class:"auction-info"},se={key:0,class:"interaction-controls"},oe={class:"input-group"},le={class:"input-group"},de={class:"button-row"},ue={key:1,class:"winner-section"},re={key:0,class:"winner-result"},ae={key:2,class:"bidders-list"},ce={class:"bidder-address"},pe={class:"bid-amount"},me={key:3,class:"highest-bid-info"},E=`// SPDX-License-Identifier: MIT
// 声明Solidity版本，要求编译器版本在0.8.0或更高（但低于0.9.0）
pragma solidity ^0.8.0;

// 定义一个名为AuctionHouse的合约，用于拍卖行功能
contract AuctionHouse {
    // 声明公共地址变量，存储拍卖行的所有者地址
    address public owner;
    
    // 声明公共字符串变量，存储拍卖物品的名称
    string public item;
    
    // 声明公共无符号整数，存储拍卖结束时间戳
    uint public auctionEndTime;
    
    // 声明私有地址变量，存储最高出价者的地址
    // private 表示只能在这个合约内部访问，外部无法直接读取
    address private highestBidder; // 获胜者是私有的，可以通过getWinner函数访问
    
    // 声明私有无符号整数，存储最高出价金额
    uint private highestBid;       // 最高出价是私有的，可以通过getWinner函数访问
    
    // 声明公共布尔变量，标记拍卖是否已结束
    bool public ended;

    // 声明映射，存储每个地址（竞拍者）的出价金额
    // 键是地址类型，值是无符号整数
    mapping(address => uint) public bids;
    
    // 声明地址数组，存储所有参与竞拍的地址
    address[] public bidders;

    // 构造函数：在合约部署时执行一次，用于初始化合约状态
    // 参数：_item是拍卖物品名称，_biddingTime是拍卖持续时间（秒）
    constructor(string memory _item, uint _biddingTime) {
        // 将部署合约的地址（发送者）设置为所有者
        owner = msg.sender;
        
        // 设置拍卖物品名称
        item = _item;
        
        // 设置拍卖结束时间：当前区块时间戳 + 拍卖持续时间
        // block.timestamp 是当前区块的时间戳（Unix时间，秒）
        auctionEndTime = block.timestamp + _biddingTime;
    }

    // 允许用户出价的函数
    // external 表示函数只能从合约外部调用（比public更省gas）
    function bid(uint amount) external {
        // require是条件检查函数，如果条件为false则回滚交易并显示错误信息
        // 检查当前时间是否早于拍卖结束时间，确保拍卖未结束
        require(block.timestamp < auctionEndTime, "Auction has already ended.");
        
        // 检查出价金额是否大于0
        require(amount > 0, "Bid amount must be greater than zero.");
        
        // 检查新出价是否高于该竞拍者当前的出价
        require(amount > bids[msg.sender], "New bid must be higher than your current bid.");

        // 如果该竞拍者之前没有出价（出价为0），则将其添加到竞拍者数组
        if (bids[msg.sender] == 0) {
            bidders.push(msg.sender);
        }

        // 更新该竞拍者的出价金额
        bids[msg.sender] = amount;

        // 如果新出价高于当前最高出价，则更新最高出价和最高出价者
        if (amount > highestBid) {
            highestBid = amount;
            highestBidder = msg.sender;
        }
    }

    // 结束拍卖的函数（只能在拍卖时间结束后调用）
    function endAuction() external {
        // 检查当前时间是否已达到或超过拍卖结束时间
        require(block.timestamp >= auctionEndTime, "Auction hasn't ended yet.");
        
        // 检查拍卖是否已经结束（防止重复调用）
        require(!ended, "Auction end already called.");

        // 将ended标记设置为true，表示拍卖已结束
        ended = true;
    }

    // 获取所有竞拍者列表的函数
    function getAllBidders() external view returns (address[] memory) {
        // 返回竞拍者地址数组
        return bidders;
    }

    // 获取拍卖获胜者和其出价的函数（仅在拍卖结束后可调用）
    function getWinner() external view returns (address, uint) {
        // 检查拍卖是否已结束
        require(ended, "Auction has not ended yet.");
        
        // 返回最高出价者的地址和最高出价金额
        return (highestBidder, highestBid);
    }
}`,ve={__name:"AuctionHouse",setup(be){const{owner:H,item:w,auctionEndTime:q,highestBidder:I,highestBid:B,ended:A,bids:_,bidders:W,progressPercentage:D,unlockedConcepts:x,initializeAuction:F,placeBid:V,endAuction:M,getWinner:S,formatTime:U}=G(),s=a('💡 提示：输入拍卖物品名称和时长，点击"初始化拍卖"开始学习 constructor 和 block.timestamp'),p=a(""),v=a(60),m=a(0),c=a(""),T=a(!1),b=a(null),h=a(!1),z=()=>{if(!p.value.trim()){s.value="⚠️ 请先输入拍卖物品名称！";return}F(p.value,parseInt(v.value)),p.value="",v.value=60,g()},N=()=>{if(!c.value.trim()||!c.value.startsWith("0x")){s.value="⚠️ 请先输入有效的竞拍者地址！";return}if(m.value<=0){s.value="⚠️ 出价金额必须大于0！";return}V(parseFloat(m.value),c.value)&&(m.value=0,c.value=""),g()},P=()=>{M(),g()},j=()=>{const o=S();o&&(T.value=!0,b.value=o),g()},g=()=>{const o=x.value;o.includes("constructor")?o.includes("require")?o.includes("external")?o.includes("bool_type")?o.includes("address_type")?s.value="🎉 恭喜！你已解锁 Day 4 所有概念，点击查看完整代码复习吧！":s.value='🏆 提示：拍卖已结束！点击"获取获胜者"来学习 address 类型，查看最高出价者':s.value='⏰ 提示：继续出价或等待拍卖时间结束后，点击"结束拍卖"按钮来学习 bool 类型':s.value="💡 提示：第1次出价成功！继续添加不同的竞拍者地址再次出价，来学习 external 函数":s.value='💡 提示：拍卖已初始化！现在输入竞拍者地址和出价金额，点击"出价"来学习 require 和 msg.sender':s.value='💡 提示：输入拍卖物品名称和时长，点击"初始化拍卖"开始学习 constructor 和 block.timestamp'};return(o,e)=>(l(),d("div",X,[t("div",J,[t("div",Q,[t("div",Y,[e[18]||(e[18]=t("h3",null,"🎮 交互操作",-1)),n(w)?(l(),d("div",ne,[t("div",ie,[t("h4",null,"📦 拍卖物品："+u(n(w)),1),t("p",null,"👤 所有者："+u(n(H).slice(0,8))+"...",1),t("p",null,"⏰ 结束时间："+u(n(U)(n(q))),1),t("p",null,"🔴 状态："+u(n(A)?"已结束":"进行中"),1)]),n(A)?(l(),d("div",ue,[t("button",{onClick:r(j,["stop"]),class:"day-action-btn cyan"},"🏆 获取获胜者/GetWinner"),T.value&&b.value?(l(),d("div",re,[e[15]||(e[15]=t("h4",null,"🎉 拍卖获胜者",-1)),t("p",null,"👤 地址："+u(b.value.winner.slice(0,12))+"...",1),t("p",null,"💰 出价："+u(b.value.bid)+" ETH",1)])):k("",!0)])):(l(),d("div",se,[t("div",oe,[e[13]||(e[13]=t("label",{for:"bid-amount-input"},"出价金额（ETH）/Bid Amount：",-1)),f(t("input",{id:"bid-amount-input","onUpdate:modelValue":e[4]||(e[4]=i=>m.value=i),type:"number",min:"0",step:"0.1",placeholder:"0.1",onClick:e[5]||(e[5]=r(()=>{},["stop"]))},null,512),[[y,m.value]])]),t("div",le,[e[14]||(e[14]=t("label",{for:"bidder-address-input"},"竞拍者地址/Bidder Address：",-1)),f(t("input",{id:"bidder-address-input","onUpdate:modelValue":e[6]||(e[6]=i=>c.value=i),type:"text",placeholder:"0x...",onClick:e[7]||(e[7]=r(()=>{},["stop"]))},null,512),[[y,c.value]])]),t("div",de,[t("button",{onClick:r(N,["stop"]),class:"day-action-btn yellow"},"💰 出价/Bid"),t("button",{onClick:e[8]||(e[8]=r(i=>c.value="0x"+Array(40).fill(0).map(()=>Math.floor(Math.random()*16).toString(16)).join(""),["stop"])),class:"day-action-btn blue small"},"🎲 随机生成")]),t("button",{onClick:r(P,["stop"]),class:"day-action-btn red full-width"},"🛑 结束拍卖/EndAuction")]))])):(l(),d("div",Z,[t("div",ee,[e[11]||(e[11]=t("label",{for:"item-input"},"拍卖物品名称/Item：",-1)),f(t("input",{id:"item-input","onUpdate:modelValue":e[0]||(e[0]=i=>p.value=i),type:"text",placeholder:"请输入拍卖物品名称",onClick:e[1]||(e[1]=r(()=>{},["stop"]))},null,512),[[y,p.value]])]),t("div",te,[e[12]||(e[12]=t("label",{for:"bidding-time-input"},"拍卖时长（秒）/Duration：",-1)),f(t("input",{id:"bidding-time-input","onUpdate:modelValue":e[2]||(e[2]=i=>v.value=i),type:"number",min:"10",placeholder:"60",onClick:e[3]||(e[3]=r(()=>{},["stop"]))},null,512),[[y,v.value]])]),t("button",{onClick:r(z,["stop"]),class:"day-action-btn yellow"},"🏗️ 初始化拍卖/InitializeAuction")])),Object.keys(n(_)).length>0?(l(),d("div",ae,[e[16]||(e[16]=t("h4",null,"💎 竞拍者列表/Bidders",-1)),(l(!0),d(K,null,L(n(W),i=>(l(),d("div",{key:i,class:"bidder-item"},[t("span",ce,u(i.slice(0,10))+"...",1),t("span",pe,u(n(_)[i])+" ETH",1)]))),128))])):k("",!0),n(B)>0?(l(),d("div",me,[e[17]||(e[17]=t("h4",null,"🏆 当前最高出价",-1)),t("p",null,"👤 竞拍者："+u(n(I).slice(0,10))+"...",1),t("p",null,"💰 金额："+u(n(B))+" ETH",1)])):k("",!0)])]),C(O,{"current-day":4,"unlocked-concepts":n(x),"progress-percentage":n(D),"full-code":E,"custom-hint":s.value,onShowFullCode:e[9]||(e[9]=i=>h.value=!0)},null,8,["unlocked-concepts","progress-percentage","custom-hint"])]),C(R,{show:h.value,title:"AuctionHouse 完整代码",code:E,onClose:e[10]||(e[10]=i=>h.value=!1)},null,8,["show"])]))}},ye=$(ve,[["__scopeId","data-v-6335c569"]]);export{ye as default};
