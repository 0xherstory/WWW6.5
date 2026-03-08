// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract AuctionHouse {
    address public owner;
    string public itemDescription;
    uint256 public auctionEndTime;
    

    address private highestBidder; 
    uint256 private highestBid;

    bool public ended;

    address[] public bidders; 
    mapping(address => uint256) public bids;

    constructor(string memory _description, uint256 _duration) {
        owner = msg.sender;
        itemDescription = _description;
        auctionEndTime = block.timestamp + _duration;
    }

    function bid() public payable {
        require(block.timestamp <= auctionEndTime, "Auction already ended.");

        require(msg.value > highestBid, "There already is a higher bid.");
    
        if (bids[msg.sender] == 0) {
            bidders.push(msg.sender);
        }

        bids[msg.sender] = msg.value;
        highestBid = msg.value;
        highestBidder = msg.sender;
    }

    function endAuction() public {
        require(block.timestamp > auctionEndTime, "Auction not yet ended.");
        require(!ended, "endAuction has already been called.");
 
        ended = true;
    }
    
    function getWinner() public view returns (address, uint256) {
        require(ended, "Auction is still ongoing!");
        return (highestBidder, highestBid);
    }

}
