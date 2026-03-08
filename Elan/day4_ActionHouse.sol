// SPDX-License-Identifier：MIT
pragma solidity ^0.8.0;

contract AuctionHouse {
    address public seller;
    string public itemDescription;
    uint256 public highestBid;
    address public highestBidder;
    bool public auctionEnded;
constructor(string memory _description) {
    seller = msg.sender;
    itemDescription = _description;
    auctionEnded = false;}
function bid() public payable {
    require(!auctionEnded,"Auction already ended.");
    require(msg.value > highestBid,"There is already a higher bid.");
    if (highestBid != 0){
        payable(highestBidder).transfer(highestBid);
    }
    highestBidder = msg.sender;
    highestBid = msg.value;}
function endAuction() public {
    require(msg.sender == seller, "Only seller can end the auction.");
    require(!auctionEnded,  "Auction already ended.");
    auctionEnded = true;
    payable(seller).transfer(highestBid);
}
}
