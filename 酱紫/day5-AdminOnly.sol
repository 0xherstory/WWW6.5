//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

//管理员控制功能合约
contract AdminOnly {
    // 定义全局变量
    address public owner; // 合约管理员地址
    uint256 public treasureAmount; //宝藏额度
    mapping(address => uint256) public withdrawalAllowance; //提取额度操作地址账本，记录每个用户是否已经提取过资金
    mapping(address => bool) public hasWithdrawn; //确认地址的提取的判断地址账本，记录每个用户被允许提取的额度
    
    // 构造函数，申明使用合约的owner是拥有者，msg.sender=当前交易的直接发送者。身份识别与权限控制的情形最常用。
    // 部署合约的人自动成为管理员
    constructor() {
        owner = msg.sender;
    }
    //与auctionhouse对比，constructor(string memory _item, uint _time)，
    //个性化定制，Remix 的部署按钮旁边会出现输入框（如下图所示）。你必须填入 "青花瓷" 和 "3600"，合约才能部署成功。


    // modifier=修改器函数，如果说 function 是执行任务的员工，那么 modifier 就是站在门口的保安或者质检员。它最核心的作用是：在函数执行之前（或之后）跑一段逻辑，如果不符合条件，直接把人轰走（Revert）。
    // 拒绝部署后的合约被路人捡便宜，管理敏感参数。Modifier for owner-only functions
    // 核心语法拆解
    // 理解 modifier 只需要看懂那个神奇的符号 _ ;（下划线分号）：
    // modifier checkSomething() {
    //     require(条件, "错误提示"); // 第一步：保安查证
    //     _;                         // 第二步：通过！回到原函数执行主体代码
    // }
    // _ ; 是占位符：它告诉编译器，原来那个函数里的代码应该“插”在这里执行。
    //权限控制：仅限管理员执行
    modifier onlyOwner() {
        require(msg.sender == owner, "Access denied: Only the owner can perform this action");
        _;
    }
    
    // 只有合约拥有者 可以添加额度
    function addTreasure(uint256 amount) public onlyOwner {
        treasureAmount += amount;
    }
    
    // 只有合约拥有者 可以通过提现的权限
    function approveWithdrawal(address recipient, uint256 amount) public onlyOwner {
        require(amount <= treasureAmount, "Not enough treasure available");
        withdrawalAllowance[recipient] = amount;
    }
    
    
    //任何人有额度的人可以赎回
    function withdrawTreasure(uint256 amount) public {

        if(msg.sender == owner){
            require(amount <= treasureAmount, "Not enough treasury available for this action.");
            treasureAmount-= amount;

            return;
        }
        uint256 allowance = withdrawalAllowance[msg.sender];
        
        // 检查用户有没有足够的额度 
        require(allowance > 0, "You don't have any treasure allowance");
        require(!hasWithdrawn[msg.sender], "You have already withdrawn your treasure");
        require(allowance <= treasureAmount, "Not enough treasure in the chest");
        require(allowance >= amount, "Cannot withdraw more than you are allowed"); // condition to check if user is withdrawing more than allowed
        
        // 赎回后标记已提现，减少总库存储蓄
        hasWithdrawn[msg.sender] = true;
        treasureAmount -= allowance; 
        withdrawalAllowance[msg.sender] = 0; //防止重复提现
        
    }
    
    /**
     * @dev 重置提现状态
     * 逻辑：管理员可以将特定用户的 `hasWithdrawn` 设为 false。
     * 场景：当用户需要进行第二次提现，或者之前的提现记录需要清除时使用。
     */
    // 只有合约拥有者可以重置提现用户的状态
    function resetWithdrawalStatus(address user) public onlyOwner {
        hasWithdrawn[user] = false;
    }
    
    /**
     * @dev 转移所有权
     * 逻辑：管理员将自己的管理权限移交给一个新的地址。
     * 验证：确保新地址不是零地址（防止合约失控）。
     */
    // 只有合约拥有者可以转移所有权
    function transferOwnership(address newOwner) public onlyOwner {
        require(newOwner != address(0), "Invalid address");
        owner = newOwner;
    }

    /**
     * @dev 查看储蓄总额
     * 逻辑：仅限管理员查看当前合约中 `treasureAmount` 的数值。
     * 场景：用于财务审计或内部额度监控。
     */
    //只有合约拥有者可以查看储蓄额度
    function getTreasureDetails() public view onlyOwner returns (uint256) {
        return treasureAmount;
    }
}
