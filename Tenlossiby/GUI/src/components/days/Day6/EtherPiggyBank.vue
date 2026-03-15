<template>
  <div class="day-6-content">
    <div class="content-layout">
      <div class="left-column">
        <div class="interaction-area">
          <h3>🎮 交互操作</h3>
          <div class="interaction-controls">
            <div class="function-block">
              <h4 class="block-title">👥 添加会员</h4>
              <code class="function-signature">函数：addMembers(address _member)</code>
              <div class="input-group label-input-row">
                <label for="member-input">会员地址/Member Address：</label>
                <input 
                  id="member-input"
                  v-model="inputMemberAddress" 
                  type="text" 
                  placeholder="0x..."
                  @click.stop
                >
              </div>
              <button @click.stop="inputMemberAddress = '0x' + Array(40).fill(0).map(() => Math.floor(Math.random() * 16).toString(16)).join('')" class="day-action-btn blue small">🎲 随机生成</button>
              <button @click.stop="handleAddMembers" class="day-action-btn magenta">➕ 添加会员/AddMembers</button>
            </div>

            <div class="function-block">
              <h4 class="block-title">💵 存入以太币</h4>
              <code class="function-signature">函数：depositAmountEther() payable</code>
              <div class="input-group">
                <label for="deposit-input">存入数量(ETH)/Amount：</label>
                <input 
                  id="deposit-input"
                  v-model="inputDepositAmount" 
                  type="number" 
                  placeholder="请输入数量"
                  min="0"
                  step="0.01"
                  @click.stop
                >
              </div>
              <button @click.stop="handleDepositEther" class="day-action-btn magenta">💰 存入ETH/DepositEther</button>
            </div>

            <div class="function-block">
              <h4 class="block-title">💸 提取金额</h4>
              <code class="function-signature">函数：withdrawAmount(uint256 _amount)</code>
              <div class="input-group">
                <label for="withdraw-eth-input">提取数量(ETH)/Amount：</label>
                <input 
                  id="withdraw-eth-input"
                  v-model="inputWithdrawEthAmount" 
                  type="number" 
                  placeholder="请输入数量"
                  min="0"
                  step="0.01"
                  @click.stop
                >
              </div>
              <button @click.stop="handleWithdrawEth" class="day-action-btn green">💸 提取ETH/WithdrawAmount</button>
            </div>

            <div class="function-block query-block">
              <h4 class="block-title">📊 查询余额</h4>
              <code class="function-signature">函数：getBalance(address _member) returns (uint256)</code>
              <div class="input-group label-input-row">
                <label for="query-balance-input">查询地址/Query Address：</label>
                <input 
                  id="query-balance-input"
                  v-model="inputQueryBalance" 
                  type="text" 
                  placeholder="0x..."
                  @click.stop
                >
              </div>
              <button @click.stop="inputQueryBalance = '0x' + Array(40).fill(0).map(() => Math.floor(Math.random() * 16).toString(16)).join('')" class="day-action-btn blue small" style="margin-bottom: 10px;">🎲 随机生成</button>
              <button @click.stop="handleGetBalance" class="day-action-btn cyan">📊 查询余额/GetBalance</button>
            </div>

            <div class="function-block query-block">
              <h4 class="block-title">📋 查询会员</h4>
              <code class="function-signature">函数：getMembers() returns (address[])</code>
              <button @click.stop="handleGetMembers" class="day-action-btn cyan">📋 获取会员列表/GetMembers</button>
            </div>
          </div>
          <div class="result-display">
            <h4>🏦 银行状态</h4>
            <div class="result-value">
              <div class="info-item"><strong>银行管理员/Bank Manager：</strong>{{ bankManager || '未初始化' }}</div>
              <div class="info-item"><strong>会员数量/Members Count：</strong>{{ members.length }}</div>
              <div class="info-item"><strong>当前用户地址/Your Address：</strong>{{ userAddress }}</div>
              <div class="info-item"><strong>您的余额/Your Balance：</strong>{{ formatWeiToEth(userBalance) }} ETH ({{ userBalance }} wei)</div>
              <div v-if="queryBalance !== null"><strong>查询结果/Query Result：</strong>{{ formatWeiToEth(queryBalance) }} ETH ({{ queryBalance }} wei)</div>
              <div v-if="membersList.length > 0" style="margin-top: 10px; padding-top: 10px; border-top: 1px solid #ddd;">
                <strong>会员列表/Members List：</strong>
                <div v-for="(member, index) in membersList" :key="index" style="margin-left: 10px; font-size: 12px;">
                  {{ index + 1 }}. {{ member }}
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>

      <!-- 右侧：知识面板 -->
      <KnowledgePanel
        :current-day="6"
        :unlocked-concepts="unlockedConcepts"
        :progress-percentage="progressPercentage"
        :full-code="fullCode"
        @show-full-code="showFullCode = true"
      />
    </div>

    <!-- 完整代码弹窗 -->
    <FullCodeModal
      :show="showFullCode"
      title="EtherPiggyBank 完整代码"
      :code="fullCode"
      @close="showFullCode = false"
    />
  </div>
</template>

<script setup>
import { ref, computed } from 'vue'
import { useDay6 } from '@/composables/useDay6'
import { useProgressStore } from '@/stores/progressStore'
import KnowledgePanel from '@/components/shared/KnowledgePanel.vue'
import FullCodeModal from '@/components/shared/FullCodeModal.vue'

const progressStore = useProgressStore()

// Day6 业务逻辑
const {
  bankManager,
  members,
  userAddress,
  userBalance,
  queryBalance,
  membersList,
  addMembers,
  depositEther,
  withdrawEth,
  getBalance,
  getMembers,
  formatBalance
} = useDay6()

// 输入状态
const inputMemberAddress = ref('')
const inputDepositAmount = ref('')
const inputWithdrawEthAmount = ref('')
const inputQueryBalance = ref('')

// 弹窗状态
const showFullCode = ref(false)

// 完整代码（从 day6-EtherPiggyBank.sol 复制，包含完整注释）
const fullCode = `//SPDX-License-Identifier: MIT

// 声明Solidity版本，要求编译器版本在0.8.0或更高（但低于0.9.0）
pragma solidity ^0.8.0;

// 定义一个名为EtherPiggyBank的合约，用于以太坊存钱罐银行功能
contract EtherPiggyBank{

    // 状态变量区域
    
    // 声明银行管理员的地址
    // 银行管理员具有特殊权限，可以添加新成员
    address public bankManager;
    
    // 声明地址数组，存储所有已注册的会员地址
    address[] members;
    
    // 声明映射，记录每个地址是否已注册为会员
    // 键是地址，值是布尔值（true表示已注册，false表示未注册）
    mapping(address => bool) public registeredMembers;
    
    // 声明映射，记录每个地址的账户余额
    // 键是地址，值是该地址的余额（以wei为单位）
    mapping(address => uint256) balance;

    // 构造函数：合约部署时执行一次，初始化银行管理员
    constructor(){
        // 将部署合约的地址设置为银行管理员
        bankManager = msg.sender;
        
        // 将银行管理员添加到会员数组中（管理员默认是会员）
        members.push(msg.sender);
    }

    // 修饰符：限制只有银行管理员才能调用某些函数
    modifier onlyBankManager(){
        // 检查调用者是否为银行管理员，如果不是则回滚交易
        require(msg.sender == bankManager, "Only bank manager can perform this action");
        
        // 继续执行被修饰的函数
        _;
    }

    // 修饰符：限制只有已注册的会员才能调用某些函数
    modifier onlyRegisteredMember() {
        // 检查调用者是否为已注册的会员，如果不是则回滚交易
        require(registeredMembers[msg.sender], "Member not registered");
        
        // 继续执行被修饰的函数
        _;
    }
  
    // 添加会员函数：只有银行管理员可以调用，用于添加新会员
    function addMembers(address _member)public onlyBankManager{
        // 检查新会员地址是否有效（不能是零地址）
        require(_member != address(0), "Invalid address");
        
        // 检查是否尝试添加银行管理员本人（管理员已经是会员）
        require(_member != msg.sender, "Bank Manager is already a member");
        
        // 检查该地址是否已经是注册会员
        require(!registeredMembers[_member], "Member already registered");
        
        // 将该地址标记为已注册会员
        registeredMembers[_member] = true;
        
        // 将该地址添加到会员数组中
        members.push(_member);
    }

    // 获取会员列表函数：任何人都可以调用，返回所有会员地址
    function getMembers() public view returns(address[] memory){
        // 返回会员地址数组
        return members;
    }
    
    // 注释掉的函数：原本用于存入代币数量（不涉及以太币）
    // function depositAmount(uint256 _amount) public onlyRegisteredMember{
    //     require(_amount > 0, "Invalid amount");
    //     balance[msg.sender] = balance[msg.sender]+_amount;
   
    // }
    
    // 存入以太币函数：只有已注册会员可以调用
    // payable 关键字表示该函数可以接收以太币
    function depositAmountEther() public payable onlyRegisteredMember{  
        // 检查发送的以太币数量是否大于0
        // msg.value 是调用函数时发送的以太币数量（以wei为单位）
        require(msg.value > 0, "Invalid amount");
        
        // 将发送的以太币数量累加到调用者的余额中
        balance[msg.sender] = balance[msg.sender]+msg.value;
   
    }
    
    // 提取金额函数：只有已注册会员可以调用，用于提取余额
    function withdrawAmount(uint256 _amount) public onlyRegisteredMember{
        // 检查提取金额是否大于0
        require(_amount > 0, "Invalid amount");
        
        // 检查调用者的余额是否足够
        require(balance[msg.sender] >= _amount, "Insufficient balance");
        
        // 从调用者的余额中扣除提取的金额
        balance[msg.sender] = balance[msg.sender]-_amount;
   
    }

    // 获取余额函数：任何人都可以调用，查询指定会员的余额
    function getBalance(address _member) public view returns (uint256){
        // 检查查询的地址是否有效
        require(_member != address(0), "Invalid address");
        
        // 返回指定会员的余额
        return balance[_member];
    } 
}`

// 已解锁概念
const unlockedConcepts = computed(() => {
  return progressStore.dayProgress[6]?.unlockedConcepts || []
})

// 进度百分比
const progressPercentage = computed(() => {
  const progress = progressStore.dayProgress[6]
  if (!progress || progress.totalConcepts === 0) return 0
  return Math.floor((progress.unlockedConcepts.length / progress.totalConcepts) * 100)
})

// 格式化 wei 为 ETH
const formatWeiToEth = (wei) => {
  return (wei / 1e18).toFixed(4)
}

// 处理添加会员
const handleAddMembers = () => {
  if (!inputMemberAddress.value.trim()) {
    alert('请输入会员地址！')
    return
  }
  const success = addMembers(inputMemberAddress.value)
  if (success) {
    inputMemberAddress.value = ''
  } else {
    alert('添加会员失败！地址可能无效或已存在。')
  }
}

// 处理存入以太币
const handleDepositEther = () => {
  const amount = Number(inputDepositAmount.value)
  if (!amount || amount <= 0) {
    alert('请输入有效的存入数量！')
    return
  }
  const success = depositEther(amount)
  if (success) {
    inputDepositAmount.value = ''
  } else {
    alert('存入失败！您可能不是注册会员。')
  }
}

// 处理提取以太币
const handleWithdrawEth = () => {
  const amount = Number(inputWithdrawEthAmount.value)
  if (!amount || amount <= 0) {
    alert('请输入有效的提取数量！')
    return
  }
  const success = withdrawEth(amount)
  if (success) {
    inputWithdrawEthAmount.value = ''
  } else {
    alert('提取失败！余额不足或未注册。')
  }
}

// 处理查询余额
const handleGetBalance = () => {
  if (!inputQueryBalance.value.trim()) {
    alert('请输入查询地址！')
    return
  }
  getBalance(inputQueryBalance.value)
}

// 处理获取会员列表
const handleGetMembers = () => {
  getMembers()
}
</script>

<style scoped>
.day-6-content .input-group {
  display: flex;
  flex-direction: column;
  gap: 8px;
  margin-bottom: 15px;
}

.day-6-content .input-group.label-input-row {
  flex-direction: row;
  align-items: center;
  gap: 10px;
}

.day-6-content .input-group.label-input-row label {
  white-space: nowrap;
  min-width: 120px;
}

.day-6-content .input-group label {
  font-weight: bold;
  color: var(--text-main);
}

.day-6-content .input-group input {
  padding: 12px 15px;
  border: 2px solid var(--accent-magenta);
  border-radius: 8px;
  font-size: 1em;
  background: var(--bg-base);
  color: var(--text-main);
  transition: border-color 0.3s ease;
  font-family: inherit;
}

.day-6-content .input-group input:focus {
  outline: none;
  border-color: var(--accent-magenta);
  box-shadow: 0 0 0 3px rgba(211, 54, 130, 0.2);
}

.day-6-content .input-group input::placeholder {
  color: var(--text-muted);
}

/* 按钮样式已迁移到全局 .day-action-btn */

.day-6-content .function-block {
  background: var(--bg-surface-1);
  border: 1px solid var(--border-main);
  border-radius: 8px;
  padding: 15px;
  margin-bottom: 15px;
}

.day-6-content .function-block .block-title {
  color: var(--accent-green);
  margin: 0 0 2px 0;
  font-size: 1.1em;
  line-height: 1.2;
}

.day-6-content .function-signature {
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

.day-6-content .query-block {
  background: var(--bg-surface-2);
}

.day-6-content .result-display {
  background: var(--bg-surface-1);
  border: 1px solid var(--border-main);
  border-radius: 8px;
  padding: 15px;
  margin-top: 20px;
}

.day-6-content .result-display h4 {
  color: var(--accent-green);
  margin-bottom: 10px;
}

.day-6-content .result-value {
  color: var(--text-main);
  line-height: 1.8;
}

.day-6-content .result-value div {
  padding: 3px 0;
}

@media (max-width: 768px) {
  .day-6-content .input-group.label-input-row {
    flex-direction: column;
    align-items: flex-start;
  }
  
  .day-6-content .input-group.label-input-row label {
    min-width: auto;
  }
  
  .day-6-content .input-group input {
    font-size: 16px;
  }
}
</style>
