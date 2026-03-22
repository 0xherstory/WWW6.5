// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// 1. 接口定义
interface IDepositBox {
    function getOwner() external view returns (address);
    function transferOwnership(address newOwner) external;
    function storeSecret(string memory secret) external;
    function getSecret() external view returns (string memory);
    function getBoxType() external pure returns (string memory);
    function getDepositTime() external view returns (uint256);
}

// 2. 抽象基类合约（修复：private → internal）
abstract contract BaseDepositBox is IDepositBox {
    address public owner;
    string public metadata;
    string internal secret; // 修复这里！private 改为 internal
    uint256 public depositTime;

    constructor(string memory _metadata) {
        owner = msg.sender;
        metadata = _metadata;
        depositTime = block.timestamp;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Not owner");
        _;
    }

    function getOwner() external view override returns (address) {
        return owner;
    }

    function storeSecret(string memory _secret) external override onlyOwner {
        secret = _secret;
    }

    function getBoxType() external pure virtual override returns (string memory);
}

// 3. 基础保管箱合约
contract BasicDepositBox is BaseDepositBox {
    constructor(string memory _metadata) BaseDepositBox(_metadata) {}

    function getBoxType() external pure override returns (string memory) {
        return "Basic";
    }

    function getSecret() external view override onlyOwner returns (string memory) {
        return secret;
    }

    function getDepositTime() external view override returns (uint256) {
        return depositTime;
    }

    function transferOwnership(address newOwner) external override onlyOwner {
        require(newOwner != address(0), "Invalid address");
        owner = newOwner;
    }
}

// 4. 时间锁定保管箱合约
contract TimeLockedDepositBox is BaseDepositBox {
    uint256 public unlockTime;

    constructor(string memory _metadata, uint256 _lockDuration) 
        BaseDepositBox(_metadata) 
    {
        unlockTime = block.timestamp + _lockDuration;
    }

    modifier timeUnlocked() {
        require(block.timestamp >= unlockTime, "Still locked");
        _;
    }

    function getSecret() external view override onlyOwner timeUnlocked returns (string memory) {
        return secret;
    }

    function getBoxType() external pure override returns (string memory) {
        return "Time-Locked";
    }

    function getDepositTime() external view override returns (uint256) {
        return depositTime;
    }

    function transferOwnership(address newOwner) external override onlyOwner {
        require(newOwner != address(0), "Invalid address");
        owner = newOwner;
    }
}

// 5. 工厂管理合约
contract VaultManager {
    struct BoxInfo {
        address boxAddress;
        string boxType;
        string metadata;
    }

    mapping(address => BoxInfo[]) public userBoxes;

    function createBasicBox(string memory _metadata) external returns (address) {
        BasicDepositBox newBox = new BasicDepositBox(_metadata);
        newBox.transferOwnership(msg.sender);
        userBoxes[msg.sender].push(BoxInfo(address(newBox), "Basic", _metadata));
        return address(newBox);
    }

    function createTimeLockedBox(string memory _metadata, uint256 _lockDuration) external returns (address) {
        TimeLockedDepositBox newBox = new TimeLockedDepositBox(_metadata, _lockDuration);
        newBox.transferOwnership(msg.sender);
        userBoxes[msg.sender].push(BoxInfo(address(newBox), "Time-Locked", _metadata));
        return address(newBox);
    }

    function storeSecret(address boxAddress, string memory secret) external {
        IDepositBox(boxAddress).storeSecret(secret);
    }

    function getUserBoxesCount(address user) external view returns (uint256) {
        return userBoxes[user].length;
    }
}