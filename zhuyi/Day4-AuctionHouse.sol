// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract AuctionHouse {
    address public owner; //address 追踪地址
    string public item;
    uint public auctionEndTime;
    address private highestBidder; // Winner is private, accessible via getWinner
    uint private highestBid;       // Highest bid is private, accessible via getWinner
    bool public ended;

    mapping(address => uint) public bids; //可以多次出价，但价格不同
    address[] public bidders;

    // Initialize the auction with an item and a duration
    constructor(string memory _item, uint _biddingTime) {
        owner = msg.sender; // 部署合约的操作者地址
        item = _item;
        auctionEndTime = block.timestamp + _biddingTime; // block.timestamp 当前时间
    }

    // Allow users to place bids
    function bid(uint amount) external {
        require(block.timestamp < auctionEndTime, "Auction has already ended.");
        require(amount > 0, "Bid amount must be greater than zero.");
        require(amount > bids[msg.sender], "New bid must be higher than your current bid.");

        // Track new bidders
        if (bids[msg.sender] == 0) {
            bidders.push(msg.sender); //sender不存在，push进数组
        }

        bids[msg.sender] = amount;

        // Update the highest bid and bidder
        if (amount > highestBid) {
            highestBid = amount;
            highestBidder = msg.sender;
        }
    }

    // End the auction after the time has expired
    function endAuction() external {
        require(block.timestamp >= auctionEndTime, "Auction hasn't ended yet.");
        require(!ended, "Auction end already called.");

        ended = true;
    }

    // Get a list of all bidders
    function getAllBidders() external view returns (address[] memory) {
        return bidders;
    }

    // Retrieve winner and their bid after auction ends
    function getWinner() external view returns (address, uint) {
        require(ended, "Auction has not ended yet.");
        return (highestBidder, highestBid);
    }
}