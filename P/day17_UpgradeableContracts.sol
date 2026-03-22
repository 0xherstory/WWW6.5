// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
abstract contract SubscriptionStorage {
    address public owner; 
    address public logicContract;

    struct Plan {
        uint256 price;
        uint256 duration;
    }

    struct Subscription {
        uint8 planId;
        uint256 expiry;
        bool paused;
    }

    mapping(uint8 => Plan) public plans;

    mapping(address => Subscription) public subscriptions;

    modifier onlyOwner() {
        require(msg.sender == owner, "Not Authorized: Only Owner");
        _;
    }
}

contract SubscriptionProxy is SubscriptionStorage {
    constructor(address _initialLogic) {
        owner = msg.sender;
        logicContract = _initialLogic;
    }
    function upgradeTo(address _newLogic) external onlyOwner {
        require(_newLogic != address(0), "Invalid logic address");
        logicContract = _newLogic;
    }
    fallback() external payable {
        _delegate(logicContract);
    }

    receive() external payable {}

    function _delegate(address _logic) internal {
        assembly {
            calldatacopy(0, 0, calldatasize())
            let result := delegatecall(gas(), _logic, 0, calldatasize(), 0, 0)
            returndatacopy(0, 0, returndatasize())
            switch result
            case 0 { revert(0, returndatasize()) }
            default { return(0, returndatasize()) }
        }
    }
}
contract SubscriptionLogicV1 is SubscriptionStorage {
    
    function addPlan(uint8 _planId, uint256 _price, uint256 _duration) external onlyOwner {
        require(_price > 0, "Price must be positive");
        plans[_planId] = Plan(_price, _duration);
    }

    function subscribe(uint8 _planId) external payable {
        Plan memory plan = plans[_planId];
        require(plan.price > 0, "Plan does not exist");
        require(msg.value >= plan.price, "Insufficient ETH sent");

        Subscription storage sub = subscriptions[msg.sender];
        if (block.timestamp < sub.expiry) {
            sub.expiry += plan.duration;
        } else {
            sub.expiry = block.timestamp + plan.duration;
        }
        
        sub.planId = _planId;
        sub.paused = false;
    }
    function isActive(address _user) public view returns (bool) {
        Subscription memory sub = subscriptions[_user];
        return (block.timestamp < sub.expiry && !sub.paused);
    }
    function withdraw() external onlyOwner {
    (bool success, ) = payable(owner).call{value: address(this).balance}("");
require(success, "Transfer failed");
    }

}
contract SubscriptionLogicV2 is SubscriptionLogicV1 {

    function pauseAccount(address _user) external onlyOwner {
        subscriptions[_user].paused = true;
    }


    function resumeAccount(address _user) external onlyOwner {
        subscriptions[_user].paused = false;
    }
    
}