# Day1 ClickCounter（零基础版）

这是一个**最小可运行 DApp 原型**，对应 `Note/PRD.md` 的流程：

1. 用户连接钱包（MetaMask）
2. 页面显示当前 `counter`
3. 点击 `Click`
4. 触发 `click()` 交易（或 Demo 模式模拟交易）
5. 交易确认后 `counter +1`
6. 页面刷新显示最新数值

---

## 1. 目录说明

```txt
day1-clickcounter/
├─ index.html   # 页面结构（按钮、状态、计数展示）
├─ style.css    # 基础样式
├─ app.js       # DApp 逻辑：连钱包、读计数、发交易
└─ README.md    # 本说明文档
```

---

## 2. 先理解几个最基础概念

- `DApp`：运行在区块链上的应用。前端是网页，核心数据在链上。
- `钱包`：比如 MetaMask，用来管理账号、签名交易。
- `智能合约`：链上的程序。这里有 `counter` 变量和 `click()` 函数。
- `交易`：调用会改链上状态的函数（例如 `click()`）就是交易，需要签名并支付 Gas。
- `Gas`：执行交易消耗的费用，支付给区块链网络。
- `ABI`：前端和合约“对话”的接口说明书。没有 ABI 前端不知道怎么调用合约函数。

一句话记忆：**前端负责展示和交互，钱包负责签名，合约负责存数据和规则。**

---

## 3. 快速运行（3 分钟）

## 前提

- 已安装浏览器扩展 `MetaMask`
- 你的浏览器能打开本地静态网页

## 步骤

1. 在项目目录启动一个静态服务器（任选其一）：

```bash
python -m http.server 5173
```

2. 浏览器访问：

```txt
http://localhost:5173/day1-clickcounter/
```

3. 点击页面里的 `连接 MetaMask`。

---

## 4. 两种运行模式

## A. Demo 模式（默认）

`app.js` 中 `contractAddress` 为空字符串时自动进入 Demo 模式：

- 会模拟“确认交易 -> 等待上链 -> counter +1”
- 计数存在浏览器 `localStorage`
- 适合零基础先跑通全流程

## B. 链上模式（真实交易）

把 `app.js` 顶部配置改成你的合约地址：

```js
const CONFIG = {
  contractAddress: "0xYourContractAddress",
  abi: [
    "function counter() view returns (uint256)",
    "function click()",
  ],
};
```

然后重新刷新页面，点击会真的走钱包签名和链上确认流程。

---

## 5. 页面按钮背后发生了什么

## 连接钱包按钮

调用 `eth_requestAccounts`：

- 弹出 MetaMask 授权窗口
- 用户同意后拿到地址
- 再读取网络信息和当前 `counter`

## Click 按钮

- Demo 模式：模拟交易并本地 `+1`
- 链上模式：
  1. 调用 `contract.click()`
  2. MetaMask 弹窗确认 Gas
  3. 用户签名后提交交易
  4. 前端等待 `tx.wait()`（区块确认）
  5. 再次读取 `counter` 并刷新页面

---

## 6. 对应的最小合约（示例）

如果你还没部署合约，可以先用这个最小版本：

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract ClickCounter {
    uint256 public counter;

    event Clicked(address indexed user, uint256 newCounter);

    function click() external {
        counter += 1;
        emit Clicked(msg.sender, counter);
    }
}
```

说明：

- `uint256 public counter;` 会自动生成可读函数 `counter()`
- `click()` 每调用一次就把计数加 1
- `event` 方便后续在前端监听日志

---

## 7. 常见报错与处理

- `未检测到 MetaMask`：
  - 先安装 MetaMask 扩展，刷新页面。
- `execution reverted`：
  - 合约内部 `require` 失败，检查合约逻辑和参数。
- 一直在等待确认：
  - 网络可能拥堵；在钱包里查看交易状态。
- 读不到 `counter`：
  - 检查合约地址和 ABI 是否和部署合约一致。

---

## 8. 你可以继续做的下一步

1. 增加“重置计数器”按钮（合约加 `reset()`）
2. 在前端展示最近 N 条点击记录（监听事件）
3. 接入测试网部署脚本（Hardhat / Foundry）
4. 增加自动化测试（合约测试 + 前端最小 E2E）

这份原型重点是先把“钱包 -> 交易 -> 状态刷新”的最小闭环跑通。
