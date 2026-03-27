// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;
contract EnhancedSimpleEscrow {
    enum State { AWAITING_PAYMENT, AWAITING_DELIVERY, DISPUTED, COMPLETED, CANCELLED }

    address public buyer;
    address public seller;
    address public arbiter; 
    
    uint256 public amount;
    uint256 public timeoutTimestamp;
    uint256 public constant ESCROW_DURATION = 7 days; 

    State public currState;

    event FundsDeposited(address buyer, uint256 amount);
    event DeliveryConfirmed();
    event DisputeRaised(address raiser);
    event DisputeResolved(address winner);
    event TransactionCancelled();

    error InvalidState();
    error Unauthorized();
    error TimeoutNotReached();
    error AlreadyCancelled();

    modifier onlyBuyer() {
        if (msg.sender != buyer) revert Unauthorized();
        _;
    }

    modifier onlySeller() {
        if (msg.sender != seller) revert Unauthorized();
        _;
    }

    modifier onlyArbiter() {
        if (msg.sender != arbiter) revert Unauthorized();
        _;
    }

    modifier inState(State _state) {
        if (currState != _state) revert InvalidState();
        _;
    }

    constructor(address _seller, address _arbiter) {
        buyer = msg.sender;
        seller = _seller;
        arbiter = _arbiter;
        currState = State.AWAITING_PAYMENT;
    }

    function deposit() external payable inState(State.AWAITING_PAYMENT) onlyBuyer {
        require(msg.value > 0, "Amount must be > 0");
        amount = msg.value;
        timeoutTimestamp = block.timestamp + ESCROW_DURATION;
        currState = State.AWAITING_DELIVERY;
        emit FundsDeposited(buyer, msg.value);
    }

    function confirmDelivery() external inState(State.AWAITING_DELIVERY) onlyBuyer {
        currState = State.COMPLETED;
        uint256 payment = amount;
        amount = 0;
        
        (bool success, ) = payable(seller).call{value: payment}("");
        require(success, "Transfer to seller failed");
        
        emit DeliveryConfirmed();
    }


    function raiseDispute() external inState(State.AWAITING_DELIVERY) {
        if (msg.sender != buyer && msg.sender != seller) revert Unauthorized();
        currState = State.DISPUTED;
        emit DisputeRaised(msg.sender);
    }


    function resolveDispute(bool _toBuyer) external inState(State.DISPUTED) onlyArbiter {
        currState = State.COMPLETED;
        uint256 payment = amount;
        amount = 0;

        address winner = _toBuyer ? buyer : seller;
        (bool success, ) = payable(winner).call{value: payment}("");
        require(success, "Dispute resolution transfer failed");

        emit DisputeResolved(winner);
    }

    function cancelMutual() external inState(State.AWAITING_DELIVERY) {

        currState = State.CANCELLED;
        uint256 refund = amount;
        amount = 0;

        (bool success, ) = payable(buyer).call{value: refund}("");
        require(success, "Refund failed");

        emit TransactionCancelled();
    }

    function cancelAfterTimeout() external inState(State.AWAITING_DELIVERY) onlyBuyer {
        if (block.timestamp < timeoutTimestamp) revert TimeoutNotReached();
        
        currState = State.CANCELLED;
        uint256 refund = amount;
        amount = 0;

        (bool success, ) = payable(buyer).call{value: refund}("");
        require(success, "Timeout refund failed");

        emit TransactionCancelled();
    }

    function getContractBalance() external view returns (uint256) {
        return address(this).balance;
    }
}