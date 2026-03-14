# Solidity学习互动演示GUI开发工作流程 Skill

## 项目概述

这是一个基于Vue 3的Solidity学习互动演示GUI，从0到1完整开发的教学界面。

## 核心架构

### 技术栈
- **前端框架**: Vue 3 (Composition API)
- **构建工具**: Vite
- **样式**: CSS3 (Flexbox布局)
- **语言**: JavaScript

### 目录结构
```
GUI/
├── src/
│   ├── components/
│   │   ├── AppHeader.vue       # 头部组件
│   │   ├── DayContent.vue      # 日程内容核心组件
│   │   ├── DayNavigation.vue   # 日程导航组件
│   │   └── Sidebar.vue         # 进度侧边栏组件
│   ├── data/
│   │   ├── concepts.js         # 概念定义
│   │   └── days.js             # 日程配置
│   ├── styles/
│   │   └── main.css            # 全局样式
│   └── App.vue                 # 主应用组件
```

## 关键开发流程

### 1. 初始化项目

```bash
cd GUI
npm create vite@latest . -- --template vue
npm install
```

### 2. 实现头部导航

#### AppHeader.vue开发要点

**核心特性**:
- 标题居中显示，包含免责声明和作者署名（带GitHub链接）。
- 左右两侧包含切换按钮（日程在左，进度在右），通过`emit`事件向父组件传递切换请求。
- 接收`showLeftSidebar`和`showRightSidebar`属性控制按钮激活状态。

### 3. 实现主应用状态管理

#### App.vue核心逻辑

**响应式状态与页面自适应**:
利用 `ref` 管理侧边栏显示状态和当前日程 (`currentDay`)。
通过 `onMounted` 监听窗口resize事件：PC端默认展开双侧边栏，移动端（<=768px）默认收起。

**组件挂载**:
通过props向下传递状态，并通过监听子组件的`emit`事件更新状态。例如，通过`:class="{ 'hidden': !showLeftSidebar }"`动态控制侧边栏显隐。

### 4. 实现日程导航

#### DayNavigation.vue开发

负责显示Day 1-7的日程列表。高亮当前选中日程（`.active`类），并提供点击切换功能。

### 5. 实现日程内容（核心组件）

#### DayContent.vue开发流程

主要负责右侧核心内容的展示，根据不同的 `currentDay` 渲染对应的教学内容。

**5.1 基础结构与Props**
接收主状态传递的数据，包括各种计数器、用户信息等。通过 `emit` 触发上层状态修改。

**5.2 Day 1 实现（计数器）**
实现一个简单的按钮点击计数功能，触发 `click-counter` 事件，父组件根据计数值解锁不同概念。

**5.3 Day 2 实现（数据存储）**
两块核心逻辑：
1. **存储数据**：输入姓名和简介并触发存储事件。
2. **检索数据**：显示已存信息。

**5.4 Day 3 实现（投票系统）**
- **候选人添加**：输入框添加候选人。
- **投票界面**：遍历渲染候选人列表，并为每个候选人提供投票按钮及展示当前票数。

**5.5 Day 4 实现（拍卖）**
- **拍卖初始化**：设置拍卖物品及竞拍时长。
- **出价界面**：输入出价金额及竞拍者地址进行模拟出价。

**5.6 Day 5 实现（提款与权限管理）**
为内容逻辑分组，包含5个核心功能块（左右分栏布局，无交互时居中）：
1. **添加宝藏**：`addTreasure(uint256 amount)`
2. **批准提款**：`approveWithdrawal(address recipient, uint256 amount)`，含随机地址生成。
3. **提取宝藏**：`withdrawTreasure(uint256 amount)` 及状态重置。
4. **转移所有权**：`transferOwnership(address newOwner)`
5. **查询操作**：`getTreasureDetails()`
合约函数验证均有对应UI交互。UI块标题下标注Solidity函数签名，以增强教学直观性。

**5.7 Day 6 实现（高级概念）**
- **存款**：存入ETH，包含金额验证（≥1 ETH解锁msg.value）。
- **会员管理**：注册会员并查看会员总数。
- **余额查询**：展示合约总余额。

**5.8 Day 7 实现（债务关系与底层调用）**
两大核心交互体系与底层指令演示：
- **债务网 (嵌套映射)**：允许录入债务人、金额甚至附带字符串备注（展示 `string storage`），前端使用多维输入框展示 `mapping(address => mapping(address => Debt))` 的更新形态。
- **钱包出账 (transfer vs call)**：提供了通过 `.transfer` (带 Gas 限制) 和 `.call{value}()` (无 Gas 限制低级调用) 进行 ETH 实际划转的对照演示，并对失败场景进行统一的不足余额（Insufficient Balance）错误拦截。

**5.9 知识解锁区域（右栏跟随）**
交互操作会触发提示气泡（💡）和知识解锁卡片（📚），随视线或滚动条悬停展示。

### 6. 实现进度侧边栏

#### Sidebar.vue开发
展示各日程解锁的知识点数量和总体进度百分比。高亮显示当前进入的Day日程详情信息。

### 7. 实现概念解锁逻辑

统一在 `App.vue` 中管理，依据用户交互次数或输入数据条件触发 `unlockConcept(day, conceptId)`。

例如Day 1解锁逻辑：
```javascript
const clickCounter = () => {
  contracts.value.day1.count++
  if (contracts.value.day1.count === 1) unlockConcept(1, 'function')
  // 后续依次解锁 increment, uint256, contract
}
```

### 8. 样式系统设计

全局样式存放于 `main.css`。

**全局变量与配色**:
基于Solarized配色方案，定义如 `--primary-color: #b58900`, `--secondary-color: #2aa198` 等变量。

**响应式布局策略**:
- PC端采用 `flex` 布局，左（250px）中（flex:1）右（300px）三栏结构。
- 移动端将两侧边栏改为绝对定位的抽屉式布局 (`left: -100%`)，通过添加显隐类 (`.mobile-visible`) 实现平滑过渡滑出。

### 9. 关键问题解决记录

1. **侧边栏自动收起**：移除由 `.center-content` div 的错误点击事件引发的收缩。
2. **标题居中问题**：删除 `main.css` 中覆盖的全局样式，使用专用的 `.header-center` 容器。
3. **Day 5右栏空白/布局混乱**：清理DOM层级嵌套错误，梳理为 `.control-section` 规范化的分块。移除影响自适应宽度的 `max-width` 限制。
4. **Vue模板编译错误**：修复被打断的 `v-if/v-else-if` 链，补齐缺失的 `</div>` 结束标签。
5. **解锁阈值调整**：根据反馈将 `msg.value` 的解锁条件从 2 ETH 降为 1 ETH。

### 10. 开发最佳实践

- **组件通信**: Props向下传递数据，Emit向上触发事件，Reactive refs管理响应状态。
- **样式组织**: 组件内部优先使用 `<style scoped>`，全局共用样式沉淀至 `main.css`。
- **性能及错误防范**: 保证模板闭合，合理利用解构和计算属性避免重新渲染。

### 11. 调试技巧

- **Vite热更新**: 依赖Vite的HMR修改代码后快速预览。
- **Vue DevTools**: 浏览器插件透视组件状态与数据流动。
- **控制台审查**: 跟踪常规JS错误与浏览器网络请求。

### 12. 部署检查清单

- [ ] 所有日程功能正常工作
- [ ] 概念解锁逻辑正确
- [ ] PC端及移动端布局正常且侧边栏切换可用
- [ ] 无控制台及模板编译错误
- [ ] 界面交互响应流畅

### 13. UI/UX与交互体验优化记录

- **全局交互提升**：增加右侧悬浮粘性侧边栏 (`position: sticky`)；高频输入的以太坊地址增加🎲“随机生成”快捷键。底部的“完整代码”查看按钮规格全局统一。
- **视觉排版**：颜色主题收敛对齐至 **Solarized Cyan (`#2aa198`)** 和柔和暖色 (`#b58900`)；功能容器 (Function Block) 四周留出均匀内边距并搭配细边框。
- **合规与引导**：为所有核心执行块添加 `.function-signature` (合约函数等宽签名)。并在 Day 4 修复渐进式解锁阻断Bug，清理多次弹出的冗余气泡。

## 扩展开发指南

### 添加新日程
1. 补充 `data/days.js` (日程配置) 及 `data/concepts.js` (概念定义)。
2. 在 `DayContent.vue` 的 `v-else-if` 中增加分支，渲染新UI。
3. `App.vue` 注入相应状态并在 `main.css` 增加针对性样式。

### 添加新交互
1. 在 `DayContent.vue` 补充按钮与输入框并绑定 `emit`。
2. 在主入口捕获事件，处理状态并调用 `unlockConcept` 判断触发逻辑。

## 常见问题FAQ

**Q: 如何调整全局字体/侧边栏/配色？**
A: 修改 `main.css` 的 `:root` 样式变量及对应容器的 `width` 值。

**Q: 如何修复v-else-if错误？**
A: 确保在Vue组件下的 `v-if/v-else-if` 平级DOM链连续，中间不能被其他HTML元素打断。

## 总结

这个GUI项目展示了Vue 3 Composition API的完整应用，包括：
- 组件化开发
- 响应式状态管理
- 父子组件通信
- 条件渲染和列表渲染
- 事件处理
- 样式封装
- 响应式设计

通过这个项目，可以学习到如何从零开始构建一个功能完整的交互式教学界面。
