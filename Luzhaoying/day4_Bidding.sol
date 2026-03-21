// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Bidding {
// 1. 声明状态变量
    address public owner; // 拍卖所有者
    string public item; // 拍卖物品
    uint public auctionEndTime; // 拍卖结束时间
    bool public ended; // 拍卖是否已结束

    // 设置起拍价
    uint public startingPrice;

    // 最低加价百分比 (5 表示 5%)
    uint public minIncreasePercent = 5; 

    // 出价记录
    mapping(address => uint) public bids;
    address[] public bidders;

    // 最高出价信息
    uint public highestBid;
    address public highestBidder;

// 2. 构造函数
    constructor(string memory _item, uint _biddingTime, uint _startingPrice) {
        owner = msg.sender;
        item = _item;
        auctionEndTime = block.timestamp + _biddingTime;
        // 设置起拍价
        startingPrice = _startingPrice;
        highestBid = _startingPrice; // 初始最高出价即为起拍价
    }

// 3.拍卖过程
    function bid(uint amount) external {
        require(block.timestamp < auctionEndTime, "Auction has already ended.");
        require(amount > 0, "Bid amount must be greater than zero.");
        
        // 检查是否高于自己当前的出价
        require(amount > bids[msg.sender], "New bid must be higher than your current bid.");

        // 强制执行最低加价规则 (5%) 
        // 计算当前最高出价的 5% 上涨幅度
        uint minRequiredBid = highestBid + (highestBid * minIncreasePercent / 100);
        require(amount >= minRequiredBid, "Bid must be at least 5% higher than the current highest bid.");
        // 如果是该用户第一次出价，记录到列表中
        if (bids[msg.sender] == 0) {
            bidders.push(msg.sender);
        }

        bids[msg.sender] = amount;
        // 更新最高出价
        if (amount > highestBid) {
            highestBid = amount;
            highestBidder = msg.sender;
        }
    }

// 4.允许非最高出价者撤回出价
    function withdrawBid() external {
        require(block.timestamp < auctionEndTime, "Auction has ended, cannot withdraw.");
        
        uint amountToWithdraw = bids[msg.sender];
        require(amountToWithdraw > 0, "You have no bid to withdraw.");

        // 安全检查：不能撤回最高出价（否则需要复杂的第二高价逻辑，这里简化为禁止）
        require(msg.sender != highestBidder, "Cannot withdraw the highest bid directly.");

        // 重置出价
        bids[msg.sender] = 0;

        // 注意：在真实的支付系统中，这里应该有 payable 逻辑来发送 ETH 回给用户
        // 例如：payable(msg.sender).transfer(amountToWithdraw);
        // 但为了保持示例简洁（非 payable），此处仅模拟状态变更。
    }

//5. 拍卖结束
    function endAuction() external {
        require(block.timestamp >= auctionEndTime, "Auction hasn't ended yet.");
        require(!ended, "Auction end already called.");
        ended = true;
    }

//6. 拍卖结束后查看信息

    // 查看获胜者
    function getWinner() external view returns (address, uint) {
        require(ended, "Auction has not ended yet.");
        return (highestBidder, highestBid);
    }   
    // 查看所有参与者
    function getAllBidders() external view returns (address[] memory) {
        return bidders;
    }
}