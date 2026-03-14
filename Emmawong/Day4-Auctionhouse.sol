// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract AuctionHouse{
    address public owner;
    string public item;
    uint public auctionEndTime;
    address private highestBidder; //winner is private, accessible
    uint private highestBid;
    bool public ended; //这个bool还不太理解

    mapping(address => uint) public bids;
    address[] public bidders; 

    //用拍品和持续时长初始化这场拍卖
    constructor(string memory _item, uint _biddingTime) {
        owner = msg.sender;
        item = _item;
        auctionEndTime = block.timestamp + _biddingTime;
    }

    //允许用户竞价
    function bid(uint amount)external {
        require(block.timestamp < auctionEndTime, "Acction has already end.");
        require(amount > 0, "Bid amount must be greater than zero.");
        require(amount > bids[msg.sender],"New bid must be higher than your current bid.");

        //记录新竞拍者
        if (bids[msg.sender] ==0){
            bidders.push(msg.sender);
        } //bids[地址A] = 1 ETH, bids[地址B] = 0.5 ETH, bids[地址C] = 0 （从来没出价）

        bids[msg.sender]= amount;

        //更新最高竞价和竞价者
         if (amount > highestBid) {
            highestBid = amount;
            highestBidder = msg.sender;
        }
    }

        //超时之前结束拍卖
        //1必须到关门时间才能关（没到时间不能关）
        //2已经关了就不能再关一次
        //3关上门后，挂个牌子：已关门


        function endAuction() external {
        require(block.timestamp >= auctionEndTime, "Auction hasn't ended yet.");
        require(!ended, "Auction end already called.");

        ended = true;
    }

    //拉取竞价者名单
    function getBidders() external view returns (address[] memory) {
        return bidders;
    }

    //结束后查询赢家和出价
    function getWinner()external view returns(address,uint){
        require(ended, "Auction has not ended yet.");
        return (highestBidder,highestBid);
    }
    
}