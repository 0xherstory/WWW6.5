// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Auction {
    address payable public seller;
    uint256 public endAt;
    address public highestBidder;
    uint256 public highestBid;
    bool public ended;
    mapping(address => uint256) public pendingReturns;

    constructor(uint256 durationSeconds) {
        require(durationSeconds > 0, "Invalid duration");
        seller = payable(msg.sender);
        endAt = block.timestamp + durationSeconds;
    }

    function bid() external payable {
        require(block.timestamp < endAt, "Auction ended");
        require(msg.value > highestBid, "Bid too low");
        if (highestBidder != address(0)) {
            pendingReturns[highestBidder] += highestBid;
        }
        highestBidder = msg.sender;
        highestBid = msg.value;
    }

    function withdraw() external returns (bool) {
        uint256 amount = pendingReturns[msg.sender];
        require(amount > 0, "Nothing to withdraw");
        pendingReturns[msg.sender] = 0;
        (bool ok, ) = payable(msg.sender).call{value: amount}("");
        require(ok, "Withdraw failed");
        return ok;
    }

    function end() external {
        require(block.timestamp >= endAt, "Not ended");
        require(!ended, "Already ended");
        ended = true;
        (bool ok, ) = seller.call{value: highestBid}("");
        require(ok, "Payout failed");
    }
}
