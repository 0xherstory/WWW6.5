<template>
  <div class="app-container">
    <AppHeader 
      :show-left-sidebar="showLeftSidebar"
      :show-right-sidebar="showRightSidebar"
      @toggle-left-sidebar="showLeftSidebar = !showLeftSidebar"
      @toggle-right-sidebar="showRightSidebar = !showRightSidebar"
    />
    <div v-if="showLeftSidebar || showRightSidebar" class="sidebar-overlay" @click="closeSidebars"></div>
    <div class="main-layout">
      <DayNavigation :current-day="currentDay" @switch-day="switchDay" :class="{ 'hidden': !showLeftSidebar, 'mobile-visible': showLeftSidebar }" />
      <DayContent 
        :current-day="currentDay"
        :counter="contracts.day1.count"
        :interaction-count="contracts.day1.interactionCount"
        :day2-name="contracts.day2.name"
        :day2-bio="contracts.day2.bio"
        :day2-interaction-count="contracts.day2.interactionCount"
        :day2-has-stored="contracts.day2.hasStored"
        :day2-has-retrieved="contracts.day2.hasRetrieved"
        :day3-candidates="contracts.day3.candidates"
        :day3-vote-count="contracts.day3.voteCount"
        :day3-interaction-count="contracts.day3.interactionCount"
        :day4-owner="contracts.day4.owner"
        :day4-item="contracts.day4.item"
        :day4-auction-end-time="contracts.day4.auctionEndTime"
        :day4-highest-bidder="contracts.day4.highestBidder"
        :day4-highest-bid="contracts.day4.highestBid"
        :day4-ended="contracts.day4.ended"
        :day4-bids="contracts.day4.bids"
        :day4-bidders="contracts.day4.bidders"
        :day4-interaction-count="contracts.day4.interactionCount"
        :day5-owner="contracts.day5.owner"
        :day5-treasure-amount="contracts.day5.treasureAmount"
        :day5-user-address="contracts.day5.userAddress"
        :day5-user-allowance="contracts.day5.userAllowance"
        :day5-has-withdrawn="day5UserHasWithdrawn"
        :day5-interaction-count="contracts.day5.interactionCount"
        :day6-bank-manager="contracts.day6.bankManager"
        :day6-members="contracts.day6.members"
        :day6-user-address="contracts.day6.userAddress"
        :day6-user-balance="contracts.day6.balance[contracts.day6.userAddress] || 0"
        :day6-interaction-count="contracts.day6.interactionCount"
        :day6-query-balance="day6QueryBalance"
        :day6-members-list="day6MembersList"
        :day-progress="dayProgress"
        @click-counter="clickCounter"
        @reset-counter="resetCounter"
        @store-data="storeData"
        @retrieve-data="retrieveData"
        @add-candidate="addCandidate"
        @vote-candidate="voteCandidate"
        @initialize-auction="initializeAuction"
        @place-bid="placeBid"
        @end-auction="endAuction"
        @get-winner="getWinner"
        @add-treasure="addTreasure"
        @approve-withdrawal="approveWithdrawal"
        @withdraw-treasure="withdrawTreasure"
        @reset-withdrawal-status="resetWithdrawalStatus"
        @transfer-ownership="transferOwnership"
        @get-treasure-details="getTreasureDetails"
        @add-members="addMembers"
        @deposit-ether="depositEther"
        @withdraw-eth="withdrawEth"
        @get-balance="getBalance"
        @get-members="getMembers"
        :day7-owner="contracts.day7?.owner || ''"
        :day7-user-address="contracts.day7?.userAddress || ''"
        :day7-friends-list="contracts.day7?.friendList || []"
        :day7-user-balance="contracts.day7?.balances?.[contracts.day7?.userAddress] || 0"
        :day7-debts="contracts.day7?.debts || {}"
        :day7-interaction-count="contracts.day7?.interactionCount || 0"
        :day7-checked-balance="day7CheckedBalance"
        @add-friend="iouAddFriend"
        @deposit-iou="iouDeposit"
        @record-debt="iouRecordDebt"
        @pay-from-wallet="iouPayDebt"
        @transfer-method="iouTransferMethod"
        @call-method="iouCallMethod"
        @withdraw-iou="iouWithdraw"
        @check-balance="iouCheckBalance"
      />
      <Sidebar 
        :counter="contracts.day1.count"
        :interaction-count="contracts.day1.interactionCount"
        :day-progress="dayProgress"
        :current-day="currentDay"
        :class="{ 'hidden': !showRightSidebar, 'mobile-visible': showRightSidebar }"
      />
    </div>
  </div>
</template>

<script setup>
import { ref, computed, onMounted, onUnmounted } from 'vue'
import AppHeader from './components/AppHeader.vue'
import DayNavigation from './components/DayNavigation.vue'
import DayContent from './components/DayContent.vue'
import Sidebar from './components/Sidebar.vue'
import { dayConfigs } from './data/days'
import { conceptDefinitions } from './data/concepts'
import { getFullCode } from './data/days'

const showLeftSidebar = ref(true)
const showRightSidebar = ref(true)
const currentDay = ref(1)

const isMobile = ref(false)

const checkMobile = () => {
  isMobile.value = window.innerWidth <= 768
  if (isMobile.value) {
    showLeftSidebar.value = false
    showRightSidebar.value = false
  } else {
    showLeftSidebar.value = true
    showRightSidebar.value = true
  }
}

onMounted(() => {
  checkMobile()
  window.addEventListener('resize', checkMobile)
})

onUnmounted(() => {
  window.removeEventListener('resize', checkMobile)
})
const contracts = ref({
  day1: {
    count: 0,
    interactionCount: 0
  },
  day2: {
    name: "",
    bio: "",
    interactionCount: 0,
    hasStored: false,
    hasRetrieved: false
  },
  day3: {
    candidates: [],
    voteCount: {},
    interactionCount: 0
  },
  day4: {
    owner: "",
    item: "",
    auctionEndTime: 0,
    highestBidder: "",
    highestBid: 0,
    ended: false,
    bids: {},
    bidders: [],
    interactionCount: 0
  },
  day5: {
    owner: "",
    treasureAmount: 0,
    withdrawalAllowance: {},
    hasWithdrawn: {},
    userAddress: "0x" + Math.random().toString(16).substr(2, 40),
    userAllowance: 0,
    interactionCount: 0
  },
  day6: {
    bankManager: "",
    members: [],
    registeredMembers: {},
    balance: {},
    userAddress: "0x" + Math.random().toString(16).substr(2, 40),
    interactionCount: 0,
    depositCount: 0,
    withdrawCount: 0
  },
  day7: {
    owner: "",
    userAddress: "",
    registeredFriends: {},
    friendList: [],
    balances: {},
    debts: {},
    interactionCount: 0
  }
})
const dayProgress = ref({
  1: {
    unlockedConcepts: [],
    totalConcepts: 4,
    interactionCount: 0
  },
  2: {
    unlockedConcepts: [],
    totalConcepts: 6,
    interactionCount: 0
  },
  3: {
    unlockedConcepts: [],
    totalConcepts: 4,
    interactionCount: 0
  },
  4: {
    unlockedConcepts: [],
    totalConcepts: 7,
    interactionCount: 0
  },
  5: {
    unlockedConcepts: [],
    totalConcepts: 3,
    interactionCount: 0
  },
  6: {
    unlockedConcepts: [],
    totalConcepts: 5,
    interactionCount: 0
  },
  7: {
    unlockedConcepts: [],
    totalConcepts: 7,
    interactionCount: 0
  }
})

const clickCounter = () => {
  contracts.value.day1.count++
  contracts.value.day1.interactionCount++
  dayProgress.value[1].interactionCount++
  
  const clickCount = contracts.value.day1.count
  if (clickCount === 1) {
    unlockConcept(1, 'function')
  } else if (clickCount === 2) {
    unlockConcept(1, 'increment')
  } else if (clickCount === 3) {
    unlockConcept(1, 'uint256')
  } else if (clickCount === 4) {
    unlockConcept(1, 'contract')
  }
}

const checkAndUnlockConcepts = (day) => {
  const interactionCount = dayProgress.value[day].interactionCount
  const dayConcepts = dayConfigs[day]?.concepts || []
  const currentUnlocked = [...dayProgress.value[day].unlockedConcepts]
  
  dayConcepts.forEach(conceptKey => {
    const concept = conceptDefinitions[conceptKey]
    if (concept && interactionCount >= concept.unlockAt && !currentUnlocked.includes(conceptKey)) {
      currentUnlocked.push(conceptKey)
    }
  })
  
  dayProgress.value[day].unlockedConcepts = currentUnlocked
}

const unlockConcept = (day, conceptKey) => {
  if (!dayProgress.value[day].unlockedConcepts.includes(conceptKey)) {
    dayProgress.value[day].unlockedConcepts.push(conceptKey)
  }
}

const resetCounter = () => {
  contracts.value.day1.count = 0
}

const switchDay = (day) => {
  currentDay.value = day
}

const closeSidebars = () => {
  showLeftSidebar.value = false
  showRightSidebar.value = false
}

const storeData = (name, bio) => {
  contracts.value.day2.name = name
  contracts.value.day2.bio = bio
  contracts.value.day2.hasStored = true
  contracts.value.day2.interactionCount++
  dayProgress.value[2].interactionCount++
  
  const unlocked = dayProgress.value[2].unlockedConcepts
  if (!unlocked.includes('string')) {
    unlockConcept(2, 'string')
  } else if (!unlocked.includes('private')) {
    unlockConcept(2, 'private')
  } else if (!unlocked.includes('memory')) {
    unlockConcept(2, 'memory')
  }
}

const retrieveData = () => {
  contracts.value.day2.hasRetrieved = true
  contracts.value.day2.interactionCount++
  dayProgress.value[2].interactionCount++
  
  const unlocked = dayProgress.value[2].unlockedConcepts
  if (!unlocked.includes('view')) {
    unlockConcept(2, 'view')
  } else if (!unlocked.includes('parameters')) {
    unlockConcept(2, 'parameters')
  } else if (!unlocked.includes('returns')) {
    unlockConcept(2, 'returns')
  }
}

const addCandidate = (candidateName) => {
  contracts.value.day3.candidates.push(candidateName)
  contracts.value.day3.voteCount[candidateName] = 0
  contracts.value.day3.interactionCount++
  dayProgress.value[3].interactionCount++
  
  const candidateCount = contracts.value.day3.candidates.length
  if (candidateCount === 1) {
    unlockConcept(3, 'array')
  } else if (candidateCount === 2) {
    unlockConcept(3, 'push')
  } else if (candidateCount === 3) {
    unlockConcept(3, 'mapping')
  }
}

const voteCandidate = (candidateName) => {
  if (contracts.value.day3.voteCount[candidateName] !== undefined) {
    contracts.value.day3.voteCount[candidateName]++
    contracts.value.day3.interactionCount++
    dayProgress.value[3].interactionCount++
    
    unlockConcept(3, 'compound_assignment')
  }
}

const initializeAuction = (item, biddingTime) => {
  contracts.value.day4.owner = "0x" + Math.random().toString(16).slice(2, 42)
  contracts.value.day4.item = item
  contracts.value.day4.auctionEndTime = Math.floor(Date.now() / 1000) + biddingTime
  contracts.value.day4.interactionCount++
  dayProgress.value[4].interactionCount++
  
  unlockConcept(4, 'constructor')
  unlockConcept(4, 'block_timestamp')
}

const placeBid = (amount, bidderAddress) => {
  if (contracts.value.day4.ended) {
    return
  }
  
  const currentTime = Math.floor(Date.now() / 1000)
  if (currentTime >= contracts.value.day4.auctionEndTime) {
    return
  }
  
  if (amount <= 0) {
    return
  }
  
  const currentBid = contracts.value.day4.bids[bidderAddress] || 0
  if (amount <= currentBid) {
    return
  }
  
  contracts.value.day4.bids[bidderAddress] = amount
  contracts.value.day4.interactionCount++
  dayProgress.value[4].interactionCount++
  
  if (currentBid === 0) {
    contracts.value.day4.bidders.push(bidderAddress)
  }
  
  if (amount > contracts.value.day4.highestBid) {
    contracts.value.day4.highestBid = amount
    contracts.value.day4.highestBidder = bidderAddress
  }
  
  // 按照出价次数逐步解锁概念
  const numBids = contracts.value.day4.bidders.length
  
  unlockConcept(4, 'require') // 出价基本需要 require
  
  if (numBids >= 1) {
    unlockConcept(4, 'msg_sender') 
  }
  if (numBids >= 2 || contracts.value.day4.interactionCount >= 2) {
    unlockConcept(4, 'external') // 多次交互后解锁 external
  }
}

const endAuction = () => {
  const currentTime = Math.floor(Date.now() / 1000)
  if (currentTime < contracts.value.day4.auctionEndTime) {
    return
  }
  
  if (contracts.value.day4.ended) {
    return
  }
  
  contracts.value.day4.ended = true
  contracts.value.day4.interactionCount++
  dayProgress.value[4].interactionCount++
  
  unlockConcept(4, 'bool_type')
}

const getWinner = () => {
  if (!contracts.value.day4.ended) {
    return null
  }
  
  contracts.value.day4.interactionCount++
  dayProgress.value[4].interactionCount++
  
  unlockConcept(4, 'address_type')
  
  return {
    winner: contracts.value.day4.highestBidder,
    bid: contracts.value.day4.highestBid
  }
}

const initDay5 = () => {
  if (!contracts.value.day5.owner) {
    contracts.value.day5.owner = '0x' + Math.random().toString(16).substr(2, 40)
  }
  if (!contracts.value.day5.userAddress) {
    contracts.value.day5.userAddress = '0x' + Math.random().toString(16).substr(2, 40)
  }
}

const day5UserHasWithdrawn = computed(() => {
  return !!contracts.value.day5.hasWithdrawn[contracts.value.day5.userAddress]
})

const day6QueryBalance = ref(null)
const day6MembersList = ref([])

const day7CheckedBalance = ref(null)

const addTreasure = (amount) => {
  initDay5()
  contracts.value.day5.treasureAmount += amount
  contracts.value.day5.interactionCount++
  dayProgress.value[5].interactionCount++
  
  unlockConcept(5, 'modifier')
}

const approveWithdrawal = (recipient, amount) => {
  initDay5()
  if (amount <= contracts.value.day5.treasureAmount) {
    contracts.value.day5.withdrawalAllowance[recipient] = amount
    if (recipient === contracts.value.day5.userAddress) {
      contracts.value.day5.userAllowance = amount
    }
  }
  contracts.value.day5.interactionCount++
  dayProgress.value[5].interactionCount++
  
  unlockConcept(5, 'return_statement')
}

const withdrawTreasure = (userAddress, amount) => {
  initDay5()
  
  if (userAddress === contracts.value.day5.owner) {
    if (amount <= contracts.value.day5.treasureAmount) {
      contracts.value.day5.treasureAmount -= amount
    }
  } else {
    const allowance = contracts.value.day5.withdrawalAllowance[userAddress]
    if (allowance > 0 && !contracts.value.day5.hasWithdrawn[userAddress] && allowance <= contracts.value.day5.treasureAmount && allowance >= amount) {
      contracts.value.day5.hasWithdrawn[userAddress] = true
      contracts.value.day5.treasureAmount -= allowance
      contracts.value.day5.withdrawalAllowance[userAddress] = 0
      if (userAddress === contracts.value.day5.userAddress) {
        contracts.value.day5.userAllowance = 0
      }
    }
  }
  contracts.value.day5.interactionCount++
  dayProgress.value[5].interactionCount++
  
  unlockConcept(5, 'return_statement')
}

const resetWithdrawalStatus = (userAddress) => {
  initDay5()
  if (!userAddress) {
    userAddress = contracts.value.day5.userAddress
  }
  contracts.value.day5.hasWithdrawn[userAddress] = false
  contracts.value.day5.interactionCount++
  dayProgress.value[5].interactionCount++
}

const transferOwnership = (newOwner) => {
  initDay5()
  if (newOwner !== '0x0000000000000000000000000000000000000000') {
    contracts.value.day5.owner = newOwner
    contracts.value.day5.interactionCount++
    dayProgress.value[5].interactionCount++
    
    unlockConcept(5, 'zero_address')
  }
}

const getTreasureDetails = () => {
  initDay5()
  contracts.value.day5.interactionCount++
  dayProgress.value[5].interactionCount++
  
  unlockConcept(5, 'return_statement')
  
  return contracts.value.day5.treasureAmount
}

const initDay6 = () => {
  if (contracts.value.day6.bankManager === '') {
    contracts.value.day6.bankManager = "0x" + Math.random().toString(16).substr(2, 40)
    contracts.value.day6.members = [contracts.value.day6.bankManager]
    contracts.value.day6.registeredMembers = { [contracts.value.day6.bankManager]: true, [contracts.value.day6.userAddress]: true }
    contracts.value.day6.balance = { [contracts.value.day6.bankManager]: 0, [contracts.value.day6.userAddress]: 0 }
    contracts.value.day6.members.push(contracts.value.day6.userAddress)
  }
}

const addMembers = (memberAddress) => {
  initDay6()
  const bankManager = contracts.value.day6.bankManager
  
  if (memberAddress === '0x0000000000000000000000000000000000000000') {
    return
  }
  if (memberAddress === bankManager) {
    return
  }
  if (contracts.value.day6.registeredMembers[memberAddress]) {
    return
  }
  
  contracts.value.day6.registeredMembers[memberAddress] = true
  contracts.value.day6.members.push(memberAddress)
  contracts.value.day6.balance[memberAddress] = 0
  contracts.value.day6.interactionCount++
  dayProgress.value[6].interactionCount++
  
  unlockConcept(6, 'address_mapping_balance')
}

const depositEther = (amountEth) => {
  initDay6()
  const userAddress = contracts.value.day6.userAddress
  
  if (!contracts.value.day6.registeredMembers[userAddress]) {
    return
  }
  
  const amountWei = amountEth * 1e18
  contracts.value.day6.balance[userAddress] += amountWei
  contracts.value.day6.interactionCount++
  dayProgress.value[6].interactionCount++
  contracts.value.day6.depositCount++
  
  unlockConcept(6, 'payable')
  unlockConcept(6, 'msg_value')
}

const withdrawEth = (amountEth) => {
  initDay6()
  const userAddress = contracts.value.day6.userAddress
  
  if (!contracts.value.day6.registeredMembers[userAddress]) {
    return
  }
  
  const amountWei = amountEth * 1e18
  if (contracts.value.day6.balance[userAddress] < amountWei) {
    return
  }
  
  contracts.value.day6.balance[userAddress] -= amountWei
  contracts.value.day6.interactionCount++
  dayProgress.value[6].interactionCount++
  contracts.value.day6.withdrawCount++
  
  unlockConcept(6, 'wei_unit')
  unlockConcept(6, 'ether_deposit_withdraw')
}

const getBalance = (queryAddress) => {
  initDay6()
  contracts.value.day6.interactionCount++
  dayProgress.value[6].interactionCount++
  
  day6QueryBalance.value = contracts.value.day6.balance[queryAddress] || 0
}

const getMembers = () => {
  initDay6()
  contracts.value.day6.interactionCount++
  dayProgress.value[6].interactionCount++
  
  day6MembersList.value = [...contracts.value.day6.members]
}

// ============== Day 7 IOUSimple ================
const initDay7 = () => {
  if (contracts.value.day7.owner === '') {
    const owner = "0x" + Math.random().toString(16).substr(2, 40)
    contracts.value.day7.owner = owner
    contracts.value.day7.userAddress = owner
    contracts.value.day7.registeredFriends[owner] = true
    contracts.value.day7.friendList.push(owner)
  }
}

const iouAddFriend = (friendAddress) => {
  initDay7()
  if (contracts.value.day7.registeredFriends[friendAddress]) return
  
  contracts.value.day7.registeredFriends[friendAddress] = true
  contracts.value.day7.friendList.push(friendAddress)
  contracts.value.day7.balances[friendAddress] = 0
  
  contracts.value.day7.interactionCount++
  dayProgress.value[7].interactionCount++
  unlockConcept(7, 'nested_mapping')
}

const iouDeposit = (amountEth) => {
  initDay7()
  const user = contracts.value.day7.userAddress
  if (!contracts.value.day7.registeredFriends[user]) return
  
  const amountWei = amountEth * 1e18
  contracts.value.day7.balances[user] = (contracts.value.day7.balances[user] || 0) + amountWei
  
  contracts.value.day7.interactionCount++
  dayProgress.value[7].interactionCount++
  unlockConcept(7, 'address_payable')
}

const iouRecordDebt = (debtor, amountEth) => {
  initDay7()
  const user = contracts.value.day7.userAddress
  
  const amountWei = amountEth * 1e18
  if (!contracts.value.day7.debts[debtor]) {
    contracts.value.day7.debts[debtor] = {}
  }
  contracts.value.day7.debts[debtor][user] = (contracts.value.day7.debts[debtor][user] || 0) + amountWei
  
  contracts.value.day7.interactionCount++
  dayProgress.value[7].interactionCount++
  unlockConcept(7, 'debt_tracking')
  return true
}

const iouPayDebt = (creditor, amountEth) => {
  initDay7()
  const user = contracts.value.day7.userAddress
  
  const amountWei = amountEth * 1e18
  
  if ((contracts.value.day7.balances[user] || 0) < amountWei) {
    return "余额不足：你的钱包可用余额小于还款金额！"
  }
  
  // 仅在自身余额充足时进行前端扣发逻辑模拟
  contracts.value.day7.balances[user] -= amountWei
  contracts.value.day7.balances[creditor] = (contracts.value.day7.balances[creditor] || 0) + amountWei
  
  if (contracts.value.day7.debts[user] && contracts.value.day7.debts[user][creditor]) {
      contracts.value.day7.debts[user][creditor] -= amountWei;
      if (contracts.value.day7.debts[user][creditor] < 0) {
          contracts.value.day7.debts[user][creditor] = 0;
      }
  }
  
  contracts.value.day7.interactionCount++
  dayProgress.value[7].interactionCount++
  unlockConcept(7, 'internal_transfer')
  return true
}

const iouTransferMethod = (toAddress, amountEth) => {
  initDay7()
  const user = contracts.value.day7.userAddress
  
  const amountWei = amountEth * 1e18
  if ((contracts.value.day7.balances[user] || 0) < amountWei) {
    return "余额不足：试图转账的金额超过了你拥有的钱包余额！"
  }
  
  contracts.value.day7.balances[user] -= amountWei
  contracts.value.day7.balances[toAddress] = (contracts.value.day7.balances[toAddress] || 0) + amountWei

  contracts.value.day7.interactionCount++
  dayProgress.value[7].interactionCount++
  unlockConcept(7, 'transfer_method')
  return true
}

const iouCallMethod = (toAddress, amountEth) => {
  initDay7()
  const user = contracts.value.day7.userAddress
  
  const amountWei = amountEth * 1e18
  if ((contracts.value.day7.balances[user] || 0) < amountWei) {
    return "余额不足：低级调用失败，因为你的钱包没有足够的以太币！"
  }
  
  contracts.value.day7.balances[user] -= amountWei
  contracts.value.day7.balances[toAddress] = (contracts.value.day7.balances[toAddress] || 0) + amountWei

  contracts.value.day7.interactionCount++
  dayProgress.value[7].interactionCount++
  unlockConcept(7, 'call_method')
  return true
}

const iouWithdraw = (amountEth) => {
  initDay7()
  const user = contracts.value.day7.userAddress
  const amountWei = amountEth * 1e18
  
  if ((contracts.value.day7.balances[user] || 0) < amountWei) {
    return "余额不足：你无法提取超过拥有额度的资金！"
  }
  
  contracts.value.day7.balances[user] -= amountWei
  
  contracts.value.day7.interactionCount++
  dayProgress.value[7].interactionCount++
  unlockConcept(7, 'withdraw_pattern')
  return true
}

const iouCheckBalance = () => {
  initDay7()
  const user = contracts.value.day7.userAddress
  day7CheckedBalance.value = contracts.value.day7.balances[user] || 0
  
  contracts.value.day7.interactionCount++
  dayProgress.value[7].interactionCount++
  unlockConcept(7, 'withdraw_pattern')
}
</script>

<style scoped>
</style>
