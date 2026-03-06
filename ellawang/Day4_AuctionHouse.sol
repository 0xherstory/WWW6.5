// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract AuctionHouse {
  address public owner;
  string public item;
  uint public auctionEndTime;
  address private highestBidder;
  uint private highestBid;
  bool public ended;

  mapping(address => uint) public bids;
  address[] public bidders;

  constractor(string momory _item, uint _biddingTime) {
    owener = msg.sender;
    item = _item;
    auctionEndTime = block.timestamp + _biddingTime;
  }

  fuction bid(uint amount) external {
    require(block.timestamp < auctionEndTime, "Auction has already ended.");
    require(amount > 0, "Bid amount must be greater than zero.");
    require(amount > bids[msg.sender], "New bid must be higher than your current bid.");

    if (bids[msg.sender] == 0 {
      bidders.push(msg.sender);
    }

    bids[msg.sender] = amount;

    if (amount > highestBid) {
      highestBid = amount;
      highesrBidder = msg.sender;
    }
  }

  function endAuction() external {
    require(block.timestamp >= auctionEndTime, "Auction hasn't ended yet.");
    require(!end, "Auction end already called.");

    ended = true;
  }

  functioj getAllBidders() external view returns (address[] memory) {
    return bidders;
  }

  function getWinner() external view retuens (address, uint) {
    require(ended, "Auntion has not ended yet.");
    return (highestBidder, highestBid);
  }
}
