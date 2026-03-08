// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract AuctionHouse{
    address public owner;
    string public item;
    uint public auctionEndTime;
    address private highestBidder;
    uint private highestBid;

    bool public ended;
    mapping(address =>uint) public bids;//记录每个用户的出价
    address[] public bidders;

    //初始化
    constructor(string memory _item,uint _bidingTime) { //
        owner=msg.sender;//全局变量
        auctionEndTime=block.timestamp+_bidingTime;//block.timestamp是当前区块的时间戳
        item=_item;
    }
    //================出价环节===================
    function bid(uint amount) external{//external 表示外部可以调用该函数
        //提示结束
        require(block.timestamp<auctionEndTime,"auction has already ended");
        //提示金额无效
        require(amount>0,"bid amount must be greater than 0");
        //提示金额小于上次出价
        require(amount>bids[msg.sender],"bid amount must be greater than last time");
        if(bids[msg.sender]==0){ //bids是记录每个用户出价，如果是第一次，这个值默认是0
            bidders.push(msg.sender);
        }

        bids[msg.sender]=amount;//sava bidamount

        //update hightestbidder&bid
        if(amount>highestBid){
            highestBid=amount;
            highestBidder=msg.sender;
        }
    }
    //===================结束拍卖===================
    function endAuction() external{
        require(block.timestamp>auctionEndTime,"auction has not ended yet");
        require(!ended,"auction has already ended");
        ended=true;
    }
    //===================获取拍卖人员名单===================
    function getbiderList() external view returns(address[] memory){
        return bidders; 
    }
    //===================获取最终赢家===================
    function getBidWiner() external view returns(address,uint){//函数定义部分 returns 需要加s
        require(ended,"Auction has not ended yet.");
        return(highestBidder,highestBid);
    }
}