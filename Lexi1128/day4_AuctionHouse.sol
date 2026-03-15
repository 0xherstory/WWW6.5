// SPDX-License-Identifier:MIT
pragma solidity ^0.8.0;
contract AuctionHouse{
    address public owner;
    string public item;
    uint public auctionEndtime;
    address private highestBidder;
    uint private highestBid;
    bool public ended;

    mapping(address=>uint) public bids;
    address[] public bidders;

    constructor(string memory _item,uint _biddingTime){
        item=_item;
        owner=msg.sender;
        auctionEndtime=block.timestamp+_biddingTime;
    }

    function bid(uint amount) external{
        require(block.timestamp<auctionEndtime,"Auction has ended");
        require(amount>0,"Bid amount must be greater than zero");
        require(amount>bids[msg.sender],"New bid must be higher than your current bid");

        if(bids[msg.sender]==0){
            bidders.push(msg.sender);
        }
        bids[msg.sender]=amount;
        
        if(amount>highestBid){
            highestBid=amount;
            highestBidder=msg.sender;
        }
    }
function endAuction()external{
    require(block.timestamp>=auctionEndtime,"Auction hasn't ended yet.");
    require(!ended,"Auction end already called.");
    ended=true;
}
function getallbidders()external view returns (address[]memory){
    return bidders;
}
function getwinner()external view returns (address,uint){
    require(ended,"Auction has not ended yet");
    return(highestBidder,highestBid);
}
}