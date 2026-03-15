// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
contract AuctionHouse{
    address public owner;
    string public item;
    uint public auctionEndTime;
    address private highestBidder; //标记winner
    uint private highestBid;
    bool public ended; //标记拍卖是否完成

    mapping(address => uint) public bids;
    address[] public bidders; //出价者名单 

    //初始化拍卖行
    constructor(string memory _item, uint _biddingTime) {
        owner = msg.sender;
        item = _item;
        auctionEndTime = block.timestamp + _biddingTime;
    }

    //出价
    function bid(uint amount) external {
    require(block.timestamp < auctionEndTime, "Auction has already ended.");
    require(amount > 0, "Bid amount must be greater than zero.");
    require(amount > bids[msg.sender], "New bid must be higher than your current bid.");

    if (bids[msg.sender] == 0) {
        bidders.push(msg.sender);
    }

    bids[msg.sender] = amount;

    if (amount > highestBid) {
        highestBid = amount;
        highestBidder = msg.sender;
    }
}

//拍卖结束
    function endAuction() external {
    require(block.timestamp >= auctionEndTime, "Auction hasn't ended yet.");
    require(!ended, "Auction end already called.");
    ended = true;
}

//结束后查看拍卖信息
    function getWinner() external view returns (address, uint) {
    require(ended, "Auction has not ended yet.");
    return (highestBidder, highestBid);
}

//查看所有拍卖者
    function getAllBidders() external view returns (address[] memory) {
    return bidders;
}
}