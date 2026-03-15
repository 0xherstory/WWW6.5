// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract AuctionHouse {
    address public owner;
    string public item;
    uint public auctionEndTime;
    address private highestBidder; // Winner is private, accessible via getWinner
    uint private highestBid;       // Highest bid is private, accessible via getWinner
    bool public ended;

    mapping(address => uint) public bids;
    address[] public bidders;

    // Initialize the auction with an item and a duration
    constructor(string memory _item, uint _biddingTime) {
        owner = msg.sender;
        item = _item;
        auctionEndTime = block.timestamp + _biddingTime;
    }

    // Allow users to place bids
    function bid() external payable {
        require(block.timestamp < auctionEndTime, "Auction has already ended.");
        require(msg.value > 0, "Bid amount must be greater than zero.");
        require(msg.value + bids[msg.sender] > highestBid, "There already is a higher bid.");

        bids[msg.sender] += msg.value;

        if (bids[msg.sender] == msg.value) {
            bidders.push(msg.sender);
        }

        highestBid = bids[msg.sender];
        highestBidder = msg.sender;
    }

    function endAuction() external {
        require(block.timestamp >= auctionEndTime, "Auction hasn't ended yet.");
        require(!ended, "Auction end already called.");
        ended = true;
    }

    function getAllBidders() external view returns (address[] memory) {
        return bidders;
    }

    function getWinner() external view returns (address, uint) {
        require(ended, "Auction has not ended yet.");
        return (highestBidder, highestBid);
    }
}