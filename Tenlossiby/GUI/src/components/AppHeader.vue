<template>
  <div class="header">
    <button class="sidebar-toggle-btn left-toggle" @click="$emit('toggle-left-sidebar')" :class="{ 'active': showLeftSidebar }">
      📅 日程
    </button>
    <div class="header-center">
      <h1 class="main-title">
        <div class="easter-egg-container">
          <button class="easter-egg-btn" @click="triggerEasterEgg" title="点这里有惊喜" :class="{ 'animating': eggAnimating }">
            🎓
          </button>
          <div class="toast-message" :class="{ 'show': showToast }">{{ toastText }}</div>
        </div>
        <span>Solidity 学习互动演示</span>
        <button class="theme-toggle-btn" @click="toggleTheme" title="切换模式">
          {{ isDarkMode ? '☀️' : '🌙' }}
        </button>
      </h1>
      <div class="warning-banner">
        <span>模拟环境，不消耗真实 Gas 或 ETH</span>
        <span class="author-credit">by <a href="https://github.com/Tenlossiby" target="_blank" rel="noopener noreferrer">Tenlossiby</a></span>
      </div>
    </div>
    <button class="sidebar-toggle-btn right-toggle" @click="$emit('toggle-right-sidebar')" :class="{ 'active': showRightSidebar }">
      📊 进度
    </button>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'

defineProps({
  showLeftSidebar: {
    type: Boolean,
    default: true
  },
  showRightSidebar: {
    type: Boolean,
    default: true
  }
})

defineEmits(['toggle-left-sidebar', 'toggle-right-sidebar'])

const isDarkMode = ref(false)

const toggleTheme = () => {
  isDarkMode.value = !isDarkMode.value
  if (isDarkMode.value) {
    document.documentElement.dataset.theme = 'dark'
    localStorage.setItem('theme', 'dark')
  } else {
    document.documentElement.dataset.theme = 'light'
    localStorage.setItem('theme', 'light')
  }
}

// 彩蛋逻辑
const eggAnimating = ref(false)
const showToast = ref(false)
const toastText = ref('')
let toastTimeout = null

const easterEggPhrases = [
  "In Code We Trust!",
  "🔮 今日宜：部署主网；忌：未 Audit",
  "⚠️ 注意你的 Reentrancy 漏洞！",
  "Gas 费太高了，先在这练练手！",
  "HODL! 到下一个牛市！",
  "🎉 签运：大吉！编译一遍过",
  "🚀 To the Moon!",
  "智能合约，不可篡改！",
  "🧐 别忘了测边缘情况"
]

const triggerEasterEgg = () => {
  if (eggAnimating.value) return
  
  // 动画触发
  eggAnimating.value = true
  setTimeout(() => {
    eggAnimating.value = false
  }, 600) // 动画时长

  // Toast 逻辑
  const randomPhrase = easterEggPhrases[Math.floor(Math.random() * easterEggPhrases.length)]
  toastText.value = randomPhrase
  showToast.value = true
  
  if (toastTimeout) clearTimeout(toastTimeout)
  toastTimeout = setTimeout(() => {
    showToast.value = false
  }, 3000)
}

onMounted(() => {
  const savedTheme = localStorage.getItem('theme') || (window.matchMedia('(prefers-color-scheme: dark)').matches ? 'dark' : 'light')
  if (savedTheme === 'dark') {
    isDarkMode.value = true
    document.documentElement.dataset.theme = 'dark'
  }
})
</script>

<style scoped>
.header {
  position: relative;
  z-index: 100;
}

.main-title {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 12px;
  font-size: 1.5em;
  color: var(--accent-yellow);
  margin: 0;
  flex-wrap: wrap;
}

.theme-toggle-btn {
  background: transparent;
  border: none;
  font-size: 0.9em;
  cursor: pointer;
  padding: 5px;
  border-radius: 50%;
  transition: transform 0.3s ease, background-color 0.3s ease;
  display: flex;
  align-items: center;
  justify-content: center;
  color: var(--text-main);
}

.theme-toggle-btn:hover {
  transform: scale(1.15) rotate(15deg);
  background-color: var(--bg-surface-1);
}

/* 彩蛋按钮样式 */
.easter-egg-container {
  position: relative;
  display: inline-flex;
  align-items: center;
  justify-content: center;
}

.easter-egg-btn {
  background: transparent;
  border: 1px dashed transparent;
  font-size: 1em;
  cursor: pointer;
  padding: 4px;
  border-radius: 8px;
  transition: all 0.3s ease;
  display: flex;
  align-items: center;
  justify-content: center;
}

.easter-egg-btn:hover {
  border-color: var(--accent-yellow);
  background-color: var(--bg-surface-1);
  transform: translateY(-2px);
}

.easter-egg-btn.animating {
  animation: eggBounce 0.6s cubic-bezier(0.36, 0.07, 0.19, 0.97) both;
}

@keyframes eggBounce {
  0% { transform: scale(1); }
  25% { transform: scale(1.2) rotate(-15deg); }
  50% { transform: scale(1.2) rotate(15deg); }
  75% { transform: scale(1.1) rotate(-5deg); }
  100% { transform: scale(1) rotate(0); }
}

/* 气泡提示样式 */
.toast-message {
  position: absolute;
  top: 120%;
  left: 50%;
  transform: translateX(-50%) translateY(10px);
  background: var(--accent-blue);
  color: #fff;
  padding: 6px 14px;
  border-radius: 6px;
  font-size: 0.45em;
  font-weight: normal;
  white-space: nowrap;
  opacity: 0;
  visibility: hidden;
  transition: all 0.3s cubic-bezier(0.175, 0.885, 0.32, 1.275);
  box-shadow: var(--shadow-blue-4);
  pointer-events: none;
}

.toast-message::before {
  content: '';
  position: absolute;
  bottom: 100%;
  left: 50%;
  transform: translateX(-50%);
  border-width: 6px;
  border-style: solid;
  border-color: transparent transparent var(--accent-blue) transparent;
}

.toast-message.show {
  opacity: 1;
  visibility: visible;
  transform: translateX(-50%) translateY(0);
}

.author-credit {
  margin-left: 15px;
  font-style: italic;
  color: var(--text-muted);
}

.author-credit a {
  color: var(--text-muted);
  text-decoration: none;
  transition: color 0.3s ease;
}

.author-credit a:hover {
  color: var(--accent-magenta);
  text-decoration: underline;
}

@media (max-width: 768px) {
  .header {
    flex-wrap: wrap; /* 允许在移动端折行 */
  }

  .main-title {
    font-size: 1.1em;
    gap: 8px;
  }
  
  .theme-toggle-btn {
    font-size: 1.1em;
  }

  .toast-message {
    left: 0;
    transform: translateX(0) translateY(10px);
  }
  .toast-message::before {
    left: 15px;
  }
  .toast-message.show {
    transform: translateX(0) translateY(0);
  }
}
</style>
