// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract AuctionHouse {
    // 拍卖者
    address private owner;
    // 拍卖标的物名称
    string public item;
    // 拍卖何时开始
    uint public auctionStartTime;
    // 拍卖何时结束
    uint public auctionEndTime;
    // 拍卖持续多久
    uint public auctionDuraTime;
    // 起拍价
    uint public startBid;
    // 目前是谁喊出了最高价
    address public highestBidder;
    // 目前最高价是多少
    uint public highestBid;
    // 拍卖是否在继续
    bool public isEnd;
    // 数据，一列是用户地址，一列是其出价，默认全为零
    mapping(address => uint) public bids;
    // 曾经出过价的用户集合
    address[] public bidders;
    
    // 初始化
    constructor(string memory _itemName, uint _startBid, uint _durationInSeconds) {
        // msg.sender 是一个局变量，它提供部署合约的操作者地址
        owner = msg.sender;
        item = _itemName;
        isEnd = false;
        startBid = _startBid;
        // 获取当前时间是 block.timestamp
        // 加上拍卖持续的时间就是拍卖结束的时间
        auctionStartTime = block.timestamp;
        auctionEndTime = auctionStartTime + _durationInSeconds;
        // 起拍价必须大于零
        require(startBid > 0, "Start bid must be greater than zero.");
       highestBid = startBid;
    }

    // 用户出价
    function bid(uint amount) external {
        // 检查拍卖状态
        require(!isEnd, "Auction has already ended.");
        require(block.timestamp < auctionEndTime, "Auction has already ended.");
        require(block.timestamp > auctionStartTime, "Auction has not started yet.");
        // 检查价格是否大于当前最高价格
        require(amount > highestBid, "Bid must be higher than current highest.");

        // 检查喊价者是否曾经出过价
        if (bids[msg.sender] == 0) {
            bidders.push(msg.sender);
        }
        // 更新数据
        bids[msg.sender] = amount;
        highestBid = amount;
        highestBidder = msg.sender;
    }

    function endAuction() private {
        isEnd = true;
        require(!isEnd, "Auction end already called.");
    }

    function getAllBidders() public view returns (address[] memory) {
        return bidders;
    }

}