//SPDX-License-Identifier:MIT
// 声明 Solidity 编译器版本要求：^0.8.0 表示兼容 0.8.0 及以上但低于 0.9.0 的版本
pragma solidity ^0.8.0;

/**
 * @title AdminOnly 管理员独占的宝藏管理合约
 * @author （可填写作者）
 * @notice 该合约实现了仅管理员可操作的宝藏（代币/金额）管理功能
 * @dev 核心逻辑：管理员控制宝藏总额、审批提现额度，普通用户仅可提现审批后的额度且仅能提现一次
 */
contract AdminOnly{
    // 状态变量 - 合约所有者（管理员）地址
    address public owner;
    // 状态变量 - 合约中可分配的宝藏总金额
    uint256 public treasureAmount;
    // 映射 - 记录每个地址被批准的提现额度
    mapping(address=>uint256) public withdrawalAllowance;
    // 映射 - 记录每个地址是否已经提现过（防止重复提现）
    mapping(address=>bool) public hasWithdrawn;
    

    constructor(){
        owner=msg.sender;
    }


    modifier onlyOwner(){
        require(msg.sender==owner,"Access denied: Only the owner can perform this action");
        _; // 执行被修饰函数的核心逻辑
    }


    function addTreasure(uint256 amount)public onlyOwner {
        treasureAmount += amount; // 累加宝藏总额
    }


    function approveWithdrawal(address recipient, uint256 amount)public onlyOwner {
        // 检查：审批额度不能超过当前宝藏总额
        require(amount <=treasureAmount, "Not enough treasure available");
        // 为目标地址设置提现额度（会覆盖该地址原有额度）
        withdrawalAllowance[recipient] = amount;
    }


    function withdrawTreasure(uint256 amount)public{
        // 管理员提现逻辑（特殊权限：无提现次数限制，可直接扣减总额）
        if(msg.sender == owner){
            // 检查：提现额度不能超过当前宝藏总额
            require(amount <=treasureAmount,"Not enough treasury available for this action.");
            treasureAmount -= amount; // 扣减宝藏总额
            return; // 结束函数执行，无需走普通用户逻辑
        }

        // 普通用户提现逻辑
        // 1. 获取该用户的审批提现额度
        uint256 allowance = withdrawalAllowance[msg.sender];

        // 2. 权限与额度检查（按优先级排序）
        require(allowance > 0,"You don't have any treasure allowance"); // 检查是否有审批额度
        require(!hasWithdrawn[msg.sender],"You have already withdrawn your treasure"); // 检查是否已提现过
        require(allowance <=treasureAmount,"Not enough treasure in the chest"); // 检查审批额度是否≤剩余宝藏
        require(allowance >=amount,"Cannot withdraw more than you are allowed"); // 检查提现额度是否≤审批额度

        // 3. 提现后状态更新
        hasWithdrawn[msg.sender] = true; // 标记该用户已提现（防止重复提现）
        withdrawalAllowance[msg.sender] = 0; // 清空该用户的审批额度
        treasureAmount -= amount; // 扣减宝藏总额（原代码遗漏此关键逻辑，已补充）
    }

    /**
     * @notice 重置指定用户的提现状态（仅管理员可调用）
     * @dev 重置后用户可再次提现（需重新审批额度）
     * @param user 要重置状态的用户地址
     */
    function resetWithdrawalStatus(address user) public onlyOwner {
        hasWithdrawn[user] = false; // 将用户提现状态设为未提现
    }

    /**
     * @notice 转移合约所有权（仅管理员可调用）
     * @dev 转移前检查新地址是否为有效地址（非零地址）
     * @param newOwner 新管理员地址
     */
    function transferOwnership(address newOwner) public onlyOwner{
        require(newOwner !=address(0),"Invalid address"); // 检查新地址是否为零地址
        owner = newOwner; // 更新管理员地址
    }

    /**
     * @notice 查询当前宝藏总金额（仅管理员可调用）
     * @dev view 函数表示仅读取状态，不修改链上数据，无需消耗 gas
     * @return 当前宝藏总金额（uint256 类型）
     */
    function getTreasureDetails() public view onlyOwner returns (uint256){
        return treasureAmount;
    }
}