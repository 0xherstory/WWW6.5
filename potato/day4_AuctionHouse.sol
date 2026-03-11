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
    
    // 构造函数：合约部署时只会执行一次
    constructor(string memory _item, uint _biddingTime) {
        // 1. 记录谁是这个合约的部署者（即主人）。在 Solidity 中，代表当前调用者地址的全局变量是什么？
        owner = msg.sender; //永远代表当前正在调用这个函数的人（的钱包地址）
        item = _item;
        
        // 2. 计算拍卖结束时间。我们需要获取当前区块链的时间戳，加上持续时间。
        // 获取当前区块时间戳的全局变量是什么？
        auctionEndTime = block.timestamp + _biddingTime;
    }
    
    function bid(uint amount) external {
        // 3. 条件检查：拍卖必须还没结束。用来做条件检查（如果不满足就报错回滚）的关键字是什么？
        require(block.timestamp < auctionEndTime, "Auction ended"); // require类似于assert
        require(amount > highestBid, "Bid too low");
        
        if (bids[msg.sender] == 0) {
            bidders.push(msg.sender);
        }
        
        // 4. 将本次出价累加到当前出价人的名下。这里应该填入代表当前出价人地址的变量。
        bids[msg.sender] += amount;
        
        if (bids[msg.sender] > highestBid) {
            highestBid = bids[msg.sender];
            highestBidder = msg.sender;
        }
    }
    
    function endAuction() external {
        require(!ended, "Auction already ended");
        
        // 5. 只有当当前时间 大于等于 拍卖结束时间时，才能结束。这里填哪个状态变量？
        require(block.timestamp >= auctionEndTime, "Auction not yet ended");
        
        // 6. 权限控制：只有合约的主人（部署者）可以结束拍卖。
        require(msg.sender == owner, "Only owner can end");
        
        ended = true;
    }
    
    // 7. 返回获胜者的地址和出价金额。获胜者地址（highestBidder）在 Solidity 中属于什么数据类型？
    function getWinner() external view returns (address, uint) {
        require(ended, "Auction not ended");
        return (highestBidder, highestBid);
    }
    
    function getAllBidders() external view returns (address[] memory) {
        return bidders;
    }
}