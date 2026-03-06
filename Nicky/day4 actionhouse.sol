// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract AuctionHouse{
    address public owner; //拍竞拍者
    string public  item; // 拍卖品
    uint public actionEndTime; //拍卖截止时间
    address private highestBidder; ///最高价拍卖人 
    uint private highestBid; //最高价
    bool public ended; //拍卖是否结束？
    mapping(address =>uint) public bids; //将拍卖者名字与拍卖价链接
    address[] public bidders; //[]意味着序列

    constructor(string memory _item, uint _biddingTime){
        owner=msg.sender;
        item=_item;
        actionEndTime=_biddingTime+block.timestamp; //现在的时间
    }

    function bid(uint amount) external{
        require(block.timestamp < actionEndTime, "Auction has already ended.");
        require(amount>0, "Bid amount must be greater than zero");
        require(amount > bids[msg.sender], "New bid must be hither than your current bid");
        
        if(bids[msg.sender] == 0){
            bidders.push(msg.sender);
        }//是否是首次出价

        bids[msg.sender]=amount;
        if(amount>highestBid){
            highestBid=amount;
            highestBidder=msg.sender;
        }
    }
    function endAction()external {
        require(block.timestamp>actionEndTime,"Auction hasn't ended");
        require(!ended, "Auction end already called.");
        ended=true;
    }
    function getAllBidders() external view returns (address[] memory){
        return bidders;
    }






}
//拍卖所需数据：拍卖时间，价格，拍卖人