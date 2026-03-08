// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract AuctionHouse {
    address public owner;//拍卖发起人
    string public item;//拍卖品
    uint public auctionEndTime;//截止日期（时间戳）
    address private highestBidder;//当前最高出价者（保密）
    uint private highestBid;//当前最高价（保密）
    bool public ended;//拍卖是否已结束
    
    mapping(address => uint) public bids;// 【核心】记录每个地址的总出价金额
    address[] public bidders;// 记录所有参与过竞拍的地址列表
    

     //贴出拍卖告示
    constructor(string memory _item, uint _biddingTime) {
        owner = msg.sender;//拍卖发起人
        item = _item;//拍卖品
        auctionEndTime = block.timestamp + _biddingTime;// 现在 + 竞标天数（秒）
    }
    
    function bid(uint amount) external {
        require(block.timestamp < auctionEndTime, "Auction ended");
        require(amount > highestBid, "Bid too low");
        
        if (bids[msg.sender] == 0) {
            bidders.push(msg.sender);
        }
        
        bids[msg.sender] += amount;
        
        if (bids[msg.sender] > highestBid) {
            highestBid = bids[msg.sender];
            highestBidder = msg.sender;
        }
    }
    
    function endAuction() external {
        require(!ended, "Auction already ended");
        require(block.timestamp >= auctionEndTime, "Auction not yet ended");
        require(msg.sender == owner, "Only owner can end");
        
        ended = true;
    }
    
    function getWinner() external view returns (address, uint) {
        require(ended, "Auction not ended");
        return (highestBidder, highestBid);
    }
    
    function getAllBidders() external view returns (address[] memory) {
        return bidders;
    }
}