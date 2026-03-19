// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "https://github.com/smartcontractkit/chainlink/blob/develop/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";

contract ADrenchedDogNeedsAnExtraMeal is Ownable {

    AggregatorV3Interface private weatherOracle;
    
    uint256 public constant RAINFALL_THRESHOLD = 16;
    uint256 public constant PAYOUT_MULTIPLIER = 100;
    
    mapping(address => bool) public hasInsurance;
    mapping(address => uint256) public premiumPaid;
    mapping(address => uint256) public lastClaimTimestamp;

    constructor(address _weatherOracle) Ownable(msg.sender) {
        weatherOracle = AggregatorV3Interface(_weatherOracle);
    }

    // 购买保险时记录：主人地址 + 付了多少保费
    event InsurancePurchased(address indexed owner, uint256 premiumAmount);

    // 申请理赔时记录：主人地址 + 当时降雨量
    event ClaimSubmitted(address indexed owner, uint256 rainfall);

    // 理赔成功时记录：主人地址 + 赔了多少钱
    event ClaimPaid(address indexed owner, uint256 payoutAmount);

    function getCurrentRainfall() public view returns (uint256) {
    (
        ,
        int256 rainfall,
        ,
        ,
    ) = weatherOracle.latestRoundData();
    return uint256(rainfall);
    }

    function buyInsurance() external payable {
    require(!hasInsurance[msg.sender], "Already insured");  // 没买过才能买
    require(msg.value > 0, "Need to pay");                  // 必须付钱
    
    premiumPaid[msg.sender] = msg.value;   // 记录付了多少保费
    hasInsurance[msg.sender] = true;       // 标记已买保险
    
    emit InsurancePurchased(msg.sender, msg.value);  // 广播
    }

    function claimDogWalk() external {
    require(hasInsurance[msg.sender], "No insurance");
    require(
        block.timestamp >= lastClaimTimestamp[msg.sender] + 1 days,
        "Wait 24h"
    );

    uint256 rainfall = getCurrentRainfall();
    emit ClaimSubmitted(msg.sender, rainfall);

    if(rainfall > RAINFALL_THRESHOLD) {
        lastClaimTimestamp[msg.sender] = block.timestamp;
        
        uint256 payout = premiumPaid[msg.sender] * PAYOUT_MULTIPLIER;
        
        (bool success,) = msg.sender.call{value: payout}("");
        require(success, "Transfer failed");
        
        emit ClaimPaid(msg.sender, payout);
    }
    }

   function withdraw() external onlyOwner {
    (bool success,) = payable(owner()).call{value: address(this).balance}("");
    require(success, "Transfer failed");
    }  // ← 先关闭withdraw！

    receive() external payable {}  // ✅ 在外面

    function getBalance() public view returns (uint256) {
    return address(this).balance;
    }

}  // ← 最后关闭合约
