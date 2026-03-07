// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract AuctionHouse{
    //声明变量：
    //所有者；被竞拍的物品；拍卖结束时间
    address public owner;
    string public item;
    uint public auctionEndTime;
    //目前为止的最高出价；出价人的地址——标记为privat
    address private highestBidder;
    uint private highestBid;
    //拍卖结束的标志——bool，初始为false，拍卖结束切换成true
    bool public ended;
    //每个用户的出价
    mapping (address => uint) public bids;
    address[] public bidders;

    //该部分在合约部署时仅执行一次
    constructor (string memory _item, uint _biddingTime) {
        owner = msg.sender; //全局变量，提供操作者的地址
        item = _item;
        auctionEndTime = block.timestamp + _biddingTime; //block.timestamp为当前时间；_biddingTime为拍卖应持续时间（以s为单位）
    }

    //出价人的操作
    function bid (uint amount) external {
        require (block.timestamp < auctionEndTime, "Auction has already ended."); //当前时间必须小于拍卖结束的时间
        require (amount > 0, "Bid amount must be greater than zero."); //出价人的金额必须有效（不能为零或负数）
        require (amount > bids[msg.sender], "New bid must be higher than your current bid."); //这次出价需高于该出价人的上次出价

        if (bids[msg.sender] == 0) {
            bidders.push(msg.sender);
        }//如果这是用户的首次出价，将其添加到bidders数组中（Question：当添加其到数组中之前，为什么查询到的出价是0？）

        bids[msg.sender] = amount; //保存出价人的出价

        if (amount > highestBid) {
            highestBid = amount;
            highestBidder = msg.sender;
        }//如果是目前为止的最高出价，则同步更新
    }

    //拍卖的结束
    function endAuction() external {
        require (block.timestamp >= auctionEndTime, "Auction hasn't ended yet."); //拍卖结束需要当前时间大于拍卖结束时间
        require (!ended, "Auction end already called."); //拍卖结束需要没有人人为地终止
        ended = true;
    }

    //拍卖结束后查看信息
    function getWinner() external view returns (address, uint) {
        require (ended, "Auction has not ended yet."); //查看信息必须要等到拍卖结束
        return (highestBidder, highestBid);
    }

    //查看所有的出价人
    function getAllBidders() external view returns (address[] memory) {
        return bidders; //(Question：查看所有出价人的信息不需要等到拍卖结束吗？）
    }
}