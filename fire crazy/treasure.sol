// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
 * @title 管理员宝箱合约 (AdminOnly)
 * 核心功能：权限控制、额度分配、安全提取
 */
contract AdminOnly {
    // 【1. 状态变量】
    address public owner; // 合约拥有者（社长） [cite: 294, 295]
    uint256 public treasureAmount; // 宝箱里的宝物总数 [cite: 314, 315]

    // 账本：记录每个地址被允许提取的额度 [cite: 318, 321]
    mapping(address => uint256) public withdrawalAllowance;
    // 账本：记录每个地址是否已经提取过（防止重复提取） [cite: 326, 343]
    mapping(address => bool) public hasWithdrawn;

    // 【2. 构造函数】
    constructor() {
        // 谁部署合约，谁就是最初的拥有者 [cite: 294, 298, 299]
        owner = msg.sender; [cite: 294, 296]
    }

    // 【3. 修饰符：保安亭】
    // 使用 modifier 创建可复用的权限检查 [cite: 301, 304]
    modifier onlyOwner() {
        // 检查调用者是否为拥有者 [cite: 302, 305]
        require(msg.sender == owner, "Access denied: Only the owner can perform this action"); [cite: 302]
        _ ; // 占位符：检查通过后执行函数主体 [cite: 302, 307, 308]
    }

    // 【4. 管理员功能】

    // 往宝箱添加宝物：只有拥有者可以操作 [cite: 313, 316]
    function addTreasure(uint256 amount) public onlyOwner { [cite: 314]
        treasureAmount += amount; [cite: 314]
    }

    // 授权他人取宝：给特定地址设置额度 [cite: 317, 320]
    function approveWithdrawal(address recipient, uint256 amount) public onlyOwner { [cite: 318]
        // 检查宝箱里是否有足够的宝物 [cite: 318, 321]
        require(amount <= treasureAmount, "Not enough treasure available"); [cite: 318]
        withdrawalAllowance[recipient] = amount; [cite: 318, 319]
    }

    // 重置用户的提取状态：让用户可以再次领钱 [cite: 356, 358]
    function resetWithdrawalStatus(address user) public onlyOwner { [cite: 357]
        hasWithdrawn[user] = false; [cite: 357]
    }

    // 转移所有权：移交社长权力 [cite: 359, 363]
    function transferOwnership(address newOwner) public onlyOwner { [cite: 360]
        // 检查新地址是否有效（不能是空号地址0） [cite: 360, 364]
        require(newOwner != address(0), "Invalid address"); [cite: 360]
        owner = newOwner; [cite: 360, 365]
    }

    // 查看宝箱详情：只有拥有者能看 [cite: 367, 371]
    function getTreasureDetails() public view onlyOwner returns (uint256) { [cite: 368]
        return treasureAmount; [cite: 368, 369]
    }

    // 【5. 用户功能：提取宝藏】
    function withdrawTreasure() public { [cite: 326, 327]
        // 情况一：如果是拥有者，可以直接提取任意金额 [cite: 329, 332]
        if (msg.sender == owner) { [cite: 330]
            // 只要宝箱里够，就能拿走 [cite: 330, 333]
            require(treasureAmount > 0, "Chest is empty"); 
            treasureAmount = 0; // 拥有者直接清空（示例逻辑） [cite: 331]
            return; [cite: 331]
        }

        // 情况二：普通用户取宝 [cite: 336, 341]
        uint256 allowance = withdrawalAllowance[msg.sender]; [cite: 337]

        // --- 检查 (Checks) ---
        require(allowance > 0, "You don't have any treasure allowance"); [cite: 337, 342]
        require(!hasWithdrawn[msg.sender], "You have already withdrawn your treasure"); 
        require(allowance <= treasureAmount, "Not enough treasure in the chest"); [cite: 338, 340, 344]

        // --- 影响 (Effects) 防御性编程：先改账本 --- [cite: 349, 351]
        hasWithdrawn[msg.sender] = true; // 标记已领过 [cite: 349, 352]
        treasureAmount -= allowance; // 总量减去额度 [cite: 349, 353]
        withdrawalAllowance[msg.sender] = 0; // 额度清零 [cite: 349, 350, 354]

        // --- 交互 (Interactions) ---
        // 实际开发中，这里会执行真正的转账动作
    }
}
