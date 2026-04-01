// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./SubscriptionStorageLayout.sol";

contract SubscriptionLogicV2 is SubscriptionStorageLayout{
    function addPlan(uint8 planId, uint256 price, uint256 duration) external{
        require(msg.sender == owner,"Only owner!");
        planPrices[planId] = price;
        planDuration[planId] = duration;
    }

    function subcribe(uint8 planId) external payable{
        require(planPrices[planId] > 0, "Invalid plan");
        require(msg.value >= planPrices[planId], "Insufficient payment");

        Subscription storage s = subscriptions[msg.sender];
        if (block.timestamp < s.expiry){
            s.expiry += planDuration[planId];
        } else {
            s.expiry = block.timestamp + planDuration[planId];
        }

        s.planId = planId;
        s.paused = false;
    }

    function isActive(address user) external view returns (bool) {
        Subscription memory s = subscriptions[user];
        return (block.timestamp < s.expiry && !s.paused);
    }

    function pauseAccount(address user) external {
        subscriptions[user].paused = true;
    }

    function resumeAccount(address user) external {
        subscriptions[user].paused = false;
    }
}

// 0xeF9B26046a2392C956320200eE0818543aA96aB7