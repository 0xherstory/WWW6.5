<template>
  <div class="day-3-content">
    <div class="content-layout">
      <!-- 左侧：交互区域 -->
      <div class="left-column">
        <div class="interaction-area">
          <h3>🎮 交互操作</h3>
          <div class="interaction-controls">
            <div class="input-group">
              <label>🗳️ 候选人姓名：</label>
              <input
                v-model="inputCandidate"
                type="text"
                placeholder="请输入候选人姓名"
                @keyup.enter="handleAddCandidate"
              />
            </div>
            <button class="day-action-btn cyan" @click="handleAddCandidate">
              ➕ 添加候选人/AddCandidate
            </button>
          </div>
        </div>

        <!-- 候选人列表 -->
        <div v-if="candidates.length > 0" class="candidates-list">
          <h4>🗳️ 候选人列表/Candidates</h4>
          <div v-for="candidate in candidates" :key="candidate" class="candidate-item">
            <div class="candidate-info">
              <span class="candidate-name">{{ candidate }}</span>
              <span class="vote-count">{{ voteCount[candidate] || 0 }} 票</span>
            </div>
            <button @click="handleVoteCandidate(candidate)" class="day-action-btn green small">
              🗳️ 投票/Vote
            </button>
          </div>
        </div>
      </div>

      <!-- 右侧：知识面板（使用共享组件） -->
      <KnowledgePanel
        :current-day="3"
        :unlocked-concepts="unlockedConcepts"
        :progress-percentage="progressPercentage"
        :full-code="fullCode"
        @show-full-code="showFullCode = true"
      />
    </div>

    <!-- 完整代码弹窗（使用共享组件） -->
    <FullCodeModal
      :show="showFullCode"
      title="PollStation 完整代码"
      :code="fullCode"
      @close="showFullCode = false"
    />
  </div>
</template>

<script setup>
import { ref } from 'vue'
import { useDay3 } from '@/composables/useDay3'
import KnowledgePanel from '@/components/shared/KnowledgePanel.vue'
import FullCodeModal from '@/components/shared/FullCodeModal.vue'

// 使用 Day 3 composable
const {
  candidates,
  voteCount,
  addCandidate,
  voteCandidate,
  unlockedConcepts,
  progressPercentage
} = useDay3()

// 完整代码
const fullCode = `// SPDX-License-Identifier: MIT

// 声明Solidity版本，要求编译器版本在0.8.0或更高（但低于0.9.0）
pragma solidity ^0.8.0;

// 定义一个名为PollStation的合约，用于投票站功能
contract PollStation{

    // 声明一个公共的字符串数组，用于存储所有候选人的姓名
    // [] 表示这是一个数组类型
    // public 关键字会自动生成getter函数
    string[] public candidateNames;

    // 声明一个映射（mapping），用于存储每个候选人获得的票数
    // 映射结构：mapping(键类型 => 值类型)
    // 这里用候选人的姓名（字符串）作为键，对应的票数（uint256）作为值
    mapping(string => uint256) voteCount;

    // 定义一个函数，用于添加候选人到投票站
    function addCandidateNames(string memory _candidateNames) public{
        // 将候选人姓名添加到数组末尾（push方法）
        candidateNames.push(_candidateNames);

        // 在映射中初始化该候选人的票数为0
        voteCount[_candidateNames] = 0;
    }

    // 定义一个函数，用于获取所有候选人的姓名列表
    function getcandidateNames() public view returns (string[] memory){
        // 返回候选人姓名数组
        return candidateNames;
    }

    // 定义一个函数，用于给指定候选人投票
    function vote(string memory _candidateNames) public{
        // 将指定候选人的票数加1
        // += 是复合赋值运算符，等同于 voteCount[_candidateNames] = voteCount[_candidateNames] + 1
        voteCount[_candidateNames] += 1;
    }

    // 定义一个函数，用于获取指定候选人获得的票数
    function getVote(string memory _candidateNames) public view returns (uint256){
        // 返回指定候选人的票数
        return voteCount[_candidateNames];
    }

}`

// 是否显示完整代码弹窗
const showFullCode = ref(false)

// 输入框的临时状态
const inputCandidate = ref('')

// 处理添加候选人
const handleAddCandidate = () => {
  if (!inputCandidate.value.trim()) {
    alert('请输入候选人姓名')
    return
  }
  addCandidate(inputCandidate.value.trim())
  inputCandidate.value = ''
}

// 处理投票
const handleVoteCandidate = (candidate) => {
  voteCandidate(candidate)
}
</script>

<style scoped>
/* 继承主样式文件中的样式 */
.day-3-content {
  width: 100%;
}

.content-layout {
  display: flex;
  gap: 20px;
  flex-wrap: wrap;
}

.left-column {
  flex: 1;
  min-width: 300px;
}

.interaction-area {
  background: var(--bg-surface-1);
  padding: 20px;
  border-radius: 8px;
  border: 2px solid var(--border-main);
  margin-bottom: 20px;
}

.interaction-area h3 {
  margin-top: 0;
  color: var(--accent-yellow);
}

.interaction-controls {
  display: flex;
  flex-direction: column;
  gap: 10px;
  margin-top: 15px;
}

.input-group {
  margin-bottom: 10px;
}

.input-group label {
  display: block;
  margin-bottom: 5px;
  color: var(--text-main);
  font-weight: 500;
}

.input-group input {
  width: 100%;
  padding: 10px;
  border: 1px solid var(--border-main);
  border-radius: 6px;
  background: var(--bg-base);
  color: var(--text-main);
  font-size: 1em;
  box-sizing: border-box;
}

.input-group input:focus {
  outline: none;
  border-color: var(--accent-cyan);
  box-shadow: 0 0 0 3px rgba(42, 161, 152, 0.1);
}

.interaction-controls .day-action-btn {
  width: 100%;
}

.candidates-list {
  background: var(--bg-surface-1);
  padding: 20px;
  border-radius: 8px;
  border: 2px solid var(--accent-green);
}

.candidates-list h4 {
  margin: 0 0 15px 0;
  color: var(--accent-green);
}

.candidate-item {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 12px;
  background: var(--bg-base);
  border-radius: 6px;
  margin-bottom: 10px;
  border: 1px solid var(--border-main);
}

.candidate-info {
  display: flex;
  flex-direction: column;
  gap: 5px;
}

.candidate-name {
  font-weight: bold;
  color: var(--text-main);
  font-size: 1.1em;
}

.vote-count {
  color: var(--accent-blue);
  font-size: 0.9em;
}

.day-action-btn.small {
  padding: 8px 16px;
  font-size: 0.9em;
}
</style>
