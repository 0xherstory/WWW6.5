// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
contract AuctionHouse{
    address public owner;
    string public item;
    uint public auctionEndTime;
    address private highestBidder;
    uint private highestBid;
    bool public ended;
    mapping (address=>uint256) public bids;
    address[] public bidders;
    constructor(string memory _item, uint _biddingTime){
        owner=msg.sender;
        item=_item;
        auctionEndTime = block.timestamp + _biddingTime;
    }

    function bid(uint amount) external {
        require(block.timestamp < auctionEndTime,"Auction has already ended");
        require(amount>0,"Bid amount must be greater than zero"); 
        require(amount>bids[msg.sender], "Bid must be higher than previous bids");
        if (bids[msg.sender]==0){
            bidders.push(msg.sender);
        }

        bids[msg.sender] = amount;

        if (amount > highestBid){
            highestBid = amount;
            highestBidder=msg.sender;
        }
    }

    function endAuction() external {
        require(block.timestamp>=auctionEndTime,"Auction has not ended yet");
        require(!ended,"Auction end has already been called");
        require(msg.sender == owner,"Only owner can end");
        ended = true;
    }
    function getWinner()external view returns(address,uint) {
        require(ended,"Auction hasn't ended yet");
        return (highestBidder, highestBid);
    }
    function getAllbidders() external view returns(address[] memory) {
        return bidders;
    }
}