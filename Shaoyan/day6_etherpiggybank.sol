// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract EtherPiggyBank {
    address public owner;
    string public item;
    uint public auctionEndTime;
    address private highestBidder; // 当前最高出价者（赢家），设为 private，通过 getWinner 函数获取
    uint private highestBid;       // 当前最高出价，设为 private，通过 getWinner 函数获取
    bool public ended;

    mapping(address => uint) public bids;
    address[] public bidders;

    // 构造函数：初始化拍卖物品名称以及拍卖持续时间
    constructor(string memory _item, uint _biddingTime) {
        owner = msg.sender;
        item = _item;
        auctionEndTime = block.timestamp + _biddingTime;
    }

    // 用户出价函数：允许用户提交新的出价
    function bid(uint amount) external {
        require(block.timestamp < auctionEndTime, "Auction has already ended");
        require(amount > 0, "Bid must be greater than 0");
        require(amount > bids[msg.sender], "New bid must be higher than your previous bid");

        // 如果是第一次出价，则记录为新的竞拍者
        if (bids[msg.sender] == 0) {
            bidders.push(msg.sender);
        }

        // 更新该用户的出价
        bids[msg.sender] = amount;

        // 如果当前出价高于最高出价，则更新最高出价者和最高出价
        if (amount > highestBid) {
            highestBid = amount;
            highestBidder = msg.sender;
        }
    }

    // 在拍卖时间结束后调用该函数以结束拍卖
    function endAuction() external {
        require(block.timestamp >= auctionEndTime, "Auction has not ended yet");
        require(!ended, "拍卖已经结束过一次");

        // 标记拍卖为已结束
        ended = true;
    }

    // 获取所有参与竞拍的地址列表
    function getAllBidders() external view returns (address[] memory) {
        return bidders;
    }

    // 在拍卖结束后获取最终赢家地址以及其出价金额
    function getWinner() external view returns (address, uint) {
        require(ended, "拍卖尚未结束");
        return (highestBidder, highestBid);
    }
}