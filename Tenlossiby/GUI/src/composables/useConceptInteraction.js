import { ref, computed } from 'vue'
import { conceptDefinitions, day11ConceptDefinitions } from '@/data/concepts'

/**
 * 概念徽章点击交互逻辑
 * 用于处理已解锁概念的点击显示详情功能
 */
export function useConceptInteraction(updateCurrentConcept, currentDay = null) {
  // 当前选中的概念 key
  const selectedConcept = ref(null)

  // 获取概念定义（支持 Day 11 和其他天数）
  const getConceptDef = (key) => {
    if (currentDay === 11) {
      return day11ConceptDefinitions[key]
    }
    return conceptDefinitions[key]
  }

  // 处理概念徽章点击
  const handleConceptClick = (conceptKey) => {
    if (selectedConcept.value === conceptKey) {
      // 如果点击的是当前选中的概念，则取消选中并恢复显示最新概念
      selectedConcept.value = null
      if (updateCurrentConcept) {
        updateCurrentConcept(null) // null 表示恢复到显示最新概念
      }
    } else {
      // 否则选中该概念并更新显示
      selectedConcept.value = conceptKey
      if (updateCurrentConcept) {
        updateCurrentConcept(conceptKey)
      }
    }
  }

  // 获取概念徽章文本
  const getConceptBadge = (conceptKey) => {
    const concept = getConceptDef(conceptKey)
    return concept ? `${concept.icon} ${concept.name}` : conceptKey
  }

  // 获取选中的概念详情
  const selectedConceptDetail = computed(() => {
    if (!selectedConcept.value) return null
    return getConceptDef(selectedConcept.value)
  })

  // 清除选中状态
  const clearSelectedConcept = () => {
    selectedConcept.value = null
    if (updateCurrentConcept) {
      updateCurrentConcept(null)
    }
  }

  return {
    selectedConcept,
    selectedConceptDetail,
    handleConceptClick,
    getConceptBadge,
    clearSelectedConcept
  }
}
