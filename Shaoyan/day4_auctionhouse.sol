// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract AuctionHouse {

    // 自定义错误（比 require("msg") 更省 gas）
    error AuctionEnded();        // 拍卖已结束
    error BidTooLow();           // 出价过低
    error AuctionNotEnded();     // 拍卖尚未结束
    error AlreadyEnded();        // 拍卖已经被结束
    error WinnerNotDetermined(); // 拍卖未结束，无法确定赢家

    // 合约拥有者（部署者），immutable 表示部署后不可修改
    address public immutable owner;

    // 拍卖物品名称
    string public item;

    // 拍卖结束时间（uint40 节省存储空间，足够表示未来几十年的时间戳）
    uint40 public auctionEndTime;

    // 当前最高出价者
    address public highestBidder;

    // 当前最高出价
    uint public highestBid;

    // 拍卖是否已经结束
    bool public ended;

    // 记录每个地址的当前出价
    mapping(address => uint) public bids;

    // 所有参与竞拍的地址列表
    address[] public bidders;

    // 用户出价事件（方便前端或链上监听）
    event BidPlaced(address indexed bidder, uint amount);

    // 拍卖结束事件
    event AuctionFinished(address indexed winner, uint winningBid);

    // 构造函数：初始化拍卖物品和拍卖持续时间
    constructor(string memory _item, uint _biddingTime) {
        owner = msg.sender;
        item = _item;

        // 当前时间 + 拍卖持续时间
        auctionEndTime = uint40(block.timestamp + _biddingTime);
    }

    // 用户出价
    function bid(uint amount) external {

        // 如果已经超过拍卖时间则拒绝出价
        if (block.timestamp >= auctionEndTime) revert AuctionEnded();

        uint prev = bids[msg.sender];

        // 新出价必须高于自己之前的出价
        if (amount <= prev) revert BidTooLow();

        // 如果是第一次出价，则记录为新的竞拍者
        if (prev == 0) bidders.push(msg.sender);

        // 更新用户出价
        bids[msg.sender] = amount;

        // 如果成为新的最高价，则更新赢家
        if (amount > highestBid) {
            highestBid = amount;
            highestBidder = msg.sender;
        }

        // 触发出价事件
        emit BidPlaced(msg.sender, amount);
    }

    // 结束拍卖
    function endAuction() external {

        // 未到结束时间
        if (block.timestamp < auctionEndTime) revert AuctionNotEnded();

        // 防止重复结束
        if (ended) revert AlreadyEnded();

        ended = true;

        // 触发拍卖结束事件
        emit AuctionFinished(highestBidder, highestBid);
    }

    // 获取所有竞拍者地址
    function getAllBidders() external view returns (address[] memory) {
        return bidders;
    }

    // 获取最终赢家
    function getWinner() external view returns (address, uint) {

        // 拍卖未结束时无法查看赢家
        if (!ended) revert WinnerNotDetermined();

        return (highestBidder, highestBid);
    }
}