// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

interface IERC20 {
    function totalSupply() external view returns (uint256);
    function balanceOf(address account) external view returns (uint256);
    function transfer(address to, uint256 amount) external returns (bool);
    function allowance(address owner, address spender) external view returns (uint256);
    function approve(address spender, uint256 amount) external returns (bool);
    function transferFrom(address from, address to, uint256 amount) external returns (bool);
    function decimals() external view returns (uint8);
}
contract YieldFarm {
    struct UserInfo {
        uint256 stakedAmount;
        uint256 rewardDebt;
        uint256 lastUpdateTimestamp;
    }

    address public owner;
    IERC20 public immutable stakingToken;
    IERC20 public immutable rewardToken;
    
    uint256 public rewardRatePerSecond;
    uint8 public stakingTokenDecimals;

    mapping(address => UserInfo) public users;

    event Staked(address indexed user, uint256 amount);
    event Unstaked(address indexed user, uint256 amount);
    event RewardClaimed(address indexed user, uint256 amount);
    event EmergencyWithdrawn(address indexed user, uint256 amount);
    event RewardRefilled(uint256 amount);

    error ZeroAmount();
    error InsufficientBalance();
    error Unauthorized();
    error TransferFailed();

    uint256 private _locked;
    modifier nonReentrant() {
        require(_locked == 0, "Reentrancy guard");
        _locked = 1;
        _;
        _locked = 0;
    }

    modifier onlyOwner() {
        if (msg.sender != owner) revert Unauthorized();
        _;
    }

    constructor(
        address _stakingToken, 
        address _rewardToken, 
        uint256 _rewardRate
    ) {
        owner = msg.sender;
        stakingToken = IERC20(_stakingToken);
        rewardToken = IERC20(_rewardToken);
        rewardRatePerSecond = _rewardRate;

        try IERC20(_stakingToken).decimals() returns (uint8 d) {
            stakingTokenDecimals = d;
        } catch {
            stakingTokenDecimals = 18;
        }
    }
    function _updateReward(address _user) internal {
        UserInfo storage user = users[_user];
        if (user.stakedAmount > 0) {
            uint256 timeElapsed = block.timestamp - user.lastUpdateTimestamp;
            uint256 pending = (user.stakedAmount * timeElapsed * rewardRatePerSecond) / (10 ** stakingTokenDecimals);
            user.rewardDebt += pending;
        }
        user.lastUpdateTimestamp = block.timestamp;
    }
    function stake(uint256 _amount) external nonReentrant {
        if (_amount == 0) revert ZeroAmount();

        _updateReward(msg.sender);
        bool success = stakingToken.transferFrom(msg.sender, address(this), _amount);
        if (!success) revert TransferFailed();

        users[msg.sender].stakedAmount += _amount;
        emit Staked(msg.sender, _amount);
    }

    function unstake(uint256 _amount) external nonReentrant {
        UserInfo storage user = users[msg.sender];
        if (_amount == 0 || _amount > user.stakedAmount) revert ZeroAmount();

        _updateReward(msg.sender);

        user.stakedAmount -= _amount;
        
        bool success = stakingToken.transfer(msg.sender, _amount);
        if (!success) revert TransferFailed();

        emit Unstaked(msg.sender, _amount);
    }
    function claimReward() external nonReentrant {
        _updateReward(msg.sender);
        
        uint256 reward = users[msg.sender].rewardDebt;
        if (reward == 0) revert ZeroAmount();
        
        if (rewardToken.balanceOf(address(this)) < reward) revert InsufficientBalance();

        users[msg.sender].rewardDebt = 0;
        bool success = rewardToken.transfer(msg.sender, reward);
        if (!success) revert TransferFailed();

        emit RewardClaimed(msg.sender, reward);
    }
    function emergencyWithdraw() external nonReentrant {
        UserInfo storage user = users[msg.sender];
        uint256 amount = user.stakedAmount;
        if (amount == 0) revert ZeroAmount();

        user.stakedAmount = 0;
        user.rewardDebt = 0;

        bool success = stakingToken.transfer(msg.sender, amount);
        if (!success) revert TransferFailed();

        emit EmergencyWithdrawn(msg.sender, amount);
    }

    function refillRewards(uint256 _amount) external onlyOwner {
        bool success = rewardToken.transferFrom(msg.sender, address(this), _amount);
        if (!success) revert TransferFailed();
        emit RewardRefilled(_amount);
    }

    function pendingRewards(address _user) external view returns (uint256) {
        UserInfo memory user = users[_user];
        uint256 reward = user.rewardDebt;
        if (user.stakedAmount > 0) {
            uint256 timeElapsed = block.timestamp - user.lastUpdateTimestamp;
            reward += (user.stakedAmount * timeElapsed * rewardRatePerSecond) / (10 ** stakingTokenDecimals);
        }
        return reward;
    }
}