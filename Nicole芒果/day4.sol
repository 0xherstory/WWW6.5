// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract AuctionHouse {

    //状态变量
    address public owner;//拍卖行的创建者地址； address是数据类型
    string public item;
    uint public auctionEndTime;
    address private highestBidder; 
    uint private highestBid;       
    bool public ended;

    mapping(address => uint) public bids;//这个是一个“记录簿”，记录每个竞标者的出价。通过这个，我们能知道每个人出价多少。
    address[] public bidders;//这是一个用来存储所有出价人的地址的列表。每个出过价的人都会被记录下来。
   
    //构造函数，仅执行一次（初始化）
    constructor(string memory _item, uint _biddingTime) {
        owner = msg.sender;//msg.sender表示谁在操作合约（固定表达）
        item = _item;
        auctionEndTime = block.timestamp + _biddingTime;//block.timestamp表示当前区块链的时间（固定表达）
    }

    // 函数一——出价
    //一个叫做bid的函数，接收一个传入参数，无返回参数
    function bid(uint amount) external {
        require(block.timestamp < auctionEndTime, "Auction has already ended.");
        //require是条件判断语句，“require（条件，“错误提示”）”
        //看拍卖时间是否截止
        require(amount > 0, "Bid amount must be greater than zero.");
        //看出价是否是否大于0，即是否有效
        require(amount > bids[msg.sender], "New bid must be higher than your current bid.");
        //看出价是否高于这位客户的上次出价
       
        // 用if 判断是不是新的竞价者
        if (bids[msg.sender] == 0) {
            bidders.push(msg.sender);
        }
        //if用法： if（条件）{要执行的代码}
        //即：如果符合条件，就执行代码，如果不符合条件，就不执行代码

        bids[msg.sender] = amount;
        //在bids映射中更新信息

        
        if (amount > highestBid) {
            highestBid = amount;
            highestBidder = msg.sender;
        }
        //看出价是否高于最高价，如果是就更新最高出价和最高出价者
    }

    // 函数二
    //一个叫做endAuction的函数，没有接收参数，没有返回参数
    function endAuction() external {
        //external表示外部不可调用，内部可调用
        //对比public，内外都可调用
        require(block.timestamp >= auctionEndTime, "Auction hasn't ended yet.");
        //
        require(!ended, "Auction end already called.");

        ended = true;
    }

    // 函数三
    function getAllBidders() external view returns (address[] memory) {
        return bidders;
    }

    // 函数四
    function getWinner() external view returns (address, uint) {
        require(ended, "Auction has not ended yet.");
        return (highestBidder, highestBid);
    }
}