<template>
  <div class="center-content">
    <div class="day-header">
      <h2>{{ dayTitle }}</h2>
      <div>
        <div class="progress-bar">
          <div class="progress-fill" :style="{ width: progressPercentage + '%' }"></div>
        </div>
        <div class="progress-text">完成度 {{ progressPercentage }}%</div>
      </div>
    </div>

    <div v-if="currentDay === 1" class="day-1-content">
      <div class="content-layout">
        <div class="left-column">
          <div class="interaction-area">
            <h3>🎮 交互操作</h3>
            <div class="interaction-controls">
              <button @click.stop="handleClickCounter">🖱️ 点击计数器/ClickCounter</button>
              <button class="reset-btn" @click.stop="$emit('reset-counter')">🔄 重置计数器/ResetCounter</button>
            </div>
            <div class="result-display">
              <h4>当前计数值：</h4>
              <div class="result-value">{{ counter }}</div>
            </div>
          </div>
        </div>

        <div v-if="showUnlockArea" class="right-column">
          <div class="hint-bubble">
            <h4>💡 交互提示</h4>
            <p>{{ hintText }}</p>
          </div>

          <div class="knowledge-unlock" @click.stop>
            <h4>🎉 恭喜解锁新知识！</h4>
            <span class="unlock-badge">{{ unlockBadge }}</span>
            <p>{{ unlockText }}</p>
            <div v-if="currentConceptCode" class="code-snippet">{{ currentConceptCode }}</div>
            <div class="concept-list">
              <div 
                v-for="conceptKey in unlockedConcepts" 
                :key="conceptKey"
                class="concept-badge"
                :class="{ active: activeConcept === conceptKey }"
                @click="showConceptExplanation(conceptKey)"
              >
                <span class="check-icon">✓</span>
                {{ conceptDefinitions[conceptKey]?.name }}
              </div>
            </div>
            <button v-if="allConceptsUnlocked" class="view-full-code-btn" @click="showFullCode">
              📖 查看完整代码
            </button>
          </div>
        </div>
      </div>

      <div v-if="showFullCodeSection" class="full-code-section" @click.stop>
        <h3>📝 ClickCounter 完整代码</h3>
        <div class="full-code-container">{{ fullCode }}</div>
        <button class="view-full-code-btn" @click="hideFullCode" style="margin-top: 15px;">
          🔙 返回知识解释
        </button>
      </div>
    </div>

    <div v-else-if="currentDay === 2" class="day-2-content">
      <div class="content-layout">
        <div class="left-column">
          <div class="interaction-area">
            <h3>🎮 交互操作</h3>
            <div class="interaction-controls">
              <div class="input-group">
            <label for="name-input">姓名/Name：</label>
            <input 
              id="name-input"
              v-model="inputName" 
              type="text" 
              placeholder="请输入你的名字"
              @click.stop
            >
              </div>
              <div class="input-group">
            <label for="bio-input">简介/Bio：</label>
            <input 
              id="bio-input"
              v-model="inputBio" 
              type="text" 
              placeholder="请输入你的简介"
              @click.stop
            >
              </div>
              <div class="button-group">
                <button @click.stop="handleStoreData">💾 存储数据/StoreData</button>
                <button @click.stop="handleRetrieveData">📖 检索数据/RetrieveData</button>
              </div>
              <div class="input-group" style="margin-top: 15px;">
                <label for="search-input">搜索关键词/Search：</label>
                <input 
                  id="search-input"
                  v-model="inputSearch" 
                  type="text" 
                  placeholder="搜索名字或简介"
                  @click.stop
                >
              </div>
            </div>
            <div v-if="showSearchResult" class="result-display">
              <h4>🔍 搜索结果：</h4>
              <div class="result-value">
                <div v-if="searchResult.found">
                  <div><strong>姓名/Name：</strong>{{ searchResult.name }}</div>
                  <div><strong>简介/Bio：</strong>{{ searchResult.bio }}</div>
                </div>
                <div v-else class="no-data">❌ 没有找到匹配的数据</div>
              </div>
            </div>
            <div v-if="showStoredData" class="result-display">
              <h4>存储的数据：</h4>
              <div class="result-value">
                <div><strong>姓名/Name：</strong>{{ props.day2Name || '暂无数据' }}</div>
                <div><strong>简介/Bio：</strong>{{ props.day2Bio || '暂无数据' }}</div>
              </div>
            </div>
          </div>
        </div>

        <div v-if="showUnlockArea" class="right-column">
          <div class="hint-bubble">
            <h4>💡 交互提示</h4>
            <p>{{ hintText }}</p>
          </div>

          <div class="knowledge-unlock" @click.stop>
            <h4>🎉 恭喜解锁新知识！</h4>
            <span class="unlock-badge">{{ unlockBadge }}</span>
            <p>{{ unlockText }}</p>
            <div v-if="currentConceptCode" class="code-snippet">{{ currentConceptCode }}</div>
            <div class="concept-list">
              <div 
                v-for="conceptKey in unlockedConcepts" 
                :key="conceptKey"
                class="concept-badge"
                :class="{ active: activeConcept === conceptKey }"
                @click="showConceptExplanation(conceptKey)"
              >
                <span class="check-icon">✓</span>
                {{ conceptDefinitions[conceptKey]?.name }}
              </div>
            </div>
            <button v-if="allConceptsUnlocked" class="view-full-code-btn" @click="showFullCode">
              📖 查看完整代码
            </button>
          </div>
        </div>
      </div>

      <div v-if="showFullCodeSection" class="full-code-section" @click.stop>
        <h3>📝 SaveMyName 完整代码</h3>
        <div class="full-code-container">{{ fullCode }}</div>
        <button class="view-full-code-btn" @click="hideFullCode" style="margin-top: 15px;">
          🔙 返回知识解释
        </button>
      </div>
    </div>

    <div v-else-if="currentDay === 3" class="day-3-content">
      <div class="content-layout">
        <div class="left-column">
          <div class="interaction-area">
            <h3>🎮 交互操作</h3>
            <div class="interaction-controls">
              <div class="input-group">
                <label for="candidate-input">候选人姓名/Candidate：</label>
                <input 
                  id="candidate-input"
                  v-model="inputCandidate" 
                  type="text" 
                  placeholder="请输入候选人姓名"
                  @click.stop
                >
              </div>
              <button @click.stop="handleAddCandidate">➕ 添加候选人/AddCandidate</button>
            </div>
          </div>

          <div v-if="day3Candidates.length > 0" class="candidates-list">
            <h4>🗳️ 候选人列表/Candidates</h4>
            <div v-for="candidate in day3Candidates" :key="candidate" class="candidate-item">
              <div class="candidate-info">
                <span class="candidate-name">{{ candidate }}</span>
                <span class="vote-count">{{ day3VoteCount[candidate] || 0 }} 票</span>
              </div>
              <button @click.stop="handleVoteCandidate(candidate)" class="vote-btn">🗳️ 投票/Vote</button>
            </div>
          </div>
        </div>

        <div v-if="showUnlockArea" class="right-column">
          <div class="hint-bubble">
            <h4>💡 交互提示</h4>
            <p>{{ hintText }}</p>
          </div>

          <div class="knowledge-unlock" @click.stop>
            <h4>🎉 恭喜解锁新知识！</h4>
            <span class="unlock-badge">{{ unlockBadge }}</span>
            <p>{{ unlockText }}</p>
            <div v-if="currentConceptCode" class="code-snippet">{{ currentConceptCode }}</div>
            <div class="concept-list">
              <div 
                v-for="conceptKey in unlockedConcepts" 
                :key="conceptKey"
                class="concept-badge"
                :class="{ active: activeConcept === conceptKey }"
                @click="showConceptExplanation(conceptKey)"
              >
                <span class="check-icon">✓</span>
                {{ conceptDefinitions[conceptKey]?.name }}
              </div>
            </div>
            <button v-if="allConceptsUnlocked" class="view-full-code-btn" @click="showFullCode">
              📖 查看完整代码
            </button>
          </div>
        </div>
      </div>

      <div v-if="showFullCodeSection" class="full-code-section" @click.stop>
        <h3>📝 VotingStation 完整代码</h3>
        <div class="full-code-container">{{ fullCode }}</div>
        <button class="view-full-code-btn" @click="hideFullCode" style="margin-top: 15px;">
          🔙 返回知识解释
        </button>
      </div>
    </div>

    <div v-else-if="currentDay === 4" class="day-4-content">
      <div class="content-layout">
        <div class="left-column">
          <div class="interaction-area">
            <h3>🎮 交互操作</h3>
            
            <div v-if="!day4Item" class="interaction-controls">
              <div class="input-group">
                <label for="item-input">拍卖物品名称/Item：</label>
                <input 
                  id="item-input"
                  v-model="inputItem" 
                  type="text" 
                  placeholder="请输入拍卖物品名称"
                  @click.stop
                >
              </div>
              <div class="input-group">
                <label for="bidding-time-input">拍卖时长（秒）/Duration：</label>
                <input 
                  id="bidding-time-input"
                  v-model="inputBiddingTime" 
                  type="number" 
                  min="10"
                  placeholder="60"
                  @click.stop
                >
              </div>
              <button @click.stop="handleInitializeAuction">🏗️ 初始化拍卖/InitializeAuction</button>
            </div>

            <div v-else class="auction-status">
              <div class="auction-info">
                <h4>📦 拍卖物品：{{ day4Item }}</h4>
                <p>👤 所有者：{{ day4Owner.slice(0, 8) }}...</p>
                <p>⏰ 结束时间：{{ formatTime(day4AuctionEndTime) }}</p>
                <p>🔴 状态：{{ day4Ended ? '已结束' : '进行中' }}</p>
              </div>


              <div v-if="!day4Ended" class="interaction-controls">
                <div class="input-group">
                  <label for="bid-amount-input">出价金额（ETH）/Bid Amount：</label>
                  <input 
                    id="bid-amount-input"
                    v-model="inputBidAmount" 
                    type="number" 
                    min="0"
                    step="0.1"
                    placeholder="0.1"
                    @click.stop
                  >
                </div>
                <div class="input-group">
                  <label for="bidder-address-input">竞拍者地址/Bidder Address：</label>
                  <input 
                    id="bidder-address-input"
                    v-model="inputBidderAddress" 
                    type="text" 
                    placeholder="0x..."
                    @click.stop
                  >
                </div>
                <button @click.stop="inputBidderAddress = '0x' + Math.random().toString(16).substr(2, 40)" class="small-btn" style="margin-bottom: 10px;">🎲 随机生成</button>
                <button @click.stop="handlePlaceBid">💰 出价/Bid</button>
                <button @click.stop="handleEndAuction" style="margin-top: 10px; background: #dc322f;">🛑 结束拍卖/EndAuction</button>
              </div>

              <div v-else class="winner-section">
                <button @click.stop="handleGetWinner">🏆 获取获胜者/GetWinner</button>
                <div v-if="showWinnerResult && winnerData" class="winner-result">
                  <h4>🎉 拍卖获胜者</h4>
                  <p>👤 地址：{{ winnerData.winner.slice(0, 12) }}...</p>
                  <p>💰 出价：{{ winnerData.bid }} ETH</p>
                </div>
              </div>
            </div>

            <div v-if="Object.keys(day4Bids).length > 0" class="bidders-list">
              <h4>💎 竞拍者列表/Bidders</h4>
              <div v-for="bidder in day4Bidders" :key="bidder" class="bidder-item">
                <span class="bidder-address">{{ bidder.slice(0, 10) }}...</span>
                <span class="bid-amount">{{ day4Bids[bidder] }} ETH</span>
              </div>
            </div>

            <div v-if="day4HighestBid > 0" class="highest-bid-info">
              <h4>🏆 当前最高出价</h4>
              <p>👤 竞拍者：{{ day4HighestBidder.slice(0, 10) }}...</p>
              <p>💰 金额：{{ day4HighestBid }} ETH</p>
            </div>
          </div>
        </div>

        <div v-if="showUnlockArea" class="right-column">
          <div class="hint-bubble" style="margin-bottom: 20px;">
            <h4>💡 交互提示</h4>
            <p>{{ hintText }}</p>
          </div>

          <div class="knowledge-unlock" @click.stop>
            <h4>🎉 恭喜解锁新知识！</h4>
            <span class="unlock-badge">{{ unlockBadge }}</span>
            <p>{{ unlockText }}</p>
            <div v-if="currentConceptCode" class="code-snippet">{{ currentConceptCode }}</div>
            <div class="concept-list">
              <div 
                v-for="conceptKey in unlockedConcepts" 
                :key="conceptKey"
                class="concept-badge"
                :class="{ active: activeConcept === conceptKey }"
                @click="showConceptExplanation(conceptKey)"
              >
                <span class="check-icon">✓</span>
                {{ conceptDefinitions[conceptKey]?.name }}
              </div>
            </div>
            <button v-if="allConceptsUnlocked" class="view-full-code-btn" @click="showFullCode">
              📖 查看完整代码
            </button>
          </div>
        </div>
      </div>

      <div v-if="showFullCodeSection" class="full-code-section" @click.stop>
        <h3>📝 AuctionHouse 完整代码</h3>
        <div class="full-code-container">{{ fullCode }}</div>
        <button class="view-full-code-btn" @click="hideFullCode" style="margin-top: 15px;">
          🔙 返回知识解释
        </button>
      </div>
    </div>

    <div v-else-if="currentDay === 5" class="day-5-content">
      <div class="content-layout">
        <div class="left-column">
          <div class="interaction-area">
            <h3>🎮 交互操作</h3>
            <div class="interaction-controls">
              <div class="function-block">
                <h4 class="block-title">💎 添加宝藏</h4>
                <code class="function-signature">函数：addTreasure(uint256 amount)</code>
                <div class="input-group">
                  <label for="treasure-input">添加宝藏数量/Amount：</label>
                  <input 
                    id="treasure-input"
                    v-model="inputTreasureAmount" 
                    type="number" 
                    placeholder="请输入数量"
                    @click.stop
                  >
                </div>
                <button @click.stop="handleAddTreasure">➕ 添加宝藏/AddTreasure</button>
              </div>
              
              <div class="function-block">
                <h4 class="block-title">✅ 批准提款</h4>
                <code class="function-signature">函数：approveWithdrawal(address recipient, uint256 amount)</code>
                <div class="input-group label-input-row">
                  <label for="recipient-input">用户地址/Recipient：</label>
                  <input 
                    id="recipient-input"
                    v-model="inputRecipient" 
                    type="text" 
                    placeholder="0x..."
                    @click.stop
                  >
                </div>
                <button @click.stop="inputRecipient = '0x' + Math.random().toString(16).substr(2, 40)" class="small-btn" style="margin-bottom: 10px;">🎲 随机生成</button>
                <div class="input-group">
                  <label for="allowance-input">提款额度/Allowance：</label>
                  <input 
                    id="allowance-input"
                    v-model="inputAllowance" 
                    type="number" 
                    placeholder="请输入额度"
                    @click.stop
                  >
                </div>
                <button @click.stop="handleApproveWithdrawal">✅ 批准提款/ApproveWithdrawal</button>
              </div>
              
              <div class="function-block">
                <h4 class="block-title">💰 提取宝藏</h4>
                <code class="function-signature">函数：withdrawTreasure(uint256 amount)</code>
                <div class="input-group">
                  <label for="withdraw-input">提取数量/Amount：</label>
                  <input 
                    id="withdraw-input"
                    v-model="inputWithdrawAmount" 
                    type="number" 
                    placeholder="请输入数量"
                    @click.stop
                  >
                </div>
                <button @click.stop="handleWithdrawTreasure">💰 提取宝藏/WithdrawTreasure</button>
                <button @click.stop="handleResetWithdrawalStatus">🔄 重置提款状态/ResetStatus</button>
                <code class="function-signature">函数：resetWithdrawalStatus(address user)</code>
              </div>
              
              <div class="function-block">
                <h4 class="block-title">🔐 转移所有权</h4>
                <code class="function-signature">函数：transferOwnership(address newOwner)</code>
                <div class="input-group label-input-row">
                  <label for="new-owner-input">新所有者地址/New Owner：</label>
                  <input 
                    id="new-owner-input"
                    v-model="inputNewOwner" 
                    type="text" 
                    placeholder="0x..."
                    @click.stop
                  >
                </div>
                <button @click.stop="inputNewOwner = '0x' + Math.random().toString(16).substr(2, 40)" class="small-btn">🎲 随机生成</button>
                <button @click.stop="handleTransferOwnership">🔐 转移所有权/TransferOwnership</button>
              </div>
              
              <div class="function-block query-block">
                <h4 class="block-title">📊 查询操作</h4>
                <code class="function-signature">函数：getTreasureDetails() returns (uint256)</code>
                <button @click.stop="handleGetTreasureDetails">📊 获取宝藏详情/GetDetails</button>
              </div>
            </div>
            <div class="result-display">
              <h4>🏆 宝库状态</h4>
              <div class="result-value">
                <div><strong>所有者/Owner：</strong>{{ day5Owner || '未初始化' }}</div>
                <div><strong>宝藏数量/Treasure：</strong>{{ day5TreasureAmount }}</div>
                <div><strong>当前用户地址/Your Address：</strong>{{ day5UserAddress }}</div>
                <div><strong>提款额度/Allowance：</strong>{{ day5UserAllowance || 0 }}</div>
                <div><strong>已提取/Withdrawn：</strong>{{ day5HasWithdrawn ? '是/Yes' : '否/No' }}</div>
              </div>
            </div>
          </div>
        </div>

        <div v-if="showUnlockArea" class="right-column">
          <div class="hint-bubble" style="margin-bottom: 20px;">
            <h4>💡 交互提示</h4>
            <p>{{ hintText }}</p>
          </div>

          <div class="knowledge-unlock" @click.stop>
            <h4>🎉 恭喜解锁新知识！</h4>
            <span class="unlock-badge">{{ unlockBadge }}</span>
            <p>{{ unlockText }}</p>
            <div v-if="currentConceptCode" class="code-snippet">{{ currentConceptCode }}</div>
            <div class="concept-list">
              <div 
                v-for="conceptKey in unlockedConcepts" 
                :key="conceptKey"
                class="concept-badge"
                :class="{ active: activeConcept === conceptKey }"
                @click="showConceptExplanation(conceptKey)"
              >
                <span class="check-icon">✓</span>
                {{ conceptDefinitions[conceptKey]?.name }}
              </div>
            </div>
            <button v-if="allConceptsUnlocked" class="view-full-code-btn" @click="showFullCode">
              📖 查看完整代码
            </button>
          </div>
        </div>
      </div>

      <div v-if="showFullCodeSection" class="full-code-section" @click.stop>
        <h3>📝 AdminOnly 完整代码</h3>
        <div class="full-code-container">{{ fullCode }}</div>
        <button class="view-full-code-btn" @click="hideFullCode" style="margin-top: 15px;">
          🔙 返回知识解释
        </button>
      </div>
    </div>

    <div v-else-if="currentDay === 6" class="day-6-content">
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
                <button @click.stop="inputMemberAddress = '0x' + Math.random().toString(16).substr(2, 40)" class="small-btn">🎲 随机生成</button>
                <button @click.stop="handleAddMembers">➕ 添加会员/AddMembers</button>
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
                <button @click.stop="handleDepositEther">💰 存入ETH/DepositEther</button>
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
                <button @click.stop="handleWithdrawEth">💸 提取ETH/WithdrawAmount</button>
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
                <button @click.stop="inputQueryBalance = day6UserAddress" class="small-btn">👤 使用我的地址</button>
                <button @click.stop="inputQueryBalance = '0x' + Math.random().toString(16).substr(2, 40)" class="small-btn" style="margin-bottom: 10px;">🎲 随机生成</button>
                <button @click.stop="handleGetBalance">📊 查询余额/GetBalance</button>
              </div>

              <div class="function-block query-block">
                <h4 class="block-title">📋 查询会员</h4>
                <code class="function-signature">函数：getMembers() returns (address[])</code>
                <button @click.stop="handleGetMembers">📋 获取会员列表/GetMembers</button>
              </div>
            </div>
            <div class="result-display">
              <h4>🏦 银行状态</h4>
              <div class="result-value">
                <div class="info-item"><strong>银行管理员/Bank Manager：</strong>{{ day6BankManager || '未初始化' }}</div>
                <div class="info-item"><strong>会员数量/Members Count：</strong>{{ day6Members.length }}</div>
                <div class="info-item"><strong>当前用户地址/Your Address：</strong>{{ day6UserAddress }}</div>
                <div class="info-item"><strong>您的余额/Your Balance：</strong>{{ formatWeiToEth(day6UserBalance) }} ETH ({{ day6UserBalance }} wei)</div>
                <div v-if="day6QueryBalance !== null"><strong>查询结果/Query Result：</strong>{{ formatWeiToEth(day6QueryBalance) }} ETH ({{ day6QueryBalance }} wei)</div>
                <div v-if="day6MembersList.length > 0" style="margin-top: 10px; padding-top: 10px; border-top: 1px solid #ddd;">
                  <strong>会员列表/Members List：</strong>
                  <div v-for="(member, index) in day6MembersList" :key="index" style="margin-left: 10px; font-size: 12px;">
                    {{ index + 1 }}. {{ member }}
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>

        <div v-if="showUnlockArea" class="right-column">
          <div class="hint-bubble" style="margin-bottom: 20px;">
            <h4>💡 交互提示</h4>
            <p>{{ hintText }}</p>
          </div>

          <div class="knowledge-unlock" @click.stop>
            <h4>🎉 恭喜解锁新知识！</h4>
            <span class="unlock-badge">{{ unlockBadge }}</span>
            <p>{{ unlockText }}</p>
            <div v-if="currentConceptCode" class="code-snippet">{{ currentConceptCode }}</div>
            <div class="concept-list">
              <div 
                v-for="conceptKey in unlockedConcepts" 
                :key="conceptKey"
                class="concept-badge"
                :class="{ active: activeConcept === conceptKey }"
                @click="showConceptExplanation(conceptKey)"
              >
                <span class="check-icon">✓</span>
                {{ conceptDefinitions[conceptKey]?.name }}
              </div>
            </div>
            <button v-if="allConceptsUnlocked" class="view-full-code-btn" @click="showFullCode">
              📖 查看完整代码
            </button>
          </div>
        </div>
      </div>

      <div v-if="showFullCodeSection" class="full-code-section" @click.stop>
        <h3>📝 EtherPiggyBank 完整代码</h3>
        <div class="full-code-container">{{ fullCode }}</div>
        <button class="view-full-code-btn" @click="hideFullCode" style="margin-top: 15px;">
          🔙 返回知识解释
        </button>
      </div>
    </div>

    <div v-else-if="currentDay === 7" class="day-7-content">
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
                <button @click.stop="inputFriendAddress = '0x' + Math.random().toString(16).substr(2, 40)" class="small-btn">🎲 随机生成</button>
                <button @click.stop="handleAddFriend">➕ 添加朋友/AddFriend</button>
              </div>

              <div class="function-block">
                <h4 class="block-title">💰 钱包存款</h4>
                <code class="function-signature">函数：depositIntoWallet() payable</code>
                <div class="input-group">
                  <label for="deposit-iou-input">存入数量(ETH)/Amount：</label>
                  <input 
                    id="deposit-iou-input"
                    v-model="inputDepositIOUAmount" 
                    type="number" 
                    placeholder="请输入数量"
                    min="0"
                    step="0.01"
                    @click.stop
                  >
                </div>
                <button @click.stop="handleDepositIOU">💰 存入ETH/Deposit</button>
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
                <button @click.stop="inputDebtorAddress = '0x' + Math.random().toString(16).substr(2, 40)" class="small-btn" style="margin-bottom: 10px;">🎲 随机生成</button>
                <div class="input-group mt-2">
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
                <button @click.stop="handleRecordDebt">📝 记录债务/RecordDebt</button>
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
                <button @click.stop="inputCreditorAddress = '0x' + Math.random().toString(16).substr(2, 40)" class="small-btn" style="margin-bottom: 10px;">🎲 随机生成</button>
                <div class="input-group mt-2">
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
                <button @click.stop="handlePayFromWallet">💳 钱包还债/PayDebt</button>
              </div>

              <div class="function-block">
                <h4 class="block-title">🔄 直接转账</h4>
                <div class="function-signature">函数：transferEther(address payable _to, uint256 _amount)<br/>函数：transferEtherViaCall(address payable _to, uint256 _amount)</div>
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
                <button @click.stop="inputTransferTo = '0x' + Math.random().toString(16).substr(2, 40)" class="small-btn" style="margin-bottom: 10px;">🎲 随机生成</button>
                <div class="input-group mt-2">
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
                <div class="button-group" style="margin-top: 10px;">
                  <button @click.stop="handleTransferMethod">📤 Transfer 转账</button>
                  <button @click.stop="handleCallMethod">📡 Call 低级调用转账</button>
                </div>
              </div>

              <div class="function-block query-block">
                <h4 class="block-title">📊 余额管理</h4>
                <div class="function-signature">函数：withdraw(uint256 _amount)<br/>函数：checkBalance() view returns (uint256)</div>
                <div class="input-group">
                  <label for="withdraw-iou-input">提现数量(ETH)/Amount：</label>
                  <input 
                    id="withdraw-iou-input"
                    v-model="inputWithdrawIOUAmount" 
                    type="number" 
                    placeholder="请输入提现金额"
                    min="0"
                    step="0.01"
                    @click.stop
                  >
                </div>
                <div class="button-group" style="margin-top: 10px;">
                  <button @click.stop="handleWithdrawIOU">🏧 提现/Withdraw</button>
                  <button @click.stop="handleCheckBalance">💰 查询余额/CheckBalance</button>
                </div>
                <div v-if="day7CheckedBalance !== null" style="margin-top: 10px; font-weight: bold; color: #6c71c4;">
                  查询结果：{{ formatWeiToEth(day7CheckedBalance) }} ETH
                </div>
              </div>

            </div>
            <div class="result-display day7-status">
              <h4 class="block-title">🤝 IOU 状态面板</h4>
              <div class="result-value">
                <div class="info-item"><strong>部署者(Owner)：</strong>{{ day7Owner.slice(0,12) || '未初始化' }}...</div>
                <div class="info-item"><strong>当前操作地址：</strong>{{ day7UserAddress.slice(0,12) }}...</div>
                <div class="info-item"><strong>钱包余额(内部)：</strong>{{ formatWeiToEth(day7UserBalance) }} ETH</div>
                <hr style="margin: 15px 0; border: 1px dashed #2aa198;" />
                
                <div v-if="day7FriendsList.length > 0" class="sub-section">
                  <strong>已注册朋友 ({{ day7FriendsList.length - 1 }}个)：</strong>
                  <div v-for="(friend, index) in day7FriendsList" :key="index" class="list-item">
                    {{ friend === day7Owner ? 'Owner(自身)' : friend.slice(0, 15) + '...' }}
                  </div>
                </div>

                <div v-if="Object.keys(day7Debts).length > 0" class="sub-section debts-section">
                  <strong>债务记录 (你欠谁)：</strong>
                  <div v-if="Object.keys(day7Debts[day7UserAddress] || {}).length === 0" class="list-item">无</div>
                  <div v-for="(amount, creditor) in day7Debts[day7UserAddress]" :key="creditor" class="list-item debt-item">
                     欠债权人: {{ creditor.slice(0, 10) }}... 金额: {{ formatWeiToEth(amount) }} ETH
                  </div>
                  
                  <strong style="margin-top: 5px; display: inline-block;">债权记录 (谁欠你)：</strong>
                  <div v-for="(creditorsDict, debtor) in day7Debts" :key="debtor">
                    <div v-if="creditorsDict[day7UserAddress] > 0" class="list-item credit-item">
                      债务人: {{ debtor.slice(0, 10) }}... 欠你: {{ formatWeiToEth(creditorsDict[day7UserAddress]) }} ETH
                    </div>
                  </div>
                </div>

              </div>
            </div>
          </div>
        </div>

        <div v-if="showUnlockArea" class="right-column">
          <div class="hint-bubble" style="margin-bottom: 20px; border-left-color: #2aa198;">
            <h4 style="color: #2aa198;">💡 交互提示</h4>
            <p>{{ hintText }}</p>
          </div>

          <div class="knowledge-unlock" style="background: #fdf6e3; border: 2px solid #d3cbb8; border-radius: 10px;" @click.stop>
            <h4 style="color: #2aa198; border-bottom: 0px;">🎉 恭喜解锁新知识！</h4>
            <span class="unlock-badge">{{ unlockBadge }}</span>
            <p>{{ unlockText }}</p>
            <div v-if="currentConceptCode" class="code-snippet">{{ currentConceptCode }}</div>
            <div class="concept-list">
              <div 
                v-for="conceptKey in unlockedConcepts" 
                :key="conceptKey"
                class="concept-badge day7-badge"
                :class="{ active: activeConcept === conceptKey }"
                @click="showConceptExplanation(conceptKey)"
              >
                <span class="check-icon">✓</span>
                {{ conceptDefinitions[conceptKey]?.name }}
              </div>
            </div>
            <button v-if="allConceptsUnlocked" class="view-full-code-btn day7-btn" @click="showFullCode">
              📖 查看完整代码
            </button>
          </div>
        </div>
      </div>

      <div v-if="showFullCodeSection" class="full-code-section" @click.stop>
        <h3 style="color: #6c71c4;">📝 SimpleIOU 完整代码</h3>
        <div class="full-code-container">{{ fullCode }}</div>
        <button class="view-full-code-btn day7-btn" @click="hideFullCode" style="margin-top: 15px;">
          🔙 返回知识解释
        </button>
      </div>
    </div>

    <div v-else class="placeholder-content">
      <div class="icon">🚧</div>
      <h3>内容开发中...</h3>
      <p>{{ dayTitle }} 的内容将在后续开发中完成</p>
    </div>
  </div>
</template>

<script setup>
import { ref, computed, watch, nextTick } from 'vue'
import { dayConfigs, getFullCode } from '../data/days'
import { conceptDefinitions, gasEstimates, ethPricePerGwei, getHint, getConceptExplanationHint } from '../data/concepts'

const props = defineProps({
  currentDay: {
    type: Number,
    required: true
  },
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
  day2Name: {
    type: String,
    default: ''
  },
  day2Bio: {
    type: String,
    default: ''
  },
  day2InteractionCount: {
    type: Number,
    default: 0
  },
  day2HasStored: {
    type: Boolean,
    default: false
  },
  day2HasRetrieved: {
    type: Boolean,
    default: false
  },
  day3Candidates: {
    type: Array,
    default: () => []
  },
  day3VoteCount: {
    type: Object,
    default: () => ({})
  },
  day3InteractionCount: {
    type: Number,
    default: 0
  },
  day4Owner: {
    type: String,
    default: ''
  },
  day4Item: {
    type: String,
    default: ''
  },
  day4AuctionEndTime: {
    type: Number,
    default: 0
  },
  day4HighestBidder: {
    type: String,
    default: ''
  },
  day4HighestBid: {
    type: Number,
    default: 0
  },
  day4Ended: {
    type: Boolean,
    default: false
  },
  day4Bids: {
    type: Object,
    default: () => ({})
  },
  day4Bidders: {
    type: Array,
    default: () => []
  },
  day4InteractionCount: {
    type: Number,
    default: 0
  },
  day5Owner: {
    type: String,
    default: ''
  },
  day5TreasureAmount: {
    type: Number,
    default: 0
  },
  day5UserAddress: {
    type: String,
    default: ''
  },
  day5UserAllowance: {
    type: Number,
    default: 0
  },
  day5HasWithdrawn: {
    type: Boolean,
    default: false
  },
  day5InteractionCount: {
    type: Number,
    default: 0
  },
  day6BankManager: {
    type: String,
    default: ''
  },
  day6Members: {
    type: Array,
    default: () => []
  },
  day6UserAddress: {
    type: String,
    default: ''
  },
  day6UserBalance: {
    type: Number,
    default: 0
  },
  day6InteractionCount: {
    type: Number,
    default: 0
  },
  day6QueryBalance: {
    type: Number,
    default: null
  },
  day6MembersList: {
    type: Array,
    default: () => []
  },
  day7Owner: { type: String, default: '' },
  day7UserAddress: { type: String, default: '' },
  day7FriendsList: { type: Array, default: () => [] },
  day7UserBalance: { type: Number, default: 0 },
  day7CheckedBalance: { type: Number, default: null },
  day7Debts: { type: Object, default: () => ({}) },
  day7InteractionCount: { type: Number, default: 0 }
})

const emit = defineEmits([
  'click-counter', 'reset-counter', 'store-data', 'retrieve-data', 'add-candidate', 'vote-candidate', 
  'initialize-auction', 'place-bid', 'end-auction', 'get-winner', 'close-sidebars', 
  'add-treasure', 'approve-withdrawal', 'withdraw-treasure', 'reset-withdrawal-status', 'transfer-ownership', 'get-treasure-details', 
  'add-members', 'deposit-ether', 'withdraw-eth', 'get-balance', 'get-members',
  'add-friend', 'deposit-iou', 'record-debt', 'pay-from-wallet', 'transfer-method', 'call-method', 'withdraw-iou', 'check-balance'
])

const hintText = ref('试试看！点击按钮，看看会发生什么 👆')
const showUnlockArea = ref(false)
const unlockBadge = ref('新概念')
const unlockText = ref('你刚刚学到了一个新的概念！')
const currentConceptCode = ref('')
const activeConcept = ref(null)
const showFullCodeSection = ref(false)
const fullCode = ref('')

const inputName = ref('')
const inputBio = ref('')
const inputSearch = ref('')
const showStoredData = ref(false)
const showSearchResult = ref(false)
const searchResult = ref({ found: false, name: '', bio: '' })

const inputCandidate = ref('')

const inputItem = ref('')
const inputBiddingTime = ref(60)
const inputBidAmount = ref(0)
const inputBidderAddress = ref('')
const showWinnerResult = ref(false)
const winnerData = ref(null)

const inputTreasureAmount = ref('')
const inputRecipient = ref('')
const inputAllowance = ref('')
const inputWithdrawAmount = ref('')
const inputNewOwner = ref('')

const inputMemberAddress = ref('')
const inputDepositAmount = ref('')
const inputWithdrawEthAmount = ref('')
const inputQueryBalance = ref('')

const inputFriendAddress = ref('')
const inputDepositIOUAmount = ref('')
const inputDebtorAddress = ref('')
const inputDebtAmount = ref('')
const inputCreditorAddress = ref('')
const inputPayAmount = ref('')
const inputTransferTo = ref('')
const inputTransferAmount = ref('')
const inputWithdrawIOUAmount = ref('')

const dayTitle = computed(() => {
  return dayConfigs[props.currentDay]?.title || `Day ${props.currentDay}`
})

const progressPercentage = computed(() => {
  const currentProgress = props.dayProgress[props.currentDay]
  if (!currentProgress || currentProgress.totalConcepts === 0) return 0
  return Math.floor((currentProgress.unlockedConcepts.length / currentProgress.totalConcepts) * 100)
})

const unlockedConcepts = computed(() => {
  const currentProgress = props.dayProgress[props.currentDay]
  return currentProgress?.unlockedConcepts || []
})

const allConceptsUnlocked = computed(() => {
  const currentProgress = props.dayProgress[props.currentDay]
  if (!currentProgress) return false
  return unlockedConcepts.value.length === currentProgress.totalConcepts
})

const handleClickCounter = () => {
  emit('click-counter')
  
  const currentProgress = props.dayProgress[props.currentDay]
  if (!currentProgress) return
  
  const prevLength = currentProgress.unlockedConcepts.length
  
  nextTick(() => {
    const newLength = currentProgress.unlockedConcepts.length
    if (newLength > prevLength) {
      const newConcept = currentProgress.unlockedConcepts[newLength - 1]
      unlockConcept(newConcept)
    }
    updateHintText()
  })
}

const handleStoreData = () => {
  if (!inputName.value.trim() && !inputBio.value.trim()) {
    hintText.value = '⚠️ 请先输入姓名或简介再存储数据！'
    return
  }
  
  emit('store-data', inputName.value, inputBio.value)
  showStoredData.value = true
  updateHintText()
}

const handleRetrieveData = () => {
  const searchTerm = inputSearch.value.trim().toLowerCase()
  
  if (!searchTerm) {
    searchResult.value = { found: false, name: '', bio: '' }
    showSearchResult.value = true
    hintText.value = '⚠️ 请先输入搜索关键词！'
    return
  }
  
  const storedName = props.day2Name?.toLowerCase() || ''
  const storedBio = props.day2Bio?.toLowerCase() || ''
  
  if (storedName.includes(searchTerm) || storedBio.includes(searchTerm)) {
    searchResult.value = {
      found: true,
      name: props.day2Name || '',
      bio: props.day2Bio || ''
    }
    hintText.value = `✅ 找到匹配数据：${props.day2Name}`
  } else {
    searchResult.value = { found: false, name: '', bio: '' }
    hintText.value = '❌ 没有找到匹配的数据'
  }
  
  showSearchResult.value = true
  emit('retrieve-data')
  updateHintText()
}

const handleAddCandidate = () => {
  if (!inputCandidate.value.trim()) {
    hintText.value = '⚠️ 请先输入候选人姓名！'
    return
  }
  
  emit('add-candidate', inputCandidate.value)
  inputCandidate.value = ''
  updateHintText()
}

const handleVoteCandidate = (candidateName) => {
  emit('vote-candidate', candidateName)
  updateHintText()
}

const handleInitializeAuction = () => {
  if (!inputItem.value.trim()) {
    hintText.value = '⚠️ 请先输入拍卖物品名称！'
    return
  }
  
  emit('initialize-auction', inputItem.value, parseInt(inputBiddingTime.value))
  inputItem.value = ''
  inputBiddingTime.value = 60
  updateHintText()
}

const handlePlaceBid = () => {
  if (!inputBidderAddress.value.trim() || !inputBidderAddress.value.startsWith('0x')) {
    hintText.value = '⚠️ 请先输入有效的竞拍者地址！'
    return
  }
  
  if (inputBidAmount.value <= 0) {
    hintText.value = '⚠️ 出价金额必须大于0！'
    return
  }
  
  emit('place-bid', parseFloat(inputBidAmount.value), inputBidderAddress.value)
  inputBidAmount.value = 0
  inputBidderAddress.value = ''
  updateHintText()
}

const handleEndAuction = () => {
  emit('end-auction')
  updateHintText()
}

const handleGetWinner = () => {
  emit('get-winner')
  showWinnerResult.value = true
  winnerData.value = {
    winner: props.day4HighestBidder,
    bid: props.day4HighestBid
  }
  updateHintText()
}

const handleAddTreasure = () => {
  emit('add-treasure', Number(inputTreasureAmount.value))
  inputTreasureAmount.value = ''
  updateHintText()
}

const handleApproveWithdrawal = () => {
  emit('approve-withdrawal', inputRecipient.value, Number(inputAllowance.value))
  inputRecipient.value = ''
  inputAllowance.value = ''
  updateHintText()
}

const handleWithdrawTreasure = () => {
  emit('withdraw-treasure', props.day5UserAddress, Number(inputWithdrawAmount.value))
  inputWithdrawAmount.value = ''
  updateHintText()
}

const handleResetWithdrawalStatus = () => {
  emit('reset-withdrawal-status', props.day5UserAddress)
  updateHintText()
}

const handleTransferOwnership = () => {
  emit('transfer-ownership', inputNewOwner.value)
  inputNewOwner.value = ''
  updateHintText()
}

const handleGetTreasureDetails = () => {
  const treasureAmount = props.day5TreasureAmount
  alert(`📊 宝藏详情\n\n当前宝藏数量: ${treasureAmount}`)
  updateHintText()
}

const formatTime = (timestamp) => {
  const date = new Date(timestamp * 1000)
  return date.toLocaleString('zh-CN')
}

const updateHintText = () => {
  const currentProgress = props.dayProgress[props.currentDay]
  if (!currentProgress) return

  const totalConcepts = currentProgress.totalConcepts
  const unlockedCount = currentProgress.unlockedConcepts.length
  const remaining = totalConcepts - unlockedCount

  if (remaining > 0) {
    let operationHint = ''
    if (props.currentDay === 1) {
      if (unlockedCount === 0) {
        operationHint = '点击计数'
      } else if (unlockedCount === 1) {
        operationHint = '再次点击计数'
      } else if (unlockedCount === 2) {
        operationHint = '再次点击计数'
      } else if (unlockedCount === 3) {
        operationHint = '再次点击计数'
      }
    } else if (props.currentDay === 2) {
      if (unlockedCount === 0) {
        operationHint = '存储数据'
      } else if (unlockedCount === 1) {
        operationHint = '再次存储数据'
      } else if (unlockedCount === 2) {
        operationHint = '再次存储数据'
      } else if (unlockedCount === 3) {
        operationHint = '输入关键词并检索数据'
      } else if (unlockedCount === 4) {
        operationHint = '用不同关键词检索数据'
      } else if (unlockedCount === 5) {
        operationHint = '用不同关键词检索数据'
      }
    } else if (props.currentDay === 3) {
      if (unlockedCount === 0) {
        operationHint = '添加第1个候选人'
      } else if (unlockedCount === 1) {
        operationHint = '添加第2个候选人'
      } else if (unlockedCount === 2) {
        operationHint = '添加第3个候选人'
      } else if (unlockedCount === 3) {
        operationHint = '进行投票'
      }
    } else if (props.currentDay === 4) {
      if (unlockedCount === 0) {
        operationHint = '初始化拍卖'
      } else if (unlockedCount === 1) {
        operationHint = '第1次出价'
      } else if (unlockedCount === 2) {
        operationHint = '第2次出价'
      } else if (unlockedCount === 3) {
        operationHint = '第3次出价'
      } else if (unlockedCount === 4) {
        operationHint = '第4次出价'
      } else if (unlockedCount === 5) {
        operationHint = '等待拍卖结束后点击"结束拍卖"'
      } else if (unlockedCount === 6) {
        operationHint = '点击"获取获胜者"'
      }
    } else if (props.currentDay === 5) {
      if (unlockedCount === 0) {
        operationHint = '添加宝藏'
      } else if (unlockedCount === 1) {
        operationHint = '批准提款'
      } else if (unlockedCount === 2) {
        operationHint = '提取宝藏或转移所有权'
      }
    } else if (props.currentDay === 6) {
      if (unlockedCount === 0) {
        operationHint = '添加会员'
      } else if (unlockedCount === 1) {
        operationHint = '存入以太币'
      } else if (unlockedCount === 3) {
        operationHint = '提取以太币'
      } else if (unlockedCount === 5) {
        operationHint = '查看完整代码'
      } else {
        operationHint = '继续交互解锁剩余概念'
      }
    } else if (props.currentDay === 7) {
      if (unlockedCount === 0) {
        operationHint = '添加朋友'
      } else if (unlockedCount === 1) {
        operationHint = '存入ETH'
      } else if (unlockedCount === 2) {
        operationHint = '记录债务'
      } else if (unlockedCount === 3) {
        operationHint = '钱包内部还债'
      } else if (unlockedCount === 4) {
        operationHint = 'Transfer转账'
      } else if (unlockedCount === 5) {
        operationHint = 'Call转账'
      } else if (unlockedCount === 6) {
        operationHint = '提现余额'
      }
    } else {
      operationHint = '继续进行交互操作'
    }
    hintText.value = `✅ 操作成功！你已解锁 ${unlockedCount}/${totalConcepts} 个概念，${operationHint}解锁剩余的 ${remaining} 个概念，然后就能查看完整代码了！`
  } else {
    hintText.value = `🎉 恭喜！所有 ${totalConcepts} 个概念已全部解锁！点击下方"查看完整代码"按钮查看完整合约代码。`
  }
}

const unlockConcept = (conceptKey) => {
  const concept = conceptDefinitions[conceptKey]
  if (!concept) return

  showUnlockArea.value = true
  unlockBadge.value = `✨ 解锁：${concept.name}`
  unlockText.value = concept.message
  currentConceptCode.value = concept.code || ''
  activeConcept.value = conceptKey
}

const showConceptExplanation = (conceptKey) => {
  const concept = conceptDefinitions[conceptKey]
  if (!concept) return

  activeConcept.value = conceptKey
  unlockBadge.value = `📚 ${concept.name}`
  unlockText.value = concept.message
  currentConceptCode.value = concept.code || ''
  hintText.value = getConceptExplanationHint(conceptKey)
}

const showFullCode = () => {
  fullCode.value = getFullCode(props.currentDay)
  showFullCodeSection.value = true
  nextTick(() => {
    const element = document.querySelector('.full-code-section')
    if (element) {
      element.scrollIntoView({ behavior: 'smooth', block: 'nearest' })
    }
  })
}

const hideFullCode = () => {
  showFullCodeSection.value = false
}

watch(() => props.currentDay, () => {
  showSearchResult.value = false
  searchResult.value = { found: false, name: '', bio: '' }
  
  if (props.currentDay === 1) {
    const currentProgress = props.dayProgress[1]
    if (currentProgress) {
      const remaining = currentProgress.totalConcepts - currentProgress.unlockedConcepts.length
      if (remaining > 0) {
        let nextAction = ''
        if (currentProgress.unlockedConcepts.length === 0) {
          nextAction = '点击计数'
        } else if (currentProgress.unlockedConcepts.length === 1) {
          nextAction = '再次点击计数'
        } else if (currentProgress.unlockedConcepts.length === 2) {
          nextAction = '再次点击计数'
        } else if (currentProgress.unlockedConcepts.length === 3) {
          nextAction = '再次点击计数'
        }
        hintText.value = `🎯 ${nextAction}！已解锁 ${currentProgress.unlockedConcepts.length}/${currentProgress.totalConcepts} 个概念，继续交互解锁剩余的 ${remaining} 个概念，然后就能查看完整代码了！`
      } else {
        hintText.value = `🎉 恭喜！所有 ${currentProgress.totalConcepts} 个概念已全部解锁！点击下方"查看完整代码"按钮查看完整合约代码。`
      }
    } else {
      hintText.value = '🎯 点击"点击计数"按钮开始交互！'
    }
  } else if (props.currentDay === 2) {
    const currentProgress = props.dayProgress[2]
    if (currentProgress) {
      const remaining = currentProgress.totalConcepts - currentProgress.unlockedConcepts.length
      if (remaining > 0) {
        let nextAction = ''
        if (currentProgress.unlockedConcepts.length === 0) {
          nextAction = '存储数据'
        } else if (currentProgress.unlockedConcepts.length === 1) {
          nextAction = '再次存储数据'
        } else if (currentProgress.unlockedConcepts.length === 2) {
          nextAction = '再次存储数据'
        } else if (currentProgress.unlockedConcepts.length === 3) {
          nextAction = '检索数据'
        } else if (currentProgress.unlockedConcepts.length === 4) {
          nextAction = '再次检索数据'
        } else if (currentProgress.unlockedConcepts.length === 5) {
          nextAction = '再次检索数据'
        }
        hintText.value = `🎯 ${nextAction}！已解锁 ${currentProgress.unlockedConcepts.length}/${currentProgress.totalConcepts} 个概念，继续交互解锁剩余的 ${remaining} 个概念，然后就能查看完整代码了！`
      } else {
        hintText.value = `🎉 恭喜！所有 ${currentProgress.totalConcepts} 个概念已全部解锁！点击下方"查看完整代码"按钮查看完整合约代码。`
      }
    } else {
      hintText.value = '🎯 输入姓名和简介后点击"存储数据"！之后可以在搜索框输入关键词进行检索！'
    }
  } else if (props.currentDay === 3) {
    const currentProgress = props.dayProgress[3]
    if (currentProgress) {
      const remaining = currentProgress.totalConcepts - currentProgress.unlockedConcepts.length
      if (remaining > 0) {
        let nextAction = ''
        if (currentProgress.unlockedConcepts.length === 0) {
          nextAction = '添加第1个候选人'
        } else if (currentProgress.unlockedConcepts.length === 1) {
          nextAction = '添加第2个候选人'
        } else if (currentProgress.unlockedConcepts.length === 2) {
          nextAction = '添加第3个候选人'
        } else if (currentProgress.unlockedConcepts.length === 3) {
          nextAction = '进行投票'
        }
        hintText.value = `🎯 ${nextAction}！已解锁 ${currentProgress.unlockedConcepts.length}/${currentProgress.totalConcepts} 个概念，继续交互解锁剩余的 ${remaining} 个概念，然后就能查看完整代码了！`
      } else {
        hintText.value = `🎉 恭喜！所有 ${currentProgress.totalConcepts} 个概念已全部解锁！点击下方"查看完整代码"按钮查看完整合约代码。`
      }
    } else {
      hintText.value = '🎯 输入候选人姓名后点击"添加候选人"！'
    }
  } else if (props.currentDay === 5) {
    const currentProgress = props.dayProgress[5]
    if (currentProgress) {
      const unlockedConcepts = currentProgress.unlockedConcepts || []
      const totalConcepts = currentProgress.totalConcepts
      const remaining = totalConcepts - unlockedConcepts.length
      
      if (remaining > 0) {
        if (unlockedConcepts.length === 0) {
          hintText.value = '🎯 输入宝藏数量后点击"添加宝藏/Add Treasure"按钮，为宝库添加初始宝藏资金！'
        } else if (unlockedConcepts.length === 1) {
          hintText.value = '🎯 输入提款人地址和额度后点击"批准提款/Approve Withdrawal"按钮，授权用户提取指定数量的宝藏！'
        } else if (unlockedConcepts.length === 2) {
          hintText.value = '🎯 选择操作：1) 点击"提取宝藏/Withdraw Treasure"使用已授权的额度提取宝藏，或 2) 输入非零地址后点击"转移所有权/Transfer Ownership"转移管理员权限！'
        }
      } else {
        hintText.value = '🎉 恭喜！所有 3 个概念已全部解锁！点击下方"查看完整代码/View Full Code"按钮查看完整合约代码。'
      }
    } else {
      hintText.value = '🎯 输入宝藏数量后点击"添加宝藏/Add Treasure"按钮！'
    }
  } else if (props.currentDay === 6) {
    const currentProgress = props.dayProgress[6]
    if (currentProgress) {
      const unlockedConcepts = currentProgress.unlockedConcepts || []
      const totalConcepts = currentProgress.totalConcepts
      const remaining = totalConcepts - unlockedConcepts.length
      
      if (remaining > 0) {
        if (unlockedConcepts.length === 0) {
          hintText.value = '🎯 输入会员地址后点击"添加会员/Add Members"按钮，为银行添加新会员！只有银行管理员可以执行此操作。'
        } else if (unlockedConcepts.length === 1) {
          hintText.value = '🎯 输入存入数量(ETH)后点击"存入ETH/Deposit Ether"按钮，向您的账户存入以太币！'
        } else if (unlockedConcepts.length === 2) {
          hintText.value = '🎯 输入提取数量(ETH)后点击"提取ETH/Withdraw Amount"按钮，从您的账户提取以太币！'
        } else if (unlockedConcepts.length === 3) {
          hintText.value = '🎯 输入查询地址后点击"查询余额/Get Balance"按钮，查询指定地址的账户余额！'
        } else if (unlockedConcepts.length === 4) {
          hintText.value = '🎯 点击"获取会员列表/Get Members"按钮，查看所有已注册会员的地址列表！'
        }
      } else {
        hintText.value = '🎉 恭喜！所有 5 个概念已全部解锁！点击下方"查看完整代码/View Full Code"按钮查看完整合约代码。'
      }
    } else {
      hintText.value = '🎯 输入会员地址后点击"添加会员/Add Members"按钮！'
    }
  } else if (props.currentDay === 7) {
    const currentProgress = props.dayProgress[7]
    if (currentProgress) {
      const unlockedConcepts = currentProgress.unlockedConcepts || []
      const totalConcepts = currentProgress.totalConcepts
      const remaining = totalConcepts - unlockedConcepts.length
      
      if (remaining > 0) {
         if (unlockedConcepts.length === 0) {
           hintText.value = '🎯 输入朋友地址后点击"添加朋友"，体验复杂的嵌套映射！'
         } else if (unlockedConcepts.length === 1) {
           hintText.value = '🎯 充值一点ETH进入你的钱包余额吧！'
         } else if (unlockedConcepts.length === 2) {
           hintText.value = '🎯 输入其他人的地址作为债务人，并记录欠款！'
         } else if (unlockedConcepts.length === 3) {
           hintText.value = '🎯 作为债务人，给你的债权人偿还债务，体验只需更新状态的"内部转账"！'
         } else if (unlockedConcepts.length === 4) {
           hintText.value = '🎯 尝试用 .transfer() 向朋友发送真实的以太币！'
         } else if (unlockedConcepts.length === 5) {
           hintText.value = '🎯 尝试用 .call() 发起低级别的推荐转账方式！'
         } else if (unlockedConcepts.length === 6) {
           hintText.value = '🎯 安全第一！现在提取你的余额离开合约，体验提现设计模式！'
         }
      } else {
        hintText.value = '🎉 恭喜！所有 7 个概念已全部解锁！点击下方"查看完整代码"按钮查看完整合约代码。'
      }
    } else {
      hintText.value = '🎯 点击"添加朋友"开启 Day 7 互动！'
    }
  }
  showFullCodeSection.value = false
  showStoredData.value = false
  inputName.value = ''
  inputBio.value = ''
  inputCandidate.value = ''
  const currentProgress = props.dayProgress[props.currentDay]
  showUnlockArea.value = currentProgress?.unlockedConcepts.length > 0
  
  if (showUnlockArea.value) {
    const lastUnlocked = currentProgress.unlockedConcepts[currentProgress.unlockedConcepts.length - 1]
    unlockBadge.value = `已解锁 ${currentProgress.unlockedConcepts.length} 个概念`
    unlockText.value = '你已经解锁了这些概念，继续交互解锁更多！'
    activeConcept.value = lastUnlocked
    currentConceptCode.value = conceptDefinitions[lastUnlocked]?.code || ''
  }
})

watch(() => props.dayProgress, (newProgress) => {
  const currentProgress = newProgress[props.currentDay]
  
  if (currentProgress) {
    if (currentProgress.unlockedConcepts.length > 0) {
      showUnlockArea.value = true
      
      const lastUnlocked = currentProgress.unlockedConcepts[currentProgress.unlockedConcepts.length - 1]
      const concept = conceptDefinitions[lastUnlocked]
      
      if (concept) {
        unlockBadge.value = `✨ 解锁：${concept.name}`
        unlockText.value = concept.message
        currentConceptCode.value = concept.code || ''
        activeConcept.value = lastUnlocked
      }
      updateHintText()
    }
  }
}, { deep: true })

watch(() => [props.day2Name, props.day2Bio], () => {
  if (props.currentDay === 2 && (props.day2Name || props.day2Bio)) {
    showStoredData.value = true
  }
}, { deep: true })

const formatWeiToEth = (wei) => {
  if (wei === null || wei === undefined || wei === '') return '0'
  return (wei / 1e18).toFixed(6)
}

const handleAddMembers = () => {
  if (!inputMemberAddress.value) {
    hintText.value = '❌ 请输入会员地址！'
    return
  }
  if (!inputMemberAddress.value.startsWith('0x')) {
    hintText.value = '❌ 请输入有效的以太坊地址（以0x开头）！'
    return
  }
  emit('add-members', inputMemberAddress.value)
  inputMemberAddress.value = ''
}

const handleDepositEther = () => {
  if (!inputDepositAmount.value || inputDepositAmount.value <= 0) {
    hintText.value = '❌ 请输入有效的存入数量（大于0）！'
    return
  }
  emit('deposit-ether', parseFloat(inputDepositAmount.value))
  inputDepositAmount.value = ''
}

const handleWithdrawEth = () => {
  if (!inputWithdrawEthAmount.value || inputWithdrawEthAmount.value <= 0) {
    hintText.value = '❌ 请输入有效的提取数量（大于0）！'
    return
  }
  emit('withdraw-eth', parseFloat(inputWithdrawEthAmount.value))
  inputWithdrawEthAmount.value = ''
}

const handleGetBalance = () => {
  if (!inputQueryBalance.value) {
    hintText.value = '❌ 请输入查询地址！'
    return
  }
  if (!inputQueryBalance.value.startsWith('0x') || inputQueryBalance.value.length !== 42) {
    hintText.value = '❌ 请输入有效的以太坊地址（42位，以0x开头）！'
    return
  }
  emit('get-balance', inputQueryBalance.value)
}

const handleGetMembers = () => {
  emit('get-members')
}

// ============== Day 7 Handlers ==============
const handleAddFriend = () => {
  if (!inputFriendAddress.value || !inputFriendAddress.value.startsWith('0x')) {
    hintText.value = '❌ 请输入有效的以太坊朋友地址！'
    return
  }
  emit('add-friend', inputFriendAddress.value)
  inputFriendAddress.value = ''
}

const handleDepositIOU = () => {
  if (!inputDepositIOUAmount.value || inputDepositIOUAmount.value <= 0) {
    hintText.value = '❌ 请输入有效的存入数量！'
    return
  }
  emit('deposit-iou', parseFloat(inputDepositIOUAmount.value))
  inputDepositIOUAmount.value = ''
}

const handleRecordDebt = () => {
  if (!inputDebtorAddress.value || !inputDebtAmount.value || inputDebtAmount.value <= 0) {
    hintText.value = '❌ 请填写完整的债务人地址和金额！'
    return
  }
  emit('record-debt', inputDebtorAddress.value, parseFloat(inputDebtAmount.value))
  inputDebtorAddress.value = ''
  inputDebtAmount.value = ''
}

const handlePayFromWallet = () => {
  if (!inputCreditorAddress.value || !inputPayAmount.value || inputPayAmount.value <= 0) {
    hintText.value = '❌ 请填写完整的债权人地址和还款金额！'
    return
  }
  const amountWei = parseFloat(inputPayAmount.value) * 1e18
  if (props.day7UserBalance < amountWei) {
    hintText.value = '❌ 余额不足：你的钱包可用余额小于还款金额！'
    return
  }
  emit('pay-from-wallet', inputCreditorAddress.value, parseFloat(inputPayAmount.value))
  inputCreditorAddress.value = ''
  inputPayAmount.value = ''
}

const handleTransferMethod = () => {
  if (!inputTransferTo.value || !inputTransferAmount.value || inputTransferAmount.value <= 0) {
    hintText.value = '❌ 请填写接收者地址和金额！'
    return
  }
  const amountWei = parseFloat(inputTransferAmount.value) * 1e18
  if (props.day7UserBalance < amountWei) {
    hintText.value = '❌ 余额不足：试图转账的金额超过了你拥有的钱包余额！'
    return
  }
  emit('transfer-method', inputTransferTo.value, parseFloat(inputTransferAmount.value))
  inputTransferTo.value = ''
  inputTransferAmount.value = ''
}

const handleCallMethod = () => {
  if (!inputTransferTo.value || !inputTransferAmount.value || inputTransferAmount.value <= 0) {
    hintText.value = '❌ 请填写接收者地址和金额！'
    return
  }
  const amountWei = parseFloat(inputTransferAmount.value) * 1e18
  if (props.day7UserBalance < amountWei) {
    hintText.value = '❌ 余额不足：低级调用失败，因为你的钱包没有足够的以太币！'
    return
  }
  emit('call-method', inputTransferTo.value, parseFloat(inputTransferAmount.value))
  inputTransferTo.value = ''
  inputTransferAmount.value = ''
}

const handleWithdrawIOU = () => {
  if (!inputWithdrawIOUAmount.value || inputWithdrawIOUAmount.value <= 0) {
    hintText.value = '❌ 请输入提现数量！'
    return
  }
  const amountWei = parseFloat(inputWithdrawIOUAmount.value) * 1e18
  if (props.day7UserBalance < amountWei) {
    hintText.value = '❌ 余额不足：你无法提取超过拥有额度的资金！'
    return
  }
  emit('withdraw-iou', parseFloat(inputWithdrawIOUAmount.value))
  inputWithdrawIOUAmount.value = ''
}

const handleCheckBalance = () => {
  emit('check-balance')
}
</script>

<style scoped>
.mt-2 {
  margin-top: 10px;
}
.day7-status .info-item {
  color: #6c71c4;
  margin-bottom: 5px;
  font-size: 0.85em;
}
.day7-status .sub-section {
  margin-top: 10px;
  padding-top: 10px;
  border-top: 1px dashed #6c71c4;
  font-size: 0.8em;
}
.list-item {
  margin-left: 10px;
  color: #586e75;
}
.debt-item {
  color: #dc322f;
}
.credit-item {
  color: #859900;
}
.day7-badge {
  background: #6c71c4;
  border-color: #6c71c4;
}
.day7-badge:hover {
  background: #5a5eb9;
  border-color: #5a5eb9;
  box-shadow: 0 4px 12px rgba(108, 113, 196, 0.4);
}
.concept-badge.day7-badge.active {
  border: 2px solid #5a5eb9;
  background: #5a5eb9;
  box-shadow: 0 4px 15px rgba(108, 113, 196, 0.5);
}
.day7-btn {
  background: #6c71c4;
}
.day7-btn:hover {
  background: #5a5eb9;
  box-shadow: 0 4px 12px rgba(108, 113, 196, 0.4);
}
</style>

<style>
/* 与 day6 保持一致的恭喜解锁样式覆盖 */
.day6-hint-style.success-hint {
  background-color: #fdf6e3;
  border-left: 4px solid #859900;
  color: #586e75;
}
</style>
