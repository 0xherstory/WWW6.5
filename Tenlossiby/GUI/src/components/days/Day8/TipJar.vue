<template>
  <div class="day-8-content">
    <div class="content-layout">
      <div class="left-column">
        <div class="interaction-area">
          <h3>🎮 交互操作</h3>
          
          <div class="identity-toggle-bar">
            <span class="identity-label">🎭 当前身份：</span>
            <div class="toggle-buttons">
              <button 
                :class="{ active: !isAdmin }" 
                @click="toggleAdmin"
              >👤 用户/User</button>
              <button 
                :class="{ active: isAdmin }" 
                @click="toggleAdmin"
              >👑 管理员/Admin</button>
            </div>
          </div>

          <div class="function-block">
            <h4 class="block-title">💹 汇率预览 (Mapping)</h4>
            <code class="function-signature">mapping(string => uint256) public conversionRates;</code>
            <div class="currency-grid">
              <div v-for="(rate, cur) in conversionRates" :key="cur" class="currency-card">
                <span class="cur-name">{{ cur }}</span>
                <span class="cur-val">{{ (rate / 1e18).toFixed(5) }} ETH</span>
              </div>
            </div>
          </div>

          <div class="function-block" :class="{ 'inactive-block': isAdmin }">
            <h4 class="block-title">💰 投币打赏 (Act 2: Payable)</h4>
            <div class="function-signature">
              函数：tipInEth() public payable<br/>
              函数：tipInCurrency(string _currency, uint256 _amount) payable
            </div>
            <div class="input-row">
              <div class="input-group">
                <label>打赏 ETH 数量：</label>
                <input v-model="inputTipEthAmount" type="number" step="0.01" min="0" @click.stop>
              </div>
              <button @click.stop="handleTipInEth" class="day-action-btn cyan">💎 直接打赏 ETH</button>
            </div>
            <div class="divider">或者按法币换算</div>
            <div class="input-row">
              <div class="input-group">
                <label>选择币种：</label>
                <select v-model="selectedCurrency" @click.stop>
                  <option v-for="cur in supportedCurrencies" :key="cur" :value="cur">{{ cur }}</option>
                </select>
              </div>
              <div class="input-group">
                <label>金额：</label>
                <input v-model="inputCurrencyAmount" type="number" min="1" @click.stop>
              </div>
              <button @click.stop="handleTipInCurrency" class="day-action-btn cyan">🔥 按汇率打赏</button>
            </div>
            <p v-if="isAdmin" class="admin-warning">⚠️ 当前是管理员模式，请切回用户进行打赏体验</p>
          </div>

          <div class="function-block admin-only" :class="{ 'inactive-block': !isAdmin }">
            <h4 class="block-title">🏦 金库管理 (Act 3: Admin)</h4>
            <code class="function-signature">函数：withdrawTips() public onlyOwner</code>
            <p class="admin-hint">只有合约拥有者(Owner)可以提取累积的打赏金。</p>
            <button @click.stop="handleWithdrawTips" class="day-action-btn red">🔓 提取全部打赏 (Withdraw)</button>
            <p v-if="!isAdmin" class="admin-warning">⚠️ 只有管理员可以操作此区块</p>
          </div>

          <div v-if="tipMessage" :class="['tip-message', { error: isTipMessageError }]">
            {{ tipMessage }}
          </div>
        </div>

        <div class="result-display">
          <h4>🍯 打赏罐实时状态</h4>
          <div class="jar-status">
            <div class="status-item main">
              <span class="label">金库总余额 (ETH)</span>
              <span class="value">{{ formatBalance(totalTips) }}</span>
            </div>
            <div class="status-item">
              <span class="label">管理员地址：</span>
              <span class="value address-val">{{ owner }}</span>
            </div>
            <div class="status-item">
              <span class="label">你的地址：</span>
              <span class="value address-val">{{ userAddress }}</span>
            </div>
          </div>
        </div>
      </div>

      <!-- 右侧：知识面板 -->
      <KnowledgePanel
        :current-day="8"
        :unlocked-concepts="unlockedConcepts"
        :progress-percentage="progressPercentage"
        :full-code="fullCode"
        @show-full-code="showFullCode = true"
      />
    </div>

    <!-- 完整代码弹窗 -->
    <FullCodeModal
      :show="showFullCode"
      title="TipJar 完整代码"
      :code="fullCode"
      @close="showFullCode = false"
    />
  </div>
</template>

<script setup>
import { ref, computed } from 'vue'
import { useDay8 } from '@/composables/useDay8'
import { useProgressStore } from '@/stores/progressStore'
import KnowledgePanel from '@/components/shared/KnowledgePanel.vue'
import FullCodeModal from '@/components/shared/FullCodeModal.vue'

const progressStore = useProgressStore()

// Day8 业务逻辑
const {
  owner,
  userAddress,
  isAdmin,
  totalTips,
  supportedCurrencies,
  conversionRates,
  tipJarToggleAdmin,
  tipJarTipInEth,
  tipJarTipInCurrency,
  tipJarWithdraw,
  formatBalance
} = useDay8()

// 输入状态
const inputTipEthAmount = ref('')
const selectedCurrency = ref('USD')
const inputCurrencyAmount = ref('')

// 提示消息
const tipMessage = ref('')
const isTipMessageError = ref(false)

// 弹窗状态
const showFullCode = ref(false)

// 完整代码（从 day8-TipJar.sol 复制，包含完整注释）
const fullCode = `//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract TipJar {
    // 合约的拥有者（管理员）地址
    address public owner;
    
    // 记录收到的打赏总金额
    uint256 public totalTipsReceived;
    
    // 汇率映射表：记录法币（如USD）到ETH的汇率
    // 例如，如果 1 USD = 0.0005 ETH，那么这里存储的是 5 * 10^14（以wei为单位）
    mapping(string => uint256) public conversionRates;

    // 记录每个地址（人）打赏的金额
    mapping(address => uint256) public tipPerPerson;
    
    // 当前支持的代币/货币列表
    string[] public supportedCurrencies;  // List of supported currencies
    
    // 记录每种货币收到的打赏总数
    mapping(string => uint256) public tipsPerCurrency;
    
    // 构造函数：在部署智能合约时执行且仅执行一次的初始化代码
    constructor() {
        owner = msg.sender; // 将调用该合约部署操作的用户设定为所有者(owner)
        // 初始化预设的各种货币的转换汇率
        addCurrency("USD", 5 * 10**14);  // 1 USD = 0.0005 ETH
        addCurrency("EUR", 6 * 10**14);  // 1 EUR = 0.0006 ETH
        addCurrency("JPY", 4 * 10**12);  // 1 JPY = 0.000004 ETH
        addCurrency("INR", 7 * 10**12);  // 1 INR = 0.000007ETH ETH
    }
    
    // 自定义修饰符（modifier）：用于函数前，用来检查运行之前的要求
    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can perform this action"); // 限制只有管理员才能使用
        _; // 代表继续执行接下来目标函数内部的代码
    }
    
    // Add or update a supported currency (增加或更新支持的币种以及对等汇率)
    // 注意这个函数挂载了 onlyOwner，确保只有管理员能够修改系统汇率
    function addCurrency(string memory _currencyCode, uint256 _rateToEth) public onlyOwner {
        require(_rateToEth > 0, "Conversion rate must be greater than 0");
        bool currencyExists = false;
        for (uint i = 0; i < supportedCurrencies.length; i++) {
            if (keccak256(bytes(supportedCurrencies[i])) == keccak256(bytes(_currencyCode))) {
                currencyExists = true;
                break;
            }
        }
        if (!currencyExists) {
            supportedCurrencies.push(_currencyCode);
        }
        conversionRates[_currencyCode] = _rateToEth;
    }
    
    // 核心换算模块：根据给定的法币代码及其金额，推算出需要多少ETH（也就是wei单位的数量）
    // 'view' 代表当前这个函数不会修改链上的状态变量，仅仅只是读取（读取了 conversionRates）
    function convertToEth(string memory _currencyCode, uint256 _amount) public view returns (uint256) {
        require(conversionRates[_currencyCode] > 0, "Currency not supported");
        uint256 ethAmount = _amount * conversionRates[_currencyCode]; // 汇率计算转换为Wei
        return ethAmount;
        //If you ever want to show human-readable ETH in your frontend, divide the result by 10^18 :
    }
    
    // Send a tip in ETH directly (发送ETH直接进行打赏)
    // payable 关键字：标记了该函数能够用来接收随交易发送的以太币 (msg.value)
    function tipInEth() public payable {
        require(msg.value > 0, "Tip amount must be greater than 0"); // 此处的 msg.value 就是附带发送进合约的以太金额 (单位：wei)
        tipPerPerson[msg.sender] += msg.value; // 计算打赏人的累计打赏额度
        totalTipsReceived += msg.value; // 在平台总收到的总额中追加
        tipsPerCurrency["ETH"] += msg.value; // 单独在ETH的货币类别中追加
    }
    
    // 通过指定的货币类型去计算所需要付出的ETH进行打赏
    // 参数包含用户选择发送的具体法币以及法币金额值
    function tipInCurrency(string memory _currencyCode, uint256 _amount) public payable {
        require(conversionRates[_currencyCode] > 0, "Currency not supported");
        require(_amount > 0, "Amount must be greater than 0");
        
        // 我们预计算出这段法币对应多少 wei
        uint256 ethAmount = convertToEth(_currencyCode, _amount);
        
        // 安全检查：强制校验用户实际上在调用这个智能合约发送来的以太坊(以wei计算)是否与算出来的等额一致，从而防止作恶或发错
        require(msg.value == ethAmount, "Sent ETH doesn't match the converted amount");
        
        tipPerPerson[msg.sender] += msg.value; // 记录个人贡献
        totalTipsReceived += msg.value; // 汇总总收益
        tipsPerCurrency[_currencyCode] += _amount; // 将它归档于该法币类目中进行统计
    }

    // 提现函数：该合约内有各种收到别人转进来的以太币资产，这个方法用于管理员将里面资金"转出"给管理员自己
    function withdrawTips() public onlyOwner {
        // address(this).balance：用于获取该智能合约本身在所在网络链上的剩余资金 (相当于该金库中有多少钱)
        uint256 contractBalance = address(this).balance;
        require(contractBalance > 0, "No tips to withdraw"); // 要求必须要能提到账的钱
        
        // 将普通地址 owner 变为 payable 对象后，采用底层 .call 发送指定额度的以太坊给目标；这种写法规避了较早出现的transfer的潜在缺点
        (bool success, ) = payable(owner).call{value: contractBalance}("");
        require(success, "Transfer failed"); // 若底层的 .call 方法调用失败就触发回滚交易(revert)来保障安全
        
        totalTipsReceived = 0; // 收账完毕，把收银台数据重置
    }
  
    function transferOwnership(address _newOwner) public onlyOwner {
        require(_newOwner != address(0), "Invalid address");
        owner = _newOwner;
    }

    function getSupportedCurrencies() public view returns (string[] memory) {
        return supportedCurrencies;
    }
    

    function getContractBalance() public view returns (uint256) {
        return address(this).balance;
    }
    
   
    function getTipperContribution(address _tipper) public view returns (uint256) {
        return tipPerPerson[_tipper];
    }
    

    function getTipsInCurrency(string memory _currencyCode) public view returns (uint256) {
        return tipsPerCurrency[_currencyCode];
    }

    function getConversionRate(string memory _currencyCode) public view returns (uint256) {
        require(conversionRates[_currencyCode] > 0, "Currency not supported");
        return conversionRates[_currencyCode];
    }
}`

// 已解锁概念
const unlockedConcepts = computed(() => {
  return progressStore.dayProgress[8]?.unlockedConcepts || []
})

// 进度百分比
const progressPercentage = computed(() => {
  const progress = progressStore.dayProgress[8]
  if (!progress || progress.totalConcepts === 0) return 0
  return Math.floor((progress.unlockedConcepts.length / progress.totalConcepts) * 100)
})

// 切换管理员
const toggleAdmin = () => {
  tipJarToggleAdmin()
}

// 处理 ETH 打赏
const handleTipInEth = () => {
  const amount = Number(inputTipEthAmount.value)
  if (!amount || amount <= 0) {
    tipMessage.value = '❌ 请输入有效的打赏数量！'
    isTipMessageError.value = true
    return
  }
  tipJarTipInEth(amount)
  tipMessage.value = '✅ 打赏成功！'
  isTipMessageError.value = false
  inputTipEthAmount.value = ''
  setTimeout(() => { tipMessage.value = '' }, 3000)
}

// 处理法币打赏
const handleTipInCurrency = () => {
  const amount = Number(inputCurrencyAmount.value)
  if (!amount || amount <= 0) {
    tipMessage.value = '❌ 请输入有效的金额！'
    isTipMessageError.value = true
    return
  }
  const success = tipJarTipInCurrency(selectedCurrency.value, amount)
  if (success) {
    tipMessage.value = '✅ 按汇率打赏成功！'
    isTipMessageError.value = false
    inputCurrencyAmount.value = ''
  } else {
    tipMessage.value = '❌ 打赏失败！'
    isTipMessageError.value = true
  }
  setTimeout(() => { tipMessage.value = '' }, 3000)
}

// 处理提现
const handleWithdrawTips = () => {
  const result = tipJarWithdraw()
  if (result === true) {
    tipMessage.value = '✅ 提现成功！'
    isTipMessageError.value = false
  } else {
    tipMessage.value = '❌ ' + result
    isTipMessageError.value = true
  }
  setTimeout(() => { tipMessage.value = '' }, 3000)
}
</script>

<style scoped>
.day-8-content .identity-toggle-bar {
  display: flex;
  align-items: center;
  gap: 15px;
  margin-bottom: 20px;
  padding: 10px;
  background: var(--bg-surface-2);
  border-radius: 8px;
}

.day-8-content .identity-label {
  font-weight: bold;
  color: var(--text-muted);
}

.day-8-content .toggle-buttons {
  display: flex;
  gap: 10px;
}

.day-8-content .toggle-buttons button {
  padding: 8px 16px;
  border: none;
  background: transparent;
  color: var(--text-muted);
  cursor: pointer;
  font-size: 0.9em;
  border-radius: 6px;
  transition: all 0.2s;
  width: auto;
  margin: 0;
}

.day-8-content .toggle-buttons button.active {
  background: var(--accent-blue);
  color: #fff;
  font-weight: bold;
}

.day-8-content .function-block {
  background: var(--bg-surface-1);
  border: 1px solid var(--border-main);
  border-radius: 8px;
  padding: 15px;
  margin-bottom: 15px;
}

.day-8-content .function-block .block-title {
  color: var(--accent-green);
  margin: 0 0 2px 0;
  font-size: 1.1em;
  line-height: 1.2;
}

.day-8-content .function-signature {
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

.day-8-content .currency-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(120px, 1fr));
  gap: 10px;
  margin-top: 10px;
}

.day-8-content .currency-card {
  background: var(--bg-surface-2);
  border: 1px solid var(--border-main);
  padding: 8px;
  border-radius: 6px;
  text-align: center;
  display: flex;
  flex-direction: column;
}

.day-8-content .cur-name {
  font-weight: bold;
  color: var(--accent-yellow);
  font-size: 0.9em;
}

.day-8-content .cur-val {
  font-size: 0.8em;
  color: var(--text-muted);
}

.day-8-content .input-row {
  display: flex;
  flex-direction: column;
  gap: 10px;
  margin-bottom: 10px;
}

.day-8-content .input-group {
  display: flex;
  flex-direction: column;
  gap: 5px;
}

.day-8-content .input-group label {
  font-weight: bold;
  color: var(--text-main);
}

.day-8-content .input-group input,
.day-8-content .input-group select {
  padding: 10px;
  border: 2px solid var(--border-main);
  border-radius: 6px;
  font-size: 1em;
  background: var(--bg-base);
  color: var(--text-main);
}

/* 按钮样式已迁移到全局 .day-action-btn */

.day-8-content .divider {
  text-align: center;
  color: var(--text-muted);
  margin: 15px 0;
  position: relative;
}

.day-8-content .divider::before,
.day-8-content .divider::after {
  content: '';
  position: absolute;
  top: 50%;
  width: 40%;
  height: 1px;
  background: var(--border-main);
}

.day-8-content .divider::before {
  left: 0;
}

.day-8-content .divider::after {
  right: 0;
}

.day-8-content .admin-only {
  border-color: var(--accent-purple);
}

.day-8-content .inactive-block {
  opacity: 0.5;
  pointer-events: none;
  filter: grayscale(0.5);
}

.day-8-content .admin-warning {
  color: var(--accent-red);
  font-size: 0.85em;
  margin-top: 10px;
  font-weight: bold;
}

.day-8-content .admin-hint {
  font-size: 0.85em;
  color: var(--text-muted);
  font-style: italic;
  margin-bottom: 10px;
}

.day-8-content .tip-message {
  margin-top: 15px;
  padding: 10px;
  border-radius: 6px;
  background: var(--accent-green);
  color: #fff;
  text-align: center;
  font-weight: bold;
}

.day-8-content .tip-message.error {
  background: var(--accent-red);
}

.day-8-content .result-display {
  background: var(--bg-surface-1);
  border: 1px solid var(--border-main);
  border-radius: 8px;
  padding: 15px;
  margin-top: 20px;
  margin-bottom: 20px;
}

.day-8-content .result-display h4 {
  color: var(--accent-green);
  margin-bottom: 10px;
}

.day-8-content .jar-status {
  display: flex;
  flex-direction: column;
  gap: 10px;
}

.day-8-content .status-item {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 8px 0;
  border-bottom: 1px solid var(--border-main);
}

.day-8-content .status-item.main {
  font-size: 1.2em;
  font-weight: bold;
}

.day-8-content .status-item .label {
  color: var(--text-muted);
}

.day-8-content .status-item .value {
  color: var(--accent-yellow);
}

.day-8-content .status-item .address-val {
  font-size: 0.85em;
  font-family: monospace;
}

@media (max-width: 768px) {
  .day-8-content .identity-toggle-bar {
    flex-direction: column;
    align-items: flex-start;
  }
  
  .day-8-content .currency-grid {
    grid-template-columns: repeat(2, 1fr);
  }
}
</style>
