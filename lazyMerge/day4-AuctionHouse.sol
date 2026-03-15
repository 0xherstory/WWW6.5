 // SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract AuctionHouse {
    address public owner; // 所有者
    string public  item; // 拍卖品
    uint256 public min; // 最低拍卖价格
    uint256 public endTime; // 结束时间
    address private highestBidder; // 价高者
    uint256 private highestBid; // 最高出价
    bool public isEnded; // 是否结束
    mapping(address => uint) public bids; // 每个人的出价
    address[] public bidders; // 出价者

    constructor(string memory _item, uint _biddingTime, uint _min){
        // 这里是构造函数，合约部署只执行一次
        // 这里用于初始化拍卖信息
        owner = msg.sender;
        item = _item;
        min = _min;
        endTime = block.timestamp + _biddingTime;
    }

    // external 只能外部调用，比 public 函数的参数先复制到内存再读取更省 gas。
    // 出价
    function bid(uint256 amount) external {
        // 必须小于结束时间
        require(block.timestamp < endTime, "Auction has already ended.");
        // 必须大于最小出价
        require(amount > min, "Bid amount must be greater than min.");
        // 新出价必须高于自己之前的出价
        require(amount > bids[msg.sender], "New bid must be higher than your current bid.");

        bidders.push(msg.sender);
        bids[msg.sender] = amount;

        if(amount > highestBid) {
            highestBid = amount;
            highestBidder = msg.sender;
        }
    }

    // 结束活动
    function endAuction() external {
        // 必须大于结束时间ı
        require(block.timestamp >= endTime , "Auction hasn't ended yet.");
        // 必须是所有者
        require(owner == msg.sender, "Only owner can end auction");
        // 必须没有结束
        require(!isEnded, "Auction end already called.");

        isEnded = true;

    }

    // 查看最终拍卖获得者
    function getAllBidders() external view returns (address[] memory) {
        return bidders;
    }
    // 查看所有出价者
    function getWinner() external view returns (address, uint) {
        require(isEnded, "Auction has not ended yet."); 
       return (highestBidder, highestBid);
    }
}