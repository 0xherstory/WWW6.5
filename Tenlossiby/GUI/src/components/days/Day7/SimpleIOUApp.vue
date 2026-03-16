<template>
  <div class="day-7-content">
    <div class="content-layout">
      <div class="left-column">
        <div class="interaction-area">
          <h3>🎮 交互操作</h3>
          <div class="interaction-controls">
            <div class="function-block">
              <h4 class="block-title">👥 添加朋友</h4>
              <code class="function-signature">函数：addFriend(address _friend)</code>
              <div class="input-group label-input-row">
                <label for="friend-input">朋友地址/Friend Address：</label>
                <input 
                  id="friend-input"
                  v-model="inputFriendAddress" 
                  type="text" 
                  placeholder="0x..."
                  @click.stop
                >
              </div>
              <button @click.stop="inputFriendAddress = '0x' + Array(40).fill(0).map(() => Math.floor(Math.random() * 16).toString(16)).join('')" class="day-action-btn blue small">🎲 随机生成</button>
              <button @click.stop="handleAddFriend" class="day-action-btn orange">➕ 添加朋友/AddFriend</button>
            </div>

            <div class="function-block">
              <h4 class="block-title">💰 钱包存款</h4>
              <code class="function-signature">函数：depositIntoWallet() payable</code>
              <div class="input-group">
                <label for="deposit-iou-input">存入数量(ETH)/Amount：</label>
                <input 
                  id="deposit-iou-input"
                  v-model="inputDepositAmount" 
                  type="number" 
                  placeholder="请输入数量"
                  min="0"
                  step="0.01"
                  @click.stop
                >
              </div>
              <button @click.stop="handleDeposit" class="day-action-btn orange">💰 存入ETH/Deposit</button>
            </div>

            <div class="function-block">
              <h4 class="block-title">📝 记录债务</h4>
              <code class="function-signature">函数：recordDebt(address _debtor, uint256 _amount)</code>
              <div class="input-group">
                <label for="debtor-input">债务人(谁欠你钱)/Debtor：</label>
                <input 
                  id="debtor-input"
                  v-model="inputDebtorAddress" 
                  type="text" 
                  placeholder="0x..."
                  @click.stop
                >
              </div>
              <button @click.stop="inputDebtorAddress = '0x' + Array(40).fill(0).map(() => Math.floor(Math.random() * 16).toString(16)).join('')" class="day-action-btn blue small" style="margin-bottom: 10px;">🎲 随机生成</button>
              <div class="input-group">
                <label for="debt-amount-input">欠款金额(ETH)/Amount：</label>
                <input 
                  id="debt-amount-input"
                  v-model="inputDebtAmount" 
                  type="number" 
                  placeholder="请输入数量"
                  min="0"
                  step="0.01"
                  @click.stop
                >
              </div>
              <button @click.stop="handleRecordDebt" class="day-action-btn yellow">📝 记录债务/RecordDebt</button>
            </div>

            <div class="function-block">
              <h4 class="block-title">💳 钱包还债</h4>
              <code class="function-signature">函数：payFromWallet(address _creditor, uint256 _amount)</code>
              <div class="input-group">
                <label for="creditor-input">债权人(你欠谁钱)/Creditor：</label>
                <input 
                  id="creditor-input"
                  v-model="inputCreditorAddress" 
                  type="text" 
                  placeholder="0x..."
                  @click.stop
                >
              </div>
              <button @click.stop="inputCreditorAddress = '0x' + Array(40).fill(0).map(() => Math.floor(Math.random() * 16).toString(16)).join('')" class="day-action-btn blue small" style="margin-bottom: 10px;">🎲 随机生成</button>
              <div class="input-group">
                <label for="pay-amount-input">还款金额(ETH)/Amount：</label>
                <input 
                  id="pay-amount-input"
                  v-model="inputPayAmount" 
                  type="number" 
                  placeholder="请输入数量"
                  min="0"
                  step="0.01"
                  @click.stop
                >
              </div>
              <button @click.stop="handlePayDebt" class="day-action-btn green">💳 钱包还债/PayDebt</button>
            </div>

            <div class="function-block">
              <h4 class="block-title">🔄 直接转账</h4>
              <code class="function-signature">函数：transferEther(address payable _to, uint256 _amount)<br/>函数：transferEtherViaCall(address payable _to, uint256 _amount)</code>
              <div class="input-group">
                <label for="transfer-to-input">接收者/To Address：</label>
                <input 
                  id="transfer-to-input"
                  v-model="inputTransferTo" 
                  type="text" 
                  placeholder="0x..."
                  @click.stop
                >
              </div>
              <button @click.stop="inputTransferTo = '0x' + Array(40).fill(0).map(() => Math.floor(Math.random() * 16).toString(16)).join('')" class="day-action-btn blue small" style="margin-bottom: 10px;">🎲 随机生成</button>
              <div class="input-group">
                <label for="transfer-amount-input">转账金额(ETH)/Amount：</label>
                <input 
                  id="transfer-amount-input"
                  v-model="inputTransferAmount" 
                  type="number" 
                  placeholder="请输入数量"
                  min="0"
                  step="0.01"
                  @click.stop
                >
              </div>
              <div class="button-group">
                <button @click.stop="handleTransferMethod" class="day-action-btn cyan">📤 Transfer 转账</button>
                <button @click.stop="handleCallMethod" class="day-action-btn magenta">📡 Call 低级调用转账</button>
              </div>
            </div>

            <div class="function-block query-block">
              <h4 class="block-title">📊 余额管理</h4>
              <code class="function-signature">函数：withdraw(uint256 _amount)<br/>函数：checkBalance() view returns (uint256)</code>
              <div class="input-group">
                <label for="withdraw-iou-input">提现数量(ETH)/Amount：</label>
                <input 
                  id="withdraw-iou-input"
                  v-model="inputWithdrawAmount" 
                  type="number" 
                  placeholder="请输入提现金额"
                  min="0"
                  step="0.01"
                  @click.stop
                >
              </div>
              <div class="button-group">
                <button @click.stop="handleWithdraw" class="day-action-btn red">🏧 提现/Withdraw</button>
                <button @click.stop="handleCheckBalance" class="day-action-btn cyan">💰 查询余额/CheckBalance</button>
              </div>
              <div v-if="checkedBalance !== null" class="balance-result">
                查询结果：{{ formatWeiToEth(checkedBalance) }} ETH
              </div>
            </div>
          </div>

          <div class="result-display">
            <h4>🤝 IOU 状态面板</h4>
            <div class="result-value">
              <div class="info-item"><strong>部署者(Owner)：</strong>{{ owner.slice(0,12) || '未初始化' }}...</div>
              <div class="info-item"><strong>当前操作地址：</strong>{{ userAddress.slice(0,12) }}...</div>
              <div class="info-item"><strong>钱包余额(内部)：</strong>{{ formatWeiToEth(userBalance) }} ETH</div>
              <hr class="divider" />
              
              <div v-if="friendsList.length > 0" class="sub-section">
                <strong>已注册朋友 ({{ friendsList.length - 1 }}个)：</strong>
                <div v-for="(friend, index) in friendsList" :key="index" class="list-item">
                  {{ friend === owner ? 'Owner(自身)' : friend.slice(0, 15) + '...' }}
                </div>
              </div>

              <div v-if="Object.keys(debts).length > 0" class="sub-section debts-section">
                <strong>债务记录 (你欠谁)：</strong>
                <div v-if="Object.keys(debts[userAddress] || {}).length === 0" class="list-item">无</div>
                <div v-for="(amount, creditor) in debts[userAddress]" :key="creditor" class="list-item debt-item">
                   欠债权人: {{ creditor.slice(0, 10) }}... 金额: {{ formatWeiToEth(amount) }} ETH
                </div>
                
                <strong style="margin-top: 5px; display: inline-block;">债权记录 (谁欠你)：</strong>
                <div v-for="(creditorsDict, debtor) in debts" :key="debtor">
                  <div v-if="creditorsDict[userAddress] > 0" class="list-item credit-item">
                    债务人: {{ debtor.slice(0, 10) }}... 欠你: {{ formatWeiToEth(creditorsDict[userAddress]) }} ETH
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>

      <!-- 右侧：知识面板 -->
      <KnowledgePanel
        :current-day="7"
        :unlocked-concepts="unlockedConcepts"
        :progress-percentage="progressPercentage"
        :full-code="fullCode"
        @show-full-code="showFullCode = true"
      />
    </div>

    <!-- 完整代码弹窗 -->
    <FullCodeModal
      :show="showFullCode"
      title="SimpleIOU 完整代码"
      :code="fullCode"
      @close="showFullCode = false"
    />
  </div>
</template>

<script setup>
import { ref, computed } from 'vue'
import { useDay7 } from '@/composables/useDay7'
import { useProgressStore } from '@/stores/progressStore'
import KnowledgePanel from '@/components/shared/KnowledgePanel.vue'
import FullCodeModal from '@/components/shared/FullCodeModal.vue'

const progressStore = useProgressStore()

// Day7 业务逻辑
const {
  owner,
  userAddress,
  friendsList,
  userBalance,
  debts,
  checkedBalance,
  iouAddFriend,
  iouDeposit,
  iouRecordDebt,
  iouPayDebt,
  iouTransferMethod,
  iouCallMethod,
  iouWithdraw,
  iouCheckBalance
} = useDay7()

// 输入状态
const inputFriendAddress = ref('')
const inputDepositAmount = ref('')
const inputDebtorAddress = ref('')
const inputDebtAmount = ref('')
const inputCreditorAddress = ref('')
const inputPayAmount = ref('')
const inputTransferTo = ref('')
const inputTransferAmount = ref('')
const inputWithdrawAmount = ref('')

// 弹窗状态
const showFullCode = ref(false)

// 完整代码（从 day7-SimpleIOUApp.sol 复制，包含完整注释）
const fullCode = `//SPDX-License-Identifier: MIT

// 声明Solidity版本，要求编译器版本在0.8.0或更高（但低于0.9.0）
pragma solidity ^0.8.0;

// 定义一个名为SimpleIOU的合约，用于朋友间的借条（IOU）管理
contract SimpleIOU{
    // 声明合约所有者的地址
    address public owner;
    
    // 跟踪已注册的朋友
    // 映射：地址 -> 是否已注册（布尔值）
    mapping(address => bool) public registeredFriends;
    
    // 地址数组：存储所有已注册朋友的地址列表
    address[] public friendList;
    
    // 跟踪每个朋友的余额
    // 映射：地址 -> 余额（以太币数量）
    mapping(address => uint256) public balances;
    
    // 简单的债务跟踪系统
    // 嵌套映射：债务人地址 -> 债权人地址 -> 欠款金额
    // 映射结构：mapping(键1 => mapping(键2 => 值))
    mapping(address => mapping(address => uint256)) public debts; // 债务人 -> 债权人 -> 金额
    
    // 构造函数：合约部署时执行一次，初始化合约
    constructor() {
        // 将部署合约的地址设置为所有者
        owner = msg.sender;
        
        // 将所有者注册为朋友（所有者默认是已注册用户）
        registeredFriends[msg.sender] = true;
        
        // 将所有者添加到朋友列表中
        friendList.push(msg.sender);
    }
    
    // 修饰符：限制只有所有者才能调用某些函数
    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can perform this action");
        _;
    }
    
    // 修饰符：限制只有已注册的朋友才能调用某些函数
    modifier onlyRegistered() {
        require(registeredFriends[msg.sender], "You are not registered");
        _;
    }
    
    // 添加新朋友函数：只有所有者可以调用，用于注册新朋友
    function addFriend(address _friend) public onlyOwner {
        // 检查朋友地址是否有效（不能是零地址）
        require(_friend != address(0), "Invalid address");
        
        // 检查该朋友是否已经注册
        require(!registeredFriends[_friend], "Friend already registered");
        
        // 将该地址标记为已注册朋友
        registeredFriends[_friend] = true;
        
        // 将该地址添加到朋友列表中
        friendList.push(_friend);
    }
    
    // 存款函数：将以太币存入你的钱包余额
    // payable 关键字表示该函数可以接收以太币
    function depositIntoWallet() public payable onlyRegistered {
        // 检查是否发送了以太币
        require(msg.value > 0, "Must send ETH");
        
        // 将发送的以太币数量累加到调用者的余额中
        balances[msg.sender] += msg.value;
    }
    
    // 记录债务函数：记录某人欠你钱
    function recordDebt(address _debtor, uint256 _amount) public onlyRegistered {
        // 检查债务人地址是否有效
        require(_debtor != address(0), "Invalid address");
        
        // 检查债务人是否已注册
        require(registeredFriends[_debtor], "Address not registered");
        
        // 检查金额是否大于0
        require(_amount > 0, "Amount must be greater than 0");
        
        // 记录债务：在嵌套映射中增加债务金额
        // 结构：debts[债务人][债权人] += 金额
        debts[_debtor][msg.sender] += _amount;
    }
    
    // 使用内部余额转账偿还债务
    function payFromWallet(address _creditor, uint256 _amount) public onlyRegistered {
        // 检查债权人地址是否有效
        require(_creditor != address(0), "Invalid address");
        
        // 检查债权人是否已注册
        require(registeredFriends[_creditor], "Creditor not registered");
        
        // 检查金额是否大于0
        require(_amount > 0, "Amount must be greater than 0");
        
        // 检查债务金额是否足够
        require(debts[msg.sender][_creditor] >= _amount, "Debt amount incorrect");
        
        // 检查余额是否足够
        require(balances[msg.sender] >= _amount, "Insufficient balance");
        
        // 更新余额和债务
        // 从债务人的余额中扣除金额
        balances[msg.sender] -= _amount;
        
        // 将金额添加到债权人的余额中
        balances[_creditor] += _amount;
        
        // 从债务记录中减少债务金额
        debts[msg.sender][_creditor] -= _amount;
    }
    
    // 直接转账方法：使用 transfer() 方法进行以太币转账
    function transferEther(address payable _to, uint256 _amount) public onlyRegistered {
        // 检查接收者地址是否有效
        require(_to != address(0), "Invalid address");
        
        // 检查接收者是否已注册
        require(registeredFriends[_to], "Recipient not registered");
        
        // 检查余额是否足够
        require(balances[msg.sender] >= _amount, "Insufficient balance");
        
        // 从发送者的余额中扣除金额
        balances[msg.sender] -= _amount;
        
        // 使用 transfer() 方法将以太币转账给接收者
        // transfer() 是一个安全的转账方法，会自动转发2300 gas
        _to.transfer(_amount);
        
        // 将金额添加到接收者的余额中
        balances[_to]+=_amount;
    }
    
    // 替代转账方法：使用 call() 方法进行以太币转账
    function transferEtherViaCall(address payable _to, uint256 _amount) public onlyRegistered {
        // 检查接收者地址是否有效
        require(_to != address(0), "Invalid address");
        
        // 检查接收者是否已注册
        require(registeredFriends[_to], "Recipient not registered");
        
        // 检查余额是否足够
        require(balances[msg.sender] >= _amount, "Insufficient balance");
        
        // 从发送者的余额中扣除金额
        balances[msg.sender] -= _amount;
        
        // 使用 call() 方法进行低级调用
        // call() 方法更灵活，可以设置 gas 限制
        // 返回值：success (bool) 表示调用是否成功
        // 第二个返回值是返回数据（这里不需要，用 _ 忽略）
        (bool success, ) = _to.call{value: _amount}("");
        
        // 将金额添加到接收者的余额中
        balances[_to]+=_amount;
        
        // 检查转账是否成功
        require(success, "Transfer failed");
    }
    
    // 提取函数：提取你的余额到外部钱包
    function withdraw(uint256 _amount) public onlyRegistered {
        // 检查余额是否足够
        require(balances[msg.sender] >= _amount, "Insufficient balance");
        
        // 从余额中扣除金额
        balances[msg.sender] -= _amount;
        
        // 使用 call() 方法将以太币转回给调用者
        // payable(msg.sender) 将地址转换为可支付地址
        (bool success, ) = payable(msg.sender).call{value: _amount}("");
        
        // 检查提取是否成功
        require(success, "Withdrawal failed");
    }
    
    // 查询余额函数：查看你的余额
    function checkBalance() public view onlyRegistered returns (uint256) {
        // 返回调用者的余额
        return balances[msg.sender];
    }
}`

// 已解锁概念
const unlockedConcepts = computed(() => {
  return progressStore.dayProgress[7]?.unlockedConcepts || []
})

// 进度百分比
const progressPercentage = computed(() => {
  const progress = progressStore.dayProgress[7]
  if (!progress || progress.totalConcepts === 0) return 0
  return Math.floor((progress.unlockedConcepts.length / progress.totalConcepts) * 100)
})

// 格式化 wei 为 ETH
const formatWeiToEth = (wei) => {
  return (wei / 1e18).toFixed(4)
}

// 处理添加朋友
const handleAddFriend = () => {
  if (!inputFriendAddress.value.trim()) {
    alert('请输入朋友地址！')
    return
  }
  const success = iouAddFriend(inputFriendAddress.value)
  if (success) {
    inputFriendAddress.value = ''
  } else {
    alert('添加朋友失败！地址可能无效或已存在。')
  }
}

// 处理存款
const handleDeposit = () => {
  const amount = Number(inputDepositAmount.value)
  if (!amount || amount <= 0) {
    alert('请输入有效的存入数量！')
    return
  }
  const success = iouDeposit(amount)
  if (success) {
    inputDepositAmount.value = ''
  } else {
    alert('存入失败！您可能不是注册用户。')
  }
}

// 处理记录债务
const handleRecordDebt = () => {
  if (!inputDebtorAddress.value.trim()) {
    alert('请输入债务人地址！')
    return
  }
  const amount = Number(inputDebtAmount.value)
  if (!amount || amount <= 0) {
    alert('请输入有效的欠款金额！')
    return
  }
  const success = iouRecordDebt(inputDebtorAddress.value, amount)
  if (success) {
    inputDebtorAddress.value = ''
    inputDebtAmount.value = ''
  } else {
    alert('记录债务失败！')
  }
}

// 处理还款
const handlePayDebt = () => {
  if (!inputCreditorAddress.value.trim()) {
    alert('请输入债权人地址！')
    return
  }
  const amount = Number(inputPayAmount.value)
  if (!amount || amount <= 0) {
    alert('请输入有效的还款金额！')
    return
  }
  const result = iouPayDebt(inputCreditorAddress.value, amount)
  if (result === true) {
    inputCreditorAddress.value = ''
    inputPayAmount.value = ''
  } else {
    alert(result || '还款失败！')
  }
}

// 处理 transfer 转账
const handleTransferMethod = () => {
  if (!inputTransferTo.value.trim()) {
    alert('请输入接收者地址！')
    return
  }
  const amount = Number(inputTransferAmount.value)
  if (!amount || amount <= 0) {
    alert('请输入有效的转账金额！')
    return
  }
  const result = iouTransferMethod(inputTransferTo.value, amount)
  if (result === true) {
    inputTransferTo.value = ''
    inputTransferAmount.value = ''
  } else {
    alert(result || '转账失败！')
  }
}

// 处理 call 转账
const handleCallMethod = () => {
  if (!inputTransferTo.value.trim()) {
    alert('请输入接收者地址！')
    return
  }
  const amount = Number(inputTransferAmount.value)
  if (!amount || amount <= 0) {
    alert('请输入有效的转账金额！')
    return
  }
  const result = iouCallMethod(inputTransferTo.value, amount)
  if (result === true) {
    inputTransferTo.value = ''
    inputTransferAmount.value = ''
  } else {
    alert(result || '转账失败！')
  }
}

// 处理提现
const handleWithdraw = () => {
  const amount = Number(inputWithdrawAmount.value)
  if (!amount || amount <= 0) {
    alert('请输入有效的提现金额！')
    return
  }
  const result = iouWithdraw(amount)
  if (result === true) {
    inputWithdrawAmount.value = ''
  } else {
    alert(result || '提现失败！')
  }
}

// 处理查询余额
const handleCheckBalance = () => {
  iouCheckBalance()
}
</script>

<style scoped>
.day-7-content .input-group {
  display: flex;
  flex-direction: column;
  gap: 8px;
  margin-bottom: 15px;
}

.day-7-content .input-group.label-input-row {
  flex-direction: row;
  align-items: center;
  gap: 10px;
}

.day-7-content .input-group.label-input-row label {
  white-space: nowrap;
  min-width: 120px;
}

.day-7-content .input-group label {
  font-weight: bold;
  color: var(--text-main);
}

.day-7-content .input-group input {
  padding: 12px 15px;
  border: 2px solid var(--accent-orange);
  border-radius: 8px;
  font-size: 1em;
  background: var(--bg-base);
  color: var(--text-main);
  transition: border-color 0.3s ease;
  font-family: inherit;
}

.day-7-content .input-group input:focus {
  outline: none;
  border-color: var(--accent-orange);
  box-shadow: 0 0 0 3px rgba(203, 75, 22, 0.2);
}

.day-7-content .input-group input::placeholder {
  color: var(--text-muted);
}

/* 按钮样式已迁移到全局 .day-action-btn */

.day-7-content .button-group {
  display: flex;
  gap: 10px;
}

.day-7-content .button-group button {
  flex: 1;
}

.day-7-content .function-block {
  background: var(--bg-surface-1);
  border: 1px solid var(--border-main);
  border-radius: 8px;
  padding: 15px;
  margin-bottom: 15px;
}

.day-7-content .function-block .block-title {
  color: var(--accent-green);
  margin: 0 0 2px 0;
  font-size: 1.1em;
  line-height: 1.2;
  position: static;
}

.day-7-content .function-block .block-title::before {
  display: none;
}

.day-7-content .function-signature {
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

.day-7-content .query-block {
  background: var(--bg-surface-2);
}

.day-7-content .result-display {
  background: var(--bg-surface-1);
  border: 1px solid var(--border-main);
  border-radius: 8px;
  padding: 15px;
  margin-top: 20px;
}

.day-7-content .result-display h4 {
  color: var(--accent-green);
  margin-bottom: 10px;
}

.day-7-content .result-value {
  color: var(--text-main);
  line-height: 1.8;
}

.day-7-content .result-value div {
  padding: 3px 0;
  background: transparent;
  border-left: none;
  border-radius: 0;
  margin-bottom: 0;
}

.day-7-content .divider {
  border: none;
  border-top: 1px solid var(--border-main);
  margin: 10px 0;
}

.day-7-content .sub-section {
  margin-top: 10px;
}

.day-7-content .list-item {
  margin-left: 10px;
  font-size: 12px;
  padding: 2px 0;
}

.day-7-content .debt-item {
  color: var(--accent-red);
}

.day-7-content .credit-item {
  color: var(--accent-green);
}

.day-7-content .balance-result {
  margin-top: 10px;
  padding: 10px;
  background: var(--bg-surface-2);
  border-radius: 4px;
  text-align: center;
  font-weight: bold;
  color: var(--accent-green);
}

@media (max-width: 768px) {
  .day-7-content .input-group.label-input-row {
    flex-direction: column;
    align-items: flex-start;
  }
  
  .day-7-content .input-group.label-input-row label {
    min-width: auto;
  }
  
  .day-7-content .input-group input {
    font-size: 16px;
  }
  
  .day-7-content .button-group {
    flex-direction: column;
  }
}
</style>
