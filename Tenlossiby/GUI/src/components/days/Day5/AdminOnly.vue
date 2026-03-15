<template>
  <div class="day-5-content">
    <div class="content-layout">
      <div class="left-column">
        <div class="interaction-area">
          <h3>🎮 交互操作</h3>
          <div class="interaction-controls">
            <div class="function-block">
              <h4 class="block-title">💎 添加宝藏</h4>
              <code class="function-signature">函数：addTreasure(uint256 amount)</code>
              <div class="input-group">
                <label for="treasure-input">添加宝藏数量/Amount：</label>
                <input 
                  id="treasure-input"
                  v-model="inputTreasureAmount" 
                  type="number" 
                  placeholder="请输入数量"
                  @click.stop
                >
              </div>
              <button @click.stop="handleAddTreasure" class="day-action-btn yellow">➕ 添加宝藏/AddTreasure</button>
            </div>
            
            <div class="function-block">
              <h4 class="block-title">✅ 批准提款</h4>
              <code class="function-signature">函数：approveWithdrawal(address recipient, uint256 amount)</code>
              <div class="input-group label-input-row">
                <label for="recipient-input">用户地址/Recipient：</label>
                <input 
                  id="recipient-input"
                  v-model="inputRecipient" 
                  type="text" 
                  placeholder="0x..."
                  @click.stop
                >
              </div>
              <button @click.stop="inputRecipient = '0x' + Array(40).fill(0).map(() => Math.floor(Math.random() * 16).toString(16)).join('')" class="day-action-btn blue small" style="margin-bottom: 10px;">🎲 随机生成</button>
              <div class="input-group">
                <label for="allowance-input">提款额度/Allowance：</label>
                <input 
                  id="allowance-input"
                  v-model="inputAllowance" 
                  type="number" 
                  placeholder="请输入额度"
                  @click.stop
                >
              </div>
              <button @click.stop="handleApproveWithdrawal" class="day-action-btn yellow">✅ 批准提款/ApproveWithdrawal</button>
            </div>
            
            <div class="function-block">
              <h4 class="block-title">💰 提取宝藏</h4>
              <code class="function-signature">函数：withdrawTreasure(uint256 amount)</code>
              <div class="input-group">
                <label for="withdraw-input">提取数量/Amount：</label>
                <input 
                  id="withdraw-input"
                  v-model="inputWithdrawAmount" 
                  type="number" 
                  placeholder="请输入数量"
                  @click.stop
                >
              </div>
              <button @click.stop="handleWithdrawTreasure" class="day-action-btn green">💰 提取宝藏/WithdrawTreasure</button>
              <button @click.stop="handleResetWithdrawalStatus" class="day-action-btn orange">🔄 重置提款状态/ResetStatus</button>
              <code class="function-signature">函数：resetWithdrawalStatus(address user)</code>
            </div>
            
            <div class="function-block">
              <h4 class="block-title">🔐 转移所有权</h4>
              <code class="function-signature">函数：transferOwnership(address newOwner)</code>
              <div class="input-group label-input-row">
                <label for="new-owner-input">新所有者地址/New Owner：</label>
                <input 
                  id="new-owner-input"
                  v-model="inputNewOwner" 
                  type="text" 
                  placeholder="0x..."
                  @click.stop
                >
              </div>
              <button @click.stop="inputNewOwner = '0x' + Array(40).fill(0).map(() => Math.floor(Math.random() * 16).toString(16)).join('')" class="day-action-btn blue small">🎲 随机生成</button>
              <button @click.stop="handleTransferOwnership" class="day-action-btn red">🔐 转移所有权/TransferOwnership</button>
            </div>
            
            <div class="function-block query-block">
              <h4 class="block-title">📊 查询操作</h4>
              <code class="function-signature">函数：getTreasureDetails() returns (uint256)</code>
              <button @click.stop="handleGetTreasureDetails" class="day-action-btn cyan">📊 获取宝藏详情/GetDetails</button>
            </div>
          </div>
          <div class="result-display">
            <h4>🏆 宝库状态</h4>
            <div class="result-value">
              <div><strong>所有者/Owner：</strong>{{ owner || '未初始化' }}</div>
              <div><strong>宝藏数量/Treasure：</strong>{{ treasureAmount }}</div>
              <div><strong>当前用户地址/Your Address：</strong>{{ userAddress }}</div>
              <div><strong>提款额度/Allowance：</strong>{{ userAllowance || 0 }}</div>
              <div><strong>已提取/Withdrawn：</strong>{{ hasWithdrawn ? '是/Yes' : '否/No' }}</div>
            </div>
          </div>
        </div>
      </div>

      <!-- 右侧：知识面板 -->
      <KnowledgePanel
        :current-day="5"
        :unlocked-concepts="unlockedConcepts"
        :progress-percentage="progressPercentage"
        :full-code="fullCode"
        @show-full-code="showFullCode = true"
      />
    </div>

    <!-- 完整代码弹窗 -->
    <FullCodeModal
      :show="showFullCode"
      title="AdminOnly 完整代码"
      :code="fullCode"
      @close="showFullCode = false"
    />
  </div>
</template>

<script setup>
import { ref, computed } from 'vue'
import { useDay5 } from '@/composables/useDay5'
import { useProgressStore } from '@/stores/progressStore'
import KnowledgePanel from '@/components/shared/KnowledgePanel.vue'
import FullCodeModal from '@/components/shared/FullCodeModal.vue'

const progressStore = useProgressStore()

// Day5 业务逻辑
const {
  inputTreasureAmount,
  inputRecipient,
  inputAllowance,
  inputWithdrawAmount,
  inputNewOwner,
  owner,
  treasureAmount,
  userAddress,
  userAllowance,
  hasWithdrawn,
  addTreasure,
  approveWithdrawal,
  withdrawTreasure,
  resetWithdrawalStatus,
  transferOwnership,
  getTreasureDetails
} = useDay5()

// 弹窗状态
const showFullCode = ref(false)

// 完整代码（从 day5-AdminOnly.sol 复制，包含完整注释）
const fullCode = `// SPDX-License-Identifier: MIT
// 声明Solidity版本，要求编译器版本在0.8.0或更高（但低于0.9.0）
pragma solidity ^0.8.0;

// 定义一个名为AdminOnly的合约，用于管理员权限控制的宝库管理
contract AdminOnly {
    // 状态变量区域
    
    // 声明公共地址变量，存储合约所有者的地址
    address public owner;
    
    // 声明公共无符号整数，存储宝库中的宝藏数量
    uint256 public treasureAmount;
    
    // 声明映射，存储每个地址的提款额度
    // 键是地址，值是该地址允许提取的宝藏数量
    mapping(address => uint256) public withdrawalAllowance;
    
    // 声明映射，记录每个地址是否已经提取过宝藏
    // 键是地址，值是布尔值（true表示已提取，false表示未提取）
    mapping(address => bool) public hasWithdrawn;
    
    // 构造函数：合约部署时执行一次，将部署者设置为所有者
    constructor() {
        owner = msg.sender;
    }
    
    // 修饰符：用于限制只有所有者才能调用某些函数
    // modifier 可以理解为函数的"前置条件检查"
    modifier onlyOwner() {
        // 检查调用者是否为所有者，如果不是则回滚交易并显示错误信息
        require(msg.sender == owner, "Access denied: Only the owner can perform this action");
        
        // _; 表示执行修饰符后的函数体
        // 这是修饰符的语法，表示"通过检查后，继续执行被修饰的函数"
        _;
    }
    
    // 添加宝藏函数：只有所有者可以调用
    // onlyOwner 修饰符确保只有所有者能执行此函数
    function addTreasure(uint256 amount) public onlyOwner {
        // 将指定数量的宝藏添加到宝库中
        treasureAmount += amount;
    }
    
    // 批准提款函数：只有所有者可以调用，用于给用户分配提款额度
    function approveWithdrawal(address recipient, uint256 amount) public onlyOwner {
        // 检查批准的额度是否不超过宝库中现有的宝藏数量
        require(amount <= treasureAmount, "Not enough treasure available");
        
        // 为指定地址设置提款额度
        withdrawalAllowance[recipient] = amount;
    }
    
    
    // 提取宝藏函数：任何人都可以调用，但只有有额度且未提取过的用户才能成功
    function withdrawTreasure(uint256 amount) public {

        // 如果调用者是所有者，允许直接提取任意数量（在宝库范围内）
        if(msg.sender == owner){
            // 检查提取数量是否不超过宝库现有数量
            require(amount <= treasureAmount, "Not enough treasury available for this action.");
            
            // 从宝库中扣除指定数量的宝藏
            treasureAmount-= amount;

            // 直接返回，不执行后面的普通用户提款逻辑
            return;
        }
        
        // 获取调用者的提款额度
        uint256 allowance = withdrawalAllowance[msg.sender];
        
        // 检查用户是否有提款额度（额度必须大于0）
        require(allowance > 0, "You don't have any treasure allowance");
        
        // 检查用户是否已经提取过宝藏（不能重复提取）
        require(!hasWithdrawn[msg.sender], "You have already withdrawn your treasure");
        
        // 检查宝库中是否有足够的宝藏
        require(allowance <= treasureAmount, "Not enough treasure in the chest");
        
        // 检查用户尝试提取的数量是否不超过其允许的额度
        require(allowance >= amount, "Cannot withdraw more than you are allowed");
        
        // 标记该用户已经提取过宝藏
        hasWithdrawn[msg.sender] = true;
        
        // 从宝库中扣除用户额度对应的宝藏数量
        treasureAmount -= allowance;
        
        // 将用户的提款额度清零
        withdrawalAllowance[msg.sender] = 0;
        
    }
    
    // 重置提款状态函数：只有所有者可以调用，用于重置某个用户的提款状态
    function resetWithdrawalStatus(address user) public onlyOwner {
        // 将指定用户的提款状态重置为false（允许再次提取）
        hasWithdrawn[user] = false;
    }
    
    // 转移所有权函数：只有所有者可以调用，用于将合约所有权转移给新所有者
    function transferOwnership(address newOwner) public onlyOwner {
        // 检查新所有者地址是否有效（不能是零地址）
        // address(0) 表示零地址，是一个无效的地址
        require(newOwner != address(0), "Invalid address");
        
        // 将所有者更新为新地址
        owner = newOwner;
    }
    
    // 获取宝藏详情函数：只有所有者可以调用，查看宝库中的宝藏数量
    function getTreasureDetails() public view onlyOwner returns (uint256) {
        // 返回宝库中的宝藏数量
        return treasureAmount;
    }
}`

// 已解锁概念
const unlockedConcepts = computed(() => {
  return progressStore.dayProgress[5]?.unlockedConcepts || []
})

// 进度百分比
const progressPercentage = computed(() => {
  const progress = progressStore.dayProgress[5]
  if (!progress || progress.totalConcepts === 0) return 0
  return Math.floor((progress.unlockedConcepts.length / progress.totalConcepts) * 100)
})

// 处理添加宝藏
const handleAddTreasure = () => {
  const amount = Number(inputTreasureAmount.value)
  if (!amount || amount <= 0) {
    alert('请输入有效的宝藏数量！')
    return
  }
  addTreasure(amount)
  inputTreasureAmount.value = ''
}

// 处理批准提款
const handleApproveWithdrawal = () => {
  if (!inputRecipient.value.trim()) {
    alert('请输入用户地址！')
    return
  }
  const amount = Number(inputAllowance.value)
  if (!amount || amount <= 0) {
    alert('请输入有效的提款额度！')
    return
  }
  approveWithdrawal(inputRecipient.value, amount)
  inputRecipient.value = ''
  inputAllowance.value = ''
}

// 处理提取宝藏
const handleWithdrawTreasure = () => {
  const amount = Number(inputWithdrawAmount.value)
  if (!amount || amount <= 0) {
    alert('请输入有效的提取数量！')
    return
  }
  withdrawTreasure(userAddress.value, amount)
  inputWithdrawAmount.value = ''
}

// 处理重置提款状态
const handleResetWithdrawalStatus = () => {
  resetWithdrawalStatus(userAddress.value)
}

// 处理转移所有权
const handleTransferOwnership = () => {
  if (!inputNewOwner.value.trim()) {
    alert('请输入新所有者地址！')
    return
  }
  transferOwnership(inputNewOwner.value)
  inputNewOwner.value = ''
}

// 处理获取宝藏详情
const handleGetTreasureDetails = () => {
  const amount = getTreasureDetails()
  alert(`📊 宝藏详情\n\n当前宝藏数量: ${amount}`)
}
</script>

<style scoped>
.day-5-content .input-group {
  display: flex;
  flex-direction: column;
  gap: 8px;
  margin-bottom: 15px;
}

.day-5-content .input-group.label-input-row {
  flex-direction: row;
  align-items: center;
  gap: 10px;
}

.day-5-content .input-group.label-input-row label {
  white-space: nowrap;
  min-width: 120px;
}

.day-5-content .input-group label {
  font-weight: bold;
  color: var(--text-main);
}

.day-5-content .input-group input {
  padding: 12px 15px;
  border: 2px solid var(--accent-yellow);
  border-radius: 8px;
  font-size: 1em;
  background: var(--bg-base);
  color: var(--text-main);
  transition: border-color 0.3s ease;
  font-family: inherit;
}

.day-5-content .input-group input:focus {
  outline: none;
  border-color: var(--accent-red);
  box-shadow: 0 0 0 3px rgba(220, 50, 47, 0.2);
}

.day-5-content .input-group input::placeholder {
  color: var(--text-muted);
}

/* 按钮样式已迁移到全局 .day-action-btn */

.day-5-content .function-block {
  background: var(--bg-surface-1);
  border: 1px solid var(--border-main);
  border-radius: 8px;
  padding: 15px;
  margin-bottom: 15px;
}

.day-5-content .function-block .block-title {
  color: var(--accent-blue);
  margin: 0 0 2px 0;
  font-size: 1.1em;
  line-height: 1.2;
}

.day-5-content .function-signature {
  display: block;
  background: var(--bg-surface-2);
  padding: 4px 12px;
  border-radius: 4px;
  font-family: 'Courier New', monospace;
  font-size: 0.85em;
  color: var(--text-main);
  margin: 0 0 25px 0;
  border-left: 3px solid var(--accent-yellow);
  line-height: 1.3;
}

.day-5-content .query-block {
  background: var(--bg-surface-2);
}

.day-5-content .result-display {
  background: var(--bg-surface-1);
  border: 1px solid var(--border-main);
  border-radius: 8px;
  padding: 15px;
  margin-top: 20px;
}

.day-5-content .result-display h4 {
  color: var(--accent-green);
  margin-bottom: 10px;
}

.day-5-content .result-value {
  color: var(--text-main);
  line-height: 1.8;
}

.day-5-content .result-value div {
  padding: 3px 0;
}

@media (max-width: 768px) {
  .day-5-content .input-group.label-input-row {
    flex-direction: column;
    align-items: flex-start;
  }
  
  .day-5-content .input-group.label-input-row label {
    min-width: auto;
  }
  
  .day-5-content .input-group input {
    font-size: 16px;
  }
}
</style>
