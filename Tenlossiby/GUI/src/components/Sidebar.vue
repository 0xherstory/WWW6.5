<template>
  <div class="right-sidebar">
    <div class="sidebar-card">
      <h3>🎓 学习进度</h3>
      <div class="progress-bar">
        <div class="progress-fill" :style="{ width: progressPercentage + '%' }"></div>
      </div>
      <div class="progress-stats">
        <span>完成度 {{ progressPercentage }}%</span>
        <span>已解锁 {{ unlockedCount }}/{{ totalConcepts }}</span>
      </div>
    </div>

    <div class="sidebar-card">
      <h3>✅ 已解锁概念</h3>
      <ul class="unlocked-list">
        <li v-if="currentDayConcepts.length === 0" class="locked">
          <span class="icon">🚧</span> 内容开发中...
        </li>
        <li 
          v-for="concept in currentDayConcepts" 
          :key="concept.key"
          :class="{ locked: !concept.isUnlocked }"
        >
          <span class="icon">{{ concept.icon }}</span>
          {{ concept.name }}
        </li>
      </ul>
    </div>

    <div class="sidebar-card">
      <h3>📊 实时数据</h3>
      <div class="realtime-data">
        <div class="data-row">
          <span class="label">计数值：</span>
          <span class="value">{{ counter }}</span>
        </div>
        <div class="data-row">
          <span class="label">点击次数：</span>
          <span class="value">{{ interactionCount }}</span>
        </div>
        <div class="data-row">
          <span class="label">Gas 消耗：</span>
          <span class="value">{{ totalGas.toLocaleString() }}</span>
        </div>
        <div class="data-row">
          <span class="label">ETH 费用：</span>
          <span class="value">{{ totalEthCost.toFixed(6) }}</span>
        </div>
      </div>
    </div>

    <div class="sidebar-card">
      <h3>📋 操作日志</h3>
      <div class="operation-log">
        <p v-if="logs.length === 0" style="color: #999; font-size: 0.85em; text-align: center; padding: 20px;">暂无操作记录</p>
        <div v-else v-for="log in logs.slice(0, 10)" :key="log.id" class="log-entry">
          <div class="timestamp">{{ log.timestamp }}</div>
          <div><strong>{{ log.operation }}</strong> {{ log.details }}</div>
          <div style="font-size: 0.85em; color: #666; margin-top: 4px;">
            Gas: {{ log.gasUsed.toLocaleString() }} | ETH: {{ log.ethCost.toFixed(6) }}
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { computed } from 'vue'
import { dayConfigs } from '../data/days'
import { conceptDefinitions, gasEstimates, ethPricePerGwei } from '../data/concepts'

const props = defineProps({
  counter: {
    type: Number,
    default: 0
  },
  interactionCount: {
    type: Number,
    default: 0
  },
  dayProgress: {
    type: Object,
    required: true
  },
  currentDay: {
    type: Number,
    required: true
  }
})

const logs = computed(() => {
  const result = []
  const currentProgress = props.dayProgress[props.currentDay]
  if (!currentProgress) return result

  const unlockedConcepts = currentProgress.unlockedConcepts || []
  unlockedConcepts.forEach((conceptKey, index) => {
    result.push({
      id: `log-${index}`,
      timestamp: new Date().toLocaleTimeString(),
      operation: '解锁概念',
      details: conceptDefinitions[conceptKey]?.name || conceptKey,
      gasUsed: 0,
      ethCost: 0
    })
  })

  if (props.interactionCount > 0) {
    const clickGas = (props.interactionCount - 1) * gasEstimates.increment
    const clickEth = clickGas * ethPricePerGwei
    if (clickGas > 0) {
      result.push({
        id: 'click-log',
        timestamp: new Date().toLocaleTimeString(),
        operation: '点击计数器',
        details: `累计 ${props.interactionCount} 次点击`,
        gasUsed: clickGas,
        ethCost: clickEth
      })
    }
  }

  return result.sort((a, b) => b.id.localeCompare(a.id))
})

const progressPercentage = computed(() => {
  const currentProgress = props.dayProgress[props.currentDay]
  if (!currentProgress || currentProgress.totalConcepts === 0) return 0
  return Math.floor((currentProgress.unlockedConcepts.length / currentProgress.totalConcepts) * 100)
})

const unlockedCount = computed(() => {
  const currentProgress = props.dayProgress[props.currentDay]
  return currentProgress?.unlockedConcepts.length || 0
})

const totalConcepts = computed(() => {
  const currentProgress = props.dayProgress[props.currentDay]
  return currentProgress?.totalConcepts || 0
})

const currentDayConcepts = computed(() => {
  const dayConfig = dayConfigs[props.currentDay]
  if (!dayConfig || !dayConfig.concepts) return []

  const currentProgress = props.dayProgress[props.currentDay]
  const unlockedConcepts = currentProgress?.unlockedConcepts || []

  return dayConfig.concepts.map(conceptKey => {
    const concept = conceptDefinitions[conceptKey]
    return {
      key: conceptKey,
      name: concept?.name || conceptKey,
      icon: unlockedConcepts.includes(conceptKey) ? concept?.icon : '🔒',
      isUnlocked: unlockedConcepts.includes(conceptKey)
    }
  })
})

const totalGas = computed(() => {
  return props.interactionCount * gasEstimates.increment
})

const totalEthCost = computed(() => {
  return totalGas.value * ethPricePerGwei
})
</script>

<style scoped>
</style>
