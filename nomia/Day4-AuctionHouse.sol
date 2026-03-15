// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract AuctionHouse{
    address public owner;
    string public item;
    uint public auctionEndTime;
    address private highestBidder;
    uint private highestBid;
    bool public ended;

    mapping(address => uint256) public bids; 
    address[] public bidders;

    constructor(string memory _item, uint256 _biddingTime){
        owner = msg.sender;
        item = _item;
        auctionEndTime = block.timestamp + _biddingTime;


    }


    function bid(uint256 amount) external {
        require(block.timestamp < auctionEndTime,"auction has ended.");
        require(amount > 0, "bid amount has to be greater than 0");
        require(amount > bids[msg.sender],"bid must be higher than ur previous bid");

    if (bids[msg.sender] == 0 ) {
        bidders.push(msg.sender);

    }

    bids[msg.sender] = amount;

    if(amount > highestBid){
        highestBid = amount;
        highestBidder = msg.sender;
    }


    }

 function endAuction() external{
    require(block.timestamp >= auctionEndTime, "auction has NOT ended");
    require(!ended, "auction end has already been called");
    ended = true;


}

function getWinner() external view returns(address,uint256){
    require(ended,"Auction has NOT ended yet");
    return(highestBidder,highestBid);

}

function getAllBidders() external view returns(address[] memory){
    return bidders;
}

}
