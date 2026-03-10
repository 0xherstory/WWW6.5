// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract AuctionHouse {
    address public owner;
    string public itemDescription;
    uint256 public auctionEndTime;
    
    address public highestBidder; 
    uint256 public highestBid;

    bool public ended;

    // 记录待退还给投标人的金额
    mapping(address => uint256) public pendingReturns;

    constructor(string memory _description, uint256 _duration) {
        owner = msg.sender;
        itemDescription = _description;
        auctionEndTime = block.timestamp + _duration;
    }

    function bid() public payable {
        // 1. 检查时间
        require(block.timestamp <= auctionEndTime, "Auction already ended.");
        // 2. 检查出价是否高于当前最高价
        require(msg.value > highestBid, "There already is a higher bid.");

        // 3. 将之前的最高价金额记入退款账本
        if (highestBid != 0) {
            pendingReturns[highestBidder] += highestBid;
        }

        // 4. 更新最高价信息
        highestBid = msg.value;
        highestBidder = msg.sender;
    }

    // 投标失败的人自己领回钱
    function withdraw() public returns (bool) {
        uint256 amount = pendingReturns[msg.sender];
        if (amount > 0) {
            pendingReturns[msg.sender] = 0; // 先清零防止重入攻击

            if (!payable(msg.sender).send(amount)) {
                pendingReturns[msg.sender] = amount; // 发送失败则恢复金额
                return false;
            }
        }
        return true;
    }

    function endAuction() public {
        require(block.timestamp > auctionEndTime, "Auction not yet ended.");
        require(!ended, "endAuction has already been called.");

        ended = true;
        
        // 将最高价转给拍卖发起人（owner）
        payable(owner).transfer(highestBid);
    }
    
    function getWinner() public view returns (address, uint256) {
        require(ended, "Auction is still ongoing!");
        return (highestBidder, highestBid);
    }
}
