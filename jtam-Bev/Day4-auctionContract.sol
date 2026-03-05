

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract AuctionHouse {

address public owner;  //庄家账号
string public item;    //拍品
uint public auctionEndTime;       //拍卖时间
address private highestBidder;      //最高价竞拍者账号  不公开

uint private highestBid;         // 最高出价。 不公开

bool public ended;             

mapping (address =>uint) public bids;    
//记录竞拍者数额
address[] public bidders;

//起拍价
uint public minPrice;
// 最低加价
uint public minIncrement;

//这里的代码只运行一次， 除非开了后门修改。 很贵要仔细检查

constructor (string memory _item, uint _biddingTime, uint _minPrice, uint _minIncrement) {
owner =msg.sender;
//msg.sender 是部署者， 是老大
item =_item;          
//拍品  此刻规定好
auctionEndTime= block.timestamp +_biddingTime;
//拍卖结束时间=发布时间点+预设的拍卖时长

minPrice =_minPrice;

minIncrement =_minIncrement;

}

//以下是竞价逻辑

function bid (uint amount)  external {
require(block.timestamp < auctionEndTime, "Auction has already ended.");
require(amount >0, "Bid amount must be greater than zero.");

//require(amount >bids[msg.sender],"New bid must be higher than your current bid.");
//这里的三个是非条件的判断分别是：竞拍时间点小于竞拍终止时间， 通过；反之提示
//                           竞拍金额大于0
//                           竞拍金额要大于上次的竞拍价格

require(amount >= highestBid + minIncrement,"Bid must be higher than highest bid plus increment");

require(amount >= minPrice,"Bid must be at least the minimum price.");
if (bids[msg.sender]==0) {bidders.push (msg.sender);
}            
bids[msg.sender] =amount;   //更新竞拍价格

if (amount >highestBid){
    highestBid =amount;
    highestBidder =msg.sender;
}
// 如果新竞拍价格高于当前最高价， 则更新竞拍价格和竞拍者

//不同竞价者出价后金额全部存在账户中， 竞价者和最高价随着更新

if (highestBidder != address (0)) {
    bids [highestBidder] +=highestBid;

   
}
    highestBidder =msg.sender;
    highestBid = amount;

}

//收场逻辑  
function endAuction () external {
    require(block.timestamp >=auctionEndTime,"Auction hasn't ended yet.");
    require(!ended,"Auction end alredy called");
    //注意这里 因为在前面已经默认bool ended 为假（系统默认）所以， 此处逻辑为若竞拍时间点戳记大于结束时间为真， 则提醒
    ended = true;
}
 
 //查询工具
 function getAllBidders () external view 
          returns (address []memory){
          return bidders;
 }
function getWinner() external view 
          returns (address,uint){
    require(ended, "Auction has not ended yet.");
          return (highestBidder,highestBid);
}

function withdraw () external {
    uint amount =bids [msg.sender];

    require(amount >0,"No fund to withdraw");
    bids[msg.sender]=0;

    payable (msg.sender).transfer (amount);
}

}