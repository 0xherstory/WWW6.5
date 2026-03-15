<template>
  <div v-if="showUnlockArea" class="right-column">
    <!-- 提示气泡 -->
    <div class="hint-bubble">
      <h4>💡 交互提示</h4>
      <p>{{ hintText || remainingConceptsGuide }}</p>
    </div>

    <!-- 解锁新知识 -->
    <div class="knowledge-unlock">
      <h4>🎉 恭喜解锁新知识！</h4>
      <span class="unlock-badge">{{ unlockBadge }}</span>
      <p>{{ unlockText }}</p>
      <div v-if="currentConceptCode" class="code-snippet">
        <pre>{{ currentConceptCode }}</pre>
      </div>
      
      <!-- 已解锁概念列表 -->
      <div class="concept-list">
        <div
          v-for="conceptKey in unlockedConcepts"
          :key="conceptKey"
          class="concept-badge"
          :class="{ active: selectedConcept === conceptKey }"
          @click="handleConceptClick(conceptKey)"
        >
          <span class="check-icon">✓</span>
          {{ getConceptBadge(conceptKey) }}
        </div>
      </div>
      
      <button v-if="allConceptsUnlocked" class="view-full-code-btn" @click="showFullCode">
        📖 查看完整代码
      </button>
    </div>
  </div>
</template>

<script setup>
import { computed, ref } from 'vue'
import { useConceptInteraction } from '@/composables/useConceptInteraction'
import { conceptDefinitions, getHint, getConceptExplanationHint, day11ConceptDefinitions, getDay11ExplanationHint, day12ConceptDefinitions, getDay12Hint, getDay12ExplanationHint } from '@/data/concepts'

const props = defineProps({
  // 当前Day编号
  currentDay: {
    type: Number,
    required: true
  },
  // 已解锁概念列表
  unlockedConcepts: {
    type: Array,
    required: true
  },
  // 进度百分比
  progressPercentage: {
    type: Number,
    default: 0
  },
  // 完整代码内容
  fullCode: {
    type: String,
    default: ''
  },
  // 外部传入的提示文本（可选，优先级高于自动生成的提示）
  customHint: {
    type: String,
    default: ''
  }
})

const emit = defineEmits([
  'show-full-code',
  'concept-change'
])

// 用户手动选择的概念 key（null 表示显示最新解锁的概念）
const manualConceptKey = ref(null)

// 更新当前显示的概念
const updateCurrentConcept = (conceptKey) => {
  manualConceptKey.value = conceptKey
  emit('concept-change', conceptKey)
}

// 使用概念交互 composable
const {
  selectedConcept,
  handleConceptClick,
  getConceptBadge
} = useConceptInteraction(updateCurrentConcept, props.currentDay)

// 是否显示解锁区域
const showUnlockArea = computed(() => props.unlockedConcepts.length > 0)

// 是否所有概念都已解锁
const allConceptsUnlocked = computed(() => props.progressPercentage === 100)

// 未解锁概念的指引提示（支持 Day 11 和 Day 12）
const remainingConceptsGuide = computed(() => {
  if (props.currentDay === 11) {
    const allConcepts = ['inheritance', 'import_statement', 'event_logging',
                         'constructor', 'private_visibility', 'transfer_ownership',
                         'indexed_parameter', 'onlyOwner_modifier']
    const unlocked = props.unlockedConcepts
    const remaining = allConcepts.filter(c => !unlocked.includes(c))
    
    // 根据剩余概念返回对应的解锁指引
    const guides = []
    if (remaining.includes('onlyOwner_modifier')) {
      guides.push('👉 切换到"用户"身份，尝试提取资金，体验权限控制！')
    }
    if (remaining.includes('transfer_ownership') || remaining.includes('indexed_parameter')) {
      guides.push('👉 以所有者身份转移所有权，学习所有权机制！')
    }
    if (remaining.includes('import_statement') || remaining.includes('event_logging')) {
      guides.push('👉 存入 ETH 来触发事件，了解导入和事件日志！')
    }
    if (remaining.includes('inheritance') || remaining.includes('constructor')) {
      guides.push('👉 点击查看当前所有者，了解合约继承和构造函数！')
    }
    
    return guides.join('\n')
  }
  
  if (props.currentDay === 12) {
    const allConcepts = ['erc20_standard', 'mapping_nested', 'event', 'transfer', 'approve', 'allowance', 'transferFrom']
    const unlocked = props.unlockedConcepts
    const remaining = allConcepts.filter(c => !unlocked.includes(c))
    
    // 根据剩余概念返回对应的解锁指引
    const guides = []
    if (remaining.includes('erc20_standard')) {
      guides.push('👉 点击代币信息区块了解 ERC20 标准！')
    }
    if (remaining.includes('mapping_nested')) {
      guides.push('👉 查询 Alice 余额来学习 mapping 存储机制！')
    }
    if (remaining.includes('event') || remaining.includes('transfer')) {
      guides.push('👉 转账给 Bob 来学习事件和转账函数！')
    }
    if (remaining.includes('approve')) {
      guides.push('👉 授权给 Carol 来学习授权机制！')
    }
    if (remaining.includes('allowance')) {
      guides.push('👉 查询授权额度来学习 allowance 查询！')
    }
    if (remaining.includes('transferFrom')) {
      guides.push('👉 切换到 Carol 执行代转账来学习 transferFrom！')
    }
    
    return guides.join('\n')
  }
  
  return ''
})

// 获取概念定义（支持 Day 11、Day 12 和其他天数）
const getConceptDefinition = (key) => {
  if (props.currentDay === 11) {
    return day11ConceptDefinitions[key]
  }
  if (props.currentDay === 12) {
    return day12ConceptDefinitions[key]
  }
  return conceptDefinitions[key]
}

// 当前显示的概念（如果用户手动选择了概念则显示选中的，否则显示最新的）
const currentConcept = computed(() => {
  if (props.unlockedConcepts.length === 0) return null

  // 如果用户手动选择了概念，显示选中的概念
  if (manualConceptKey.value) {
    return {
      key: manualConceptKey.value,
      ...getConceptDefinition(manualConceptKey.value)
    }
  }

  // 否则显示最新解锁的概念
  const latestKey = props.unlockedConcepts[props.unlockedConcepts.length - 1]
  return {
    key: latestKey,
    ...getConceptDefinition(latestKey)
  }
})

// 获取概念解释（支持 Day 11、Day 12 和其他天数）
const getConceptHint = (key) => {
  if (props.currentDay === 11) {
    return getDay11ExplanationHint(key)
  }
  if (props.currentDay === 12) {
    return getDay12ExplanationHint(key)
  }
  return getConceptExplanationHint(key)
}

// 获取下一步提示（仅 Day 11）
const getNextStepHint = (conceptKey) => {
  if (props.currentDay !== 11) return ''
  
  const hints = {
    inheritance: '📦 太棒了！你看到 VaultMaster 继承了 Ownable 的功能！👉 存入 ETH 来学习 import 机制！',
    constructor: '🏗️ 太棒了！你了解了构造函数！👉 存入 ETH 来学习导入语句和私有变量！',
    import_statement: '📥 不错！你了解了导入语句！👉 继续存入 ETH 来学习事件日志和私有变量！',
    event_logging: '📋 很好！你触发了事件日志！👉 尝试转移所有权来解锁更多概念！',
    private_visibility: '🔒 优秀！你学会了 private 变量的使用！👉 尝试转移所有权来学习所有权机制！',
    transfer_ownership: '🔑 很好！你了解了所有权转移！👉 尝试以用户身份提取来学习修饰符！',
    indexed_parameter: '🏷️ 不错！你了解了索引参数！👉 切换到用户身份体验权限控制！',
    onlyOwner_modifier: '🛡️ 太棒了！你了解了 onlyOwner 修饰符！👉 查看完整代码来巩固所有知识！'
  }
  return hints[conceptKey] || ''
}

// 提示文本
const hintText = computed(() => {
  // 如果用户手动选择了概念，优先显示该知识点的解释
  if (manualConceptKey.value && currentConcept.value) {
    return getConceptHint(currentConcept.value.key)
  }
  
  // 其次使用外部传入的 customHint
  if (props.customHint) {
    return props.customHint
  }
  
  // Day 11 显示下一步提示
  if (props.currentDay === 11 && currentConcept.value) {
    return getNextStepHint(currentConcept.value.key)
  }
  
  // Day 12 显示下一步提示
  if (props.currentDay === 12 && currentConcept.value) {
    return getDay12Hint(currentConcept.value.key)
  }
  
  // 否则显示当前概念的详细解释
  return currentConcept.value ? getConceptHint(currentConcept.value.key) : ''
})

// 解锁徽章
const unlockBadge = computed(() => {
  if (!currentConcept.value) return ''
  return `${currentConcept.value.icon} ${currentConcept.value.name}`
})

// 解锁文本
const unlockText = computed(() => {
  return currentConcept.value?.message || ''
})

// 概念代码
const currentConceptCode = computed(() => {
  return currentConcept.value?.code || ''
})

// 显示完整代码
const showFullCode = () => {
  emit('show-full-code')
}
</script>

<style scoped>
.right-column {
  flex: 5;
  min-width: 0;
}

/* 提示气泡 - 与 main.css 保持一致 */
.hint-bubble {
  background: var(--bg-surface-1);
  border-left: 4px solid var(--accent-orange);
  padding: 15px 20px;
  border-radius: 8px;
  margin-bottom: 20px;
  margin-top: 0;
  animation: slideIn 0.5s ease;
  border: 1px solid var(--border-main);
}

.hint-bubble h4 {
  color: var(--accent-orange);
  margin-bottom: 8px;
  display: flex;
  align-items: center;
  gap: 8px;
}

.hint-bubble p {
  margin: 0;
  color: var(--text-main);
  line-height: 1.5;
}

/* 解锁知识区域 - 与 main.css 保持一致 */
.knowledge-unlock {
  background: var(--bg-surface-1);
  border-left: 4px solid var(--accent-blue);
  padding: 20px;
  border-radius: 8px;
  margin-bottom: 20px;
  animation: fadeIn 0.5s ease;
  border: 1px solid var(--border-main);
}

.knowledge-unlock h4 {
  color: var(--accent-blue);
  margin-bottom: 10px;
  display: flex;
  align-items: center;
  gap: 8px;
}

.knowledge-unlock p {
  color: var(--text-main);
  line-height: 1.6;
  margin: 10px 0;
}

.unlock-badge {
  display: inline-block;
  background: var(--accent-blue);
  color: var(--bg-base);
  padding: 3px 10px;
  border-radius: 12px;
  font-size: 0.75em;
  margin-bottom: 10px;
}

.code-snippet {
  background: var(--code-bg);
  color: var(--text-muted);
  padding: 15px;
  border-radius: 6px;
  font-family: 'Courier New', monospace;
  font-size: 0.85em;
  margin-top: 10px;
  overflow-x: auto;
  line-height: 1.3;
  border: 1px solid var(--code-border);
}

.code-snippet pre {
  margin: 0;
  white-space: pre-wrap;
  word-break: break-word;
  font-family: 'Courier New', monospace;
}

/* 概念列表 - 与 main.css 保持一致 */
.concept-list {
  display: flex;
  flex-wrap: wrap;
  gap: 10px;
  margin-top: 15px;
}

.concept-badge {
  background: var(--accent-cyan);
  color: var(--bg-base);
  padding: 8px 16px;
  border-radius: 20px;
  font-size: 0.9em;
  display: flex;
  align-items: center;
  gap: 6px;
  animation: popIn 0.3s ease;
  transition: all 0.3s ease;
  cursor: pointer;
  border: 1px solid var(--accent-cyan);
}

.concept-badge:hover {
  background: var(--accent-blue-hover);
  transform: translateY(-2px);
  box-shadow: 0 4px 12px var(--shadow-cyan-4);
  border-color: var(--accent-blue-hover);
}

.concept-badge.active {
  border: 2px solid var(--accent-green);
  background: var(--accent-green);
  box-shadow: 0 4px 15px var(--shadow-green-5);
}

.check-icon {
  font-size: 1.1em;
}

/* 查看完整代码按钮 - 与 main.css 保持一致 */
.view-full-code-btn {
  width: 100%;
  padding: 12px 20px;
  background: var(--accent-yellow);
  color: var(--bg-base);
  border: none;
  border-radius: 6px;
  font-size: 1em;
  font-weight: bold;
  cursor: pointer;
  transition: all 0.3s ease;
  margin-top: 15px;
}

.view-full-code-btn:hover {
  background: var(--accent-yellow-hover);
  transform: translateY(-2px);
  box-shadow: 0 4px 12px var(--shadow-yellow-3);
}

@keyframes slideIn {
  from {
    opacity: 0;
    transform: translateX(-20px);
  }
  to {
    opacity: 1;
    transform: translateX(0);
  }
}

@keyframes fadeIn {
  from {
    opacity: 0;
    transform: translateY(10px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}

@keyframes popIn {
  0% {
    transform: scale(0.8);
    opacity: 0;
  }
  100% {
    transform: scale(1);
    opacity: 1;
  }
}
</style>
