// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// 导入OpenZeppelin的ERC20标准接口（母合约，兼容所有ERC20代币）
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
// 导入OpenZeppelin的重入防护母合约（防重入攻击，安全核心）
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
// 导入OpenZeppelin的安全类型转换母合约（防止溢出）
import "@openzeppelin/contracts/utils/math/SafeCast.sol";

// 用于获取 ERC-20 元数据(小数位数)的接口（继承母合约IERC20）
interface IERC20Metadata is IERC20 {
    function decimals() external view returns (uint8);
    function name() external view returns (string memory);
    function symbol() external view returns (string memory);
}

/// @title 收益耕作平台（Yield Farming）
/// @dev 质押代币以随时间赚取奖励，可选紧急提取和管理员补充
contract YieldFarming is ReentrancyGuard {
    using SafeCast for uint256; // 使用SafeCast进行安全类型转换，防止溢出

    // ==================== 状态变量：存储平台核心数据 ====================
    IERC20 public immutable stakingToken;    // 质押的代币（用户存的代币）
    IERC20 public immutable rewardToken;     // 奖励代币（给用户发的奖励）

    uint256 public immutable rewardRatePerSecond; // 每秒分配的奖励（单位：wei/秒）
    address public owner;                    // 平台管理员（部署者）

    uint8 public stakingTokenDecimals;       // 质押代币的小数位数（自动获取，默认18）

    // ==================== 质押者信息结构体：存储每个用户的质押数据 ====================
    struct StakerInfo {
        uint256 stakedAmount;    // 用户质押的代币数量
        uint256 rewardDebt;       // 用户待领取的奖励（利息）
        uint256 lastUpdate;       // 上次更新奖励的时间戳（算时间差用）
    }

    // 存储所有质押者的信息：用户地址 => 质押信息
    mapping(address => StakerInfo) public stakers;

    // ==================== 事件：记录所有操作，链上可查、透明 ====================
    event Staked(address indexed user, uint256 amount);          // 用户质押成功
    event Unstaked(address indexed user, uint256 amount);        // 用户解质押成功
    event RewardClaimed(address indexed user, uint256 amount);  // 用户领取奖励成功
    event EmergencyWithdraw(address indexed user, uint256 amount); // 用户紧急提取成功
    event RewardRefilled(address indexed owner, uint256 amount); // 管理员补充奖励成功

    // ==================== 权限修饰器：只有管理员能调用 ====================
    modifier onlyOwner() {
        require(msg.sender == owner, "Not the owner");
        _;
    }

    // ==================== 构造函数：部署合约时初始化 ====================
    constructor(
        address _stakingToken,    // 质押代币的合约地址
        address _rewardToken,     // 奖励代币的合约地址
        uint256 _rewardRatePerSecond // 每秒发放的奖励（单位：wei/秒）
    ) {
        stakingToken = IERC20(_stakingToken);
        rewardToken = IERC20(_rewardToken);
        rewardRatePerSecond = _rewardRatePerSecond;
        owner = msg.sender;

        // 自动获取质押代币的小数位数，兼容不同ERC20
        try IERC20Metadata(_stakingToken).decimals() returns (uint8 decimals) {
            stakingTokenDecimals = decimals;
        } catch {
            stakingTokenDecimals = 18; // 获取失败，默认18位小数（ETH标准）
        }
    }

    // ==================== 功能1：用户质押代币，开始赚奖励（核心功能） ====================
    function stake(uint256 amount) external nonReentrant {
        require(amount > 0, "Cannot stake 0"); // 必须质押大于0的代币

        // 先更新用户的奖励，确保利息计算到当前时间
        updateRewards(msg.sender);

        // 把用户的质押代币转到合约里
        stakingToken.transferFrom(msg.sender, address(this), amount);
        // 给用户的质押余额加钱
        stakers[msg.sender].stakedAmount += amount;

        emit Staked(msg.sender, amount);
    }

    // ==================== 功能2：用户解质押，拿回本金，停止赚奖励 ====================
    function unstake(uint256 amount) external nonReentrant {
        require(amount > 0, "Cannot unstake 0"); // 必须解质押大于0的代币
        // 用户质押余额必须足够
        require(stakers[msg.sender].stakedAmount >= amount, "Insufficient staked amount");

        // 先更新用户的奖励，确保利息计算到当前时间
        updateRewards(msg.sender);

        // 扣减用户的质押余额
        stakers[msg.sender].stakedAmount -= amount;

       
        (bool success, ) = payable(msg.sender).call{value: amount}("");
        require(success, "Failed to unstake tokens");

        emit Unstaked(msg.sender, amount);
    }

    // ==================== 功能3：用户领取累计的奖励（核心功能） ====================
    function claimRewards() external nonReentrant {
        // 先更新用户的奖励，确保利息计算到当前时间
        updateRewards(msg.sender);

        uint256 reward = stakers[msg.sender].rewardDebt;
        require(reward > 0, "No rewards to claim"); // 必须有奖励才能领
        // 平台奖励代币余额必须足够，防止领不到
        require(rewardToken.balanceOf(address(this)) >= reward, "Insufficient reward token balance");

        // 清空用户的奖励债务（已经领了）
        stakers[msg.sender].rewardDebt = 0;

        
        (bool success, ) = payable(msg.sender).call{value: reward}("");
        require(success, "Failed to send rewards to user");

        emit RewardClaimed(msg.sender, reward);
    }

    // ==================== 功能4：紧急提取，直接拿回本金，放弃奖励（防极端情况） ====================
    function emergencyWithdraw() external nonReentrant {
        uint256 amount = stakers[msg.sender].stakedAmount;
        require(amount > 0, "Nothing staked"); // 必须有质押才能提取

        // 清空用户的质押余额、奖励债务，重置时间
        stakers[msg.sender].stakedAmount = 0;
        stakers[msg.sender].rewardDebt = 0;
        stakers[msg.sender].lastUpdate = block.timestamp;

        
        (bool success, ) = payable(msg.sender).call{value: amount}("");
        require(success, "Failed to emergency withdraw");

        emit EmergencyWithdraw(msg.sender, amount);
    }

    // ==================== 功能5：管理员补充奖励代币，给平台发奖励的钱 ====================
    function refillRewards(uint256 amount) external onlyOwner {
        // 把奖励代币从管理员转到合约里
        rewardToken.transferFrom(msg.sender, address(this), amount);
        emit RewardRefilled(msg.sender, amount);
    }

    // ==================== 核心内部函数：更新用户的累计奖励（利息计算） ====================
    function updateRewards(address user) internal {
        StakerInfo storage staker = stakers[user];

        // 如果用户有质押，计算累计利息
        if (staker.stakedAmount > 0) {
            // 计算从上次更新到现在的时间差（秒）
            uint256 timeDiff = block.timestamp - staker.lastUpdate;
            // 奖励乘数：10^质押代币小数位，把年利率转成按秒计息，处理精度
            uint256 rewardMultiplier = 10 ** stakingTokenDecimals;
            // 计算利息：质押量 × 每秒奖励 × 时间差 / 乘数（精度处理）
            uint256 pendingReward = (timeDiff * rewardRatePerSecond * staker.stakedAmount) / rewardMultiplier;

            // 把利息加到用户的奖励债务里
            staker.rewardDebt += pendingReward;
        }

        // 更新上次更新时间为当前时间
        staker.lastUpdate = block.timestamp;
    }

    // ==================== 功能6：查看待领取的奖励（不领取，仅查询） ====================
    function pendingRewards(address user) external view returns (uint256) {
        StakerInfo memory staker = stakers[user];
        uint256 pendingReward = staker.rewardDebt;

        // 如果用户有质押，计算当前累计的利息
        if (staker.stakedAmount > 0) {
            uint256 timeDiff = block.timestamp - staker.lastUpdate;
            uint256 rewardMultiplier = 10 ** stakingTokenDecimals;
            pendingReward += (timeDiff * rewardRatePerSecond * staker.stakedAmount) / rewardMultiplier;
        }

        return pendingReward;
    }

    // ==================== 功能7：查询质押代币的小数位数 ====================
    function getStakingTokenDecimals() external view returns (uint8) {
        return stakingTokenDecimals;
    }
}