// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract AuctionHouse {
    address public owner;    //拍卖发起者
    string public item;      //拍卖物名称
    uint public auctionEndTime;  //拍卖结束时间
    address private highestBidder;  //最高出价者-私有，仅内部/函数访问
    uint private highestBid;        //最高出价金额
    bool public ended;           //拍卖是否结束标记

    mapping(address => uint) public bids;   //记录每个地址的出价金额
    address[] public bidders;               //所有出价者地址列表

    //仅拍卖发起者可调用
    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this function");
        _;
    }

    //拍卖未结束可调用
    modifier auctionNotEnded() {
        require(block.timestamp < auctionEndTime, "Auction has ended");
        require(!ended, "Auction already ended");
        _;
    }

    //拍卖已结束可调用
    modifier auctionEnded() {
        require(block.timestamp >= auctionEndTime || ended, "Auction not ended");
        _;
    }

    //构造函数
    constructor(string memory _item, uint _biddingTime) {
        owner = msg.sender;
        item = _item;
        //结束时间=当前区块时间+竞拍时长
        auctionEndTime = block.timestamp + _biddingTime;
        ended = false;
        highestBid = 0;
    }

    //核心功能函数
    function bid(uint amount) public payable auctionNotEnded {
        require(amount > 0,"Bid amount must be greater than 0");
        require(amount > bids[msg.sender], "New bid must be higher than current bid");

        //更新该地址出价记录
        bids[msg.sender] = amount;
        //若为新出价者，加列表
        bool isNewBidder = true;
        for (uint i = 0; i < bidders.length; i++) {
            if (bidders[i] == msg.sender) {
                isNewBidder = false;
                break;
            }
        }
        if (isNewBidder) {
            bidders.push(msg.sender);
        }
        //更新最高出价及出价者
        if (amount > highestBid) {
            highestBidder = msg.sender;
            highestBid = amount;
        }
    }
    //结束拍卖
    function endAuction() public onlyOwner auctionNotEnded {
        require(block.timestamp >= auctionEndTime, "Auction time not ended");
        ended = true;
    }
    //获取所有出价者地址列表
    function getAllBidders() public view returns (address[] memory) {
        return bidders;
    }
    //获取拍卖赢家（最高出价者及金额）
    function getWinner() public view auctionEnded returns (address, uint) {
        require(ended, "Auction not ended yet");
        return (highestBidder, highestBid);
    }
}





