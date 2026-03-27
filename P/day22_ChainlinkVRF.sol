// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

interface VRFCoordinatorV2Interface {
    function getRequestConfig() external view returns (uint16, uint32, bytes32[] memory);
    function requestRandomWords(
        bytes32 keyHash,
        uint64 subId,
        uint16 minimumRequestConfirmations,
        uint32 callbackGasLimit,
        uint32 numWords
    ) external returns (uint256 requestId);
    function createSubscription() external returns (uint64 subId);
    function getSubscription(uint64 subId) external view returns (uint96 balance, uint64 ethBalance, uint64 requestCount, address owner, address[] memory consumers);
    function addConsumer(uint64 subId, address consumer) external;
}

abstract contract VRFConsumerBaseV2 {
    address private immutable vrfCoordinator;
    constructor(address _vrfCoordinator) {
        vrfCoordinator = _vrfCoordinator;
    }
    function fulfillRandomWords(uint256 requestId, uint256[] memory randomWords) internal virtual;
    function rawFulfillRandomWords(uint256 requestId, uint256[] memory randomWords) external {
        require(msg.sender == vrfCoordinator, "Only coordinator can fulfill");
        fulfillRandomWords(requestId, randomWords);
    }
}

contract FairLottery is VRFConsumerBaseV2 {
    
    enum LotteryState { CLOSED, OPEN, CALCULATING }
    
    LotteryState public s_lotteryState;
    uint256 public immutable i_entryFee;
    address payable[] public s_players;
    address public immutable i_owner;
    address payable public s_recentWinner;

    VRFCoordinatorV2Interface private immutable i_vrfCoordinator;
    bytes32 private immutable i_gasLane; 
    uint64 private immutable i_subscriptionId;
    uint32 private immutable i_callbackGasLimit;
    uint16 private constant REQUEST_CONFIRMATIONS = 3;
    uint32 private constant NUM_WORDS = 1;

    event LotteryStarted();
    event PlayerEntered(address indexed player);
    event WinnerPicked(address indexed winner);
    event RequestedRandomness(uint256 indexed requestId);

    error NotOwner();
    error NotOpen();
    error InsufficientFee();
    error TransferFailed();

    constructor(
        address vrfCoordinatorV2,
        uint256 entryFee,
        bytes32 gasLane,
        uint64 subscriptionId,
        uint32 callbackGasLimit
    ) VRFConsumerBaseV2(vrfCoordinatorV2) {
        i_owner = msg.sender;
        i_vrfCoordinator = VRFCoordinatorV2Interface(vrfCoordinatorV2);
        i_entryFee = entryFee;
        i_gasLane = gasLane;
        i_subscriptionId = subscriptionId;
        i_callbackGasLimit = callbackGasLimit;
        s_lotteryState = LotteryState.CLOSED;
    }

    function startLottery() external {
        if (msg.sender != i_owner) revert NotOwner();
        s_lotteryState = LotteryState.OPEN;
        emit LotteryStarted();
    }

    function enterLottery() external payable {
        if (s_lotteryState != LotteryState.OPEN) revert NotOpen();
        if (msg.value < i_entryFee) revert InsufficientFee();

        s_players.push(payable(msg.sender));
        emit PlayerEntered(msg.sender);
    }

    function endLottery() external {
        if (msg.sender != i_owner) revert NotOwner();
        if (s_lotteryState != LotteryState.OPEN) revert NotOpen();
        if (s_players.length == 0) revert("No players in lottery");
        
        s_lotteryState = LotteryState.CALCULATING;
        
        uint256 requestId = i_vrfCoordinator.requestRandomWords(
            i_gasLane,
            i_subscriptionId,
            REQUEST_CONFIRMATIONS,
            i_callbackGasLimit,
            NUM_WORDS
        );
        
        emit RequestedRandomness(requestId);
    }

    function fulfillRandomWords(
        uint256 /* requestId */,
        uint256[] memory randomWords
    ) internal override {
        uint256 indexOfWinner = randomWords[0] % s_players.length;
        address payable winner = s_players[indexOfWinner];
        s_recentWinner = winner;

        s_lotteryState = LotteryState.CLOSED;
        s_players = new address payable[](0);

        uint256 amount = address(this).balance;
        (bool success, ) = winner.call{value: amount}("");
        if (!success) revert TransferFailed();

        emit WinnerPicked(winner);
    }

    function getPlayerCount() external view returns (uint256) {
        return s_players.length;
    }
}