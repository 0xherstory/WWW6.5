// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "@openzeppelin/contracts/token/ERC721/utils/ERC721Holder.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";

// 继承 ERC721Holder (替代直接实现 IERC721Receiver)、Ownable (权限管理)、ReentrancyGuard (防重入)
contract NFTStaking is ERC721Holder, Ownable, ReentrancyGuard {
    // NFT 合约地址
    IERC721 public immutable nftContract;
    
    // 奖励代币 (如果需要ERC20奖励，需引入IERC20)
    uint256 public constant REWARD_RATE = 1 ether; // 每秒钟奖励 1 wei (可根据实际需求调整)
    
    // 质押结构体
    struct Stake {
        address owner;
        uint256 timestamp; // 质押开始时间
        uint256 lastRewardClaimed; // 上次领取奖励的时间
    }
    
    // tokenId => 质押信息
    mapping(uint256 => Stake) public stakes;
    
    // 事件声明
    event Staked(address indexed owner, uint256 indexed tokenId, uint256 timestamp);
    event Unstaked(address indexed owner, uint256 indexed tokenId, uint256 reward);
    event RewardClaimed(address indexed owner, uint256 indexed tokenId, uint256 reward);
    
    // 构造函数 - 初始化NFT合约地址
    constructor(address _nftContract) Ownable(msg.sender) {
        nftContract = IERC721(_nftContract);
    }
    
    /**
     * @dev 质押NFT
     * @param tokenId NFT的tokenId
     */
    function stake(uint256 tokenId) external nonReentrant {
        // 检查NFT是否存在且属于调用者
        require(nftContract.ownerOf(tokenId) == msg.sender, "NFTStaking: not owner of NFT");
        // 检查该NFT是否已被质押
        require(stakes[tokenId].owner == address(0), "NFTStaking: NFT already staked");
        
        // 转移NFT到合约
        nftContract.safeTransferFrom(msg.sender, address(this), tokenId);
        
        // 记录质押信息
        stakes[tokenId] = Stake({
            owner: msg.sender,
            timestamp: block.timestamp,
            lastRewardClaimed: block.timestamp
        });
        
        // 触发质押事件
        emit Staked(msg.sender, tokenId, block.timestamp);
    }
    
    /**
     * @dev 解除质押并领取奖励
     * @param tokenId NFT的tokenId
     */
    function unstake(uint256 tokenId) external nonReentrant {
        // 检查该NFT是否已被质押
        require(stakes[tokenId].owner != address(0), "NFTStaking: NFT not staked");
        // 检查调用者是否是质押者
        require(stakes[tokenId].owner == msg.sender, "NFTStaking: not the staker");
        
        // 计算奖励
        uint256 reward = calculateReward(tokenId);
        
        // 删除质押记录
        delete stakes[tokenId];
        
        // 转移NFT给所有者
        nftContract.safeTransferFrom(address(this), msg.sender, tokenId);
        
        // 发放奖励 (这里简化处理，实际项目中需要实现ERC20转账逻辑)
        // rewardToken.transfer(msg.sender, reward);
        
        // 触发解除质押事件
        emit Unstaked(msg.sender, tokenId, reward);
    }
    
    /**
     * @dev 计算质押奖励
     * @param tokenId NFT的tokenId
     * @return 奖励金额
     */
    function calculateReward(uint256 tokenId) public view returns (uint256) {
        // 检查该NFT是否已被质押
        require(stakes[tokenId].owner != address(0), "NFTStaking: NFT not staked");
        
        Stake memory stakeInfo = stakes[tokenId];
        // 计算质押时长 (秒)
        uint256 stakingDuration = block.timestamp - stakeInfo.lastRewardClaimed;
        
        // 计算奖励 = 质押时长 * 奖励率
        return stakingDuration * REWARD_RATE;
    }
    
    /**
     * @dev 领取奖励 (额外实现的实用功能)
     * @param tokenId NFT的tokenId
     */
    function claimReward(uint256 tokenId) external nonReentrant {
        require(stakes[tokenId].owner == msg.sender, "NFTStaking: not the staker");
        
        uint256 reward = calculateReward(tokenId);
        require(reward > 0, "NFTStaking: no reward to claim");
        
        // 更新最后领取奖励时间
        stakes[tokenId].lastRewardClaimed = block.timestamp;
        
        // 发放奖励
        // rewardToken.transfer(msg.sender, reward);
        
        emit RewardClaimed(msg.sender, tokenId, reward);
    }
    
    /**
     * @dev 检查NFT是否已质押
     * @param tokenId NFT的tokenId
     * @return 是否质押
     */
    function isStaked(uint256 tokenId) public view returns (bool) {
        return stakes[tokenId].owner != address(0);
    }
}
