// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract AuctionHouse {
    address public owner; //部署合约的人。并将其设为public ，以便任何人都可以验证竞拍的所有者。
    string public item;//拍卖创建者描述即将被竞拍的东西。
    uint public auctionEndTime; //定义它的持续时间，并使用时间戳跟踪拍卖结束的时间。
    address private highestBidder; /*迄今为止的最高出价，以及出价人的地址。标记为private ，
    这样没有人可以直接访问它们并欺骗系统。*/
    uint private highestBid;
    bool public ended;//标记拍卖是否完成,以确保它不会被结束两次，或者有人过早地查看获胜者。

    mapping(address => uint) public bids;//记录每个用户的出价。确保人们不会再次出相同金额的价，并且知道谁参与了竞标。
    address[] public bidders;//完整列出所有至少出价一次的人的名单

    constructor(string memory _item, uint _biddingTime) {
        owner = msg.sender;//是一个全局变量——它给我们提供部署合约的操作者地址 。
        item = _item;
        auctionEndTime = block.timestamp + _biddingTime;//拍卖应持续的时间（以秒为单位）。将它加到当前时间（block.timestamp）上，以确定拍卖何时结束。
    }

    function bid(uint amount) external {//设置规则——如果规则失败，函数会立即停止。
        require(block.timestamp < auctionEndTime, "Auction has already ended.");//如果当前时间已过拍卖截止时间，将不再接受更多出价。
        require(amount > 0, "Bid amount must be greater than zero.");//不希望有人出价零或负数。
        require(amount > bids[msg.sender], "New bid must be higher than your current bid.");//出价是否高于该用户的上次出价

        if (bids[msg.sender] == 0) {//如果这是用户的首次出价 ，我们将他们添加到bidders数组中。得到一个完整的参与人员名单。
            bidders.push(msg.sender);
        }

        bids[msg.sender] = amount;//在bids映射中更新他们的出价金额。

        // Update the highest bid and bidder
        if (amount > highestBid) {//是不是新的最高价者
            highestBid = amount;
            highestBidder = msg.sender;//如果这是目前为止看到的最大出价，会同时更新出价和出价者。
        }
    }

    // 某个时刻，拍卖必须停止。
    function endAuction() external {
        require(block.timestamp >= auctionEndTime, "Auction hasn't ended yet.");//检查拍卖时间是否已过
        require(!ended, "Auction end already called.");//确保没有人已经结束它

        ended = true;//如果一切顺利，翻转 ended 标志
    }

//仅返回bidders数组，所以任何人都可以看到参与情况。
    function getAllBidders() external view returns (address[] memory) {
        return bidders;
    }

    // 不想在拍卖结束前暴露获胜者。检查拍卖是否已结束。如果已结束，返回获胜者的地址和他们的出价。
    function getWinner() external view returns (address, uint) {
        require(ended, "Auction has not ended yet.");
        return (highestBidder, highestBid);
    }
}