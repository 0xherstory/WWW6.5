// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

// 拍卖行合约：day4_auction.sol
contract AuctionHouse {
    // 公共状态变量（外部可直接查看）
    address public owner;          // 拍卖主人（部署合约的账户）
    string public item;            // 拍卖物品
    uint public auctionEndTime;    // 拍卖结束时间戳
    bool public ended;             // 拍卖是否结束

    // 私有状态变量（外部不能直接看，需通过函数）
    address private highestBidder; // 最高出价者地址
    uint private highestBid;       // 最高出价金额

    // 映射：记录每个地址的总出价；数组：记录所有出价者地址
    mapping(address => uint) public bids;
    address[] public bidders;

    // 构造函数：部署时传参（拍卖物品、拍卖时长<秒>）
    constructor(string memory _item, uint _biddingTime) {
        owner = msg.sender; // 部署者就是owner
        item = _item;
        auctionEndTime = block.timestamp + _biddingTime; // 结束时间=当前时间+时长
    }

    // 出价函数：外部账户调用出价
    function bid(uint amount) external {
        // 检查：拍卖未结束、出价高于当前最高价
        require(block.timestamp < auctionEndTime, "Auction has ended");
        require(amount > highestBid, "Bid amount is too low");

        // 第一次出价的账户，加入出价者数组
        if (bids[msg.sender] == 0) {
            bidders.push(msg.sender);
        }

        bids[msg.sender] += amount; // 累加当前账户的总出价

        // 如果累加后是新高，更新最高出价和出价者
        if (bids[msg.sender] > highestBid) {
            highestBid = bids[msg.sender];
            highestBidder = msg.sender;
        }
    }

    // 结束拍卖函数：只有owner能调用，且时间已到、未结束过
    function endAuction() external {
        require(!ended, "Auction already ended");
        require(block.timestamp >= auctionEndTime, "Auction not yet ended");
        require(msg.sender == owner, "Only owner can end auction");
        ended = true; // 标记拍卖结束
    }

    // 查询获胜者：拍卖结束后才能查，返回（最高出价者地址，最高金额）
    function getWinner() external view returns (address, uint) {
        require(ended, "Auction not ended yet");
        return (highestBidder, highestBid);
    }

    // 查询所有出价者：返回所有参与出价的地址列表
    function getAllBidders() external view returns (address[] memory) {
        return bidders;
    }
}