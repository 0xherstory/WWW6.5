// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract AuctionHouse{

    address public owner;
    string public item;
    uint public auctionEndTime;
    address private highestBidder;
    uint private highestBid;
    bool public ended;
    mapping (address => uint) public bids;
    address[] public bidders;
    //不需要赋初始值吗？

    constructor (string memory _item, uint _biddingTime) {
        owner = msg.sender;
        item = _item;
        auctionEndTime = block.timestamp + _biddingTime;
    }

    function bid(uint amount) external {
        require(block.timestamp < auctionEndTime, "Auction has already ended.");
        //原来require后面是报错信息，看了函数用法才知道，最初还以为是 if so 的逻辑
        require(amount > 0, "Bid amount must be greater than zero.");
        require(amount > bids[msg.sender], "New bid must be higher than the last bid.");

        if (bids[msg.sender] == 0){
            bidders.push(msg.sender);
        }

        bids[msg.sender] = amount;

        if (amount > highestBid){
            highestBid = amount;
            highestBidder = msg.sender;
        }              
    }

    function endAuction() external {
        require(block.timestamp >= auctionEndTime, "Auction hasn't ended yet.");
        require(!ended, "Auction end already called.");// don't know why this line is necessary
        ended = true;
    }

    function getWinner() external view returns(address, uint) {
        require(ended, "Auction hasn't ended yet.");
        return (highestBidder, highestBid);
    }

    function getAllBidders() external view returns (address[] memory) {
        return bidders;
    }
}