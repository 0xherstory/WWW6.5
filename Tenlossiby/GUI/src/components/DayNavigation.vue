<template>
  <div class="left-sidebar">
    <h3>📚 学习导航</h3>
    <div 
      v-for="day in 7" 
      :key="day"
      class="day-nav-item"
      :class="{ active: currentDay === day }"
      @click="$emit('switchDay', day)"
    >
      <div class="day-title">Day {{ day }}</div>
      <div class="day-subtitle">{{ getDaySubtitle(day) }}</div>
    </div>
  </div>
</template>

<script setup>
import { dayConfigs } from '../data/days'

defineProps({
  currentDay: {
    type: Number,
    required: true
  }
})

defineEmits(['switchDay'])

const getDaySubtitle = (day) => {
  return dayConfigs[day]?.subtitle || '待定内容'
}
</script>

<style scoped>
</style>
