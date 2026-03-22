// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;
contract MockRainfallOracle {
    string public constant description = "Local Rainfall Data (mm)";
    uint8 public constant decimals = 2; 
    uint256 public constant version = 1;

    address public owner;


    struct RoundData {
        uint80 roundId; 
        int256 answer;
        uint256 startedAt;
        uint256 updatedAt;
        uint80 answeredInRound; 
    }

    uint80 private latestRoundId;
    mapping(uint80 => RoundData) private history;


    event RainfallUpdated(uint80 indexed roundId, int256 rainfall, uint256 timestamp);

    constructor() {
        owner = msg.sender;

        _updateRandomRainfall(1000);
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Not owner");
        _;
    }

    function updateRandomRainfall(int256 _newRainfall) external onlyOwner {
        _updateRandomRainfall(_newRainfall);
    }

    function _updateRandomRainfall(int256 _newRainfall) private {
        latestRoundId++;
        
        RoundData memory newData = RoundData({
            roundId: latestRoundId,
            answer: _newRainfall,
            startedAt: block.timestamp,
            updatedAt: block.timestamp,
            answeredInRound: latestRoundId
        });

        history[latestRoundId] = newData;
        emit RainfallUpdated(latestRoundId, _newRainfall, block.timestamp);
    }

    function latestRoundData()
        external
        view
        returns (
            uint80 roundId,
            int256 answer,
            uint256 startedAt,
            uint256 updatedAt,
            uint80 answeredInRound
        )
    {
        RoundData memory data = history[latestRoundId];
        return (data.roundId, data.answer, data.startedAt, data.updatedAt, data.answeredInRound);
    }

    function getRoundData(uint80 _roundId)
        external
        view
        returns (
            uint80 roundId,
            int256 answer,
            uint256 startedAt,
            uint256 updatedAt,
            uint80 answeredInRound
        )
    {
        require(_roundId <= latestRoundId && _roundId > 0, "Invalid round ID");
        RoundData memory data = history[_roundId];
        return (data.roundId, data.answer, data.startedAt, data.updatedAt, data.answeredInRound);
    }
}