const CONFIG = {
  // 部署后替换成你的合约地址；为空时自动使用演示模式（不连链）。
  contractAddress: "",
  abi: [
    "function counter() view returns (uint256)",
    "function click()",
  ],
};

const DEMO_STORAGE_KEY = "day1-clickcounter-demo";

const el = {
  walletStatus: document.getElementById("wallet-status"),
  account: document.getElementById("account"),
  network: document.getElementById("network"),
  counter: document.getElementById("counter"),
  status: document.getElementById("status"),
  modeHint: document.getElementById("mode-hint"),
  connectBtn: document.getElementById("connect-btn"),
  clickBtn: document.getElementById("click-btn"),
};

const state = {
  provider: null,
  signer: null,
  contract: null,
  account: "",
  demoCounter: Number(localStorage.getItem(DEMO_STORAGE_KEY) || "0"),
  isDemo: !/^0x[a-fA-F0-9]{40}$/.test(CONFIG.contractAddress),
};

function setStatus(message) {
  el.status.textContent = message;
}

function shortAddress(address) {
  return `${address.slice(0, 6)}...${address.slice(-4)}`;
}

function syncModeHint() {
  if (state.isDemo) {
    el.modeHint.textContent =
      "当前模式：Demo（未配置合约地址，点击将模拟一笔上链交易）。";
  } else {
    el.modeHint.textContent = `当前模式：链上模式（合约：${CONFIG.contractAddress}）`;
  }
}

async function readCounter() {
  if (state.isDemo) {
    return state.demoCounter;
  }
  if (!state.contract) {
    return 0;
  }
  const value = await state.contract.counter();
  return Number(value);
}

async function refreshCounter() {
  const value = await readCounter();
  el.counter.textContent = String(value);
}

async function connectWallet() {
  if (!window.ethereum) {
    setStatus("未检测到 MetaMask，请先安装钱包扩展。");
    return;
  }

  el.connectBtn.disabled = true;
  setStatus("正在请求钱包授权...");

  try {
    state.provider = new ethers.BrowserProvider(window.ethereum);
    await state.provider.send("eth_requestAccounts", []);
    state.signer = await state.provider.getSigner();
    state.account = await state.signer.getAddress();

    if (!state.isDemo) {
      state.contract = new ethers.Contract(
        CONFIG.contractAddress,
        CONFIG.abi,
        state.signer
      );
    }

    const network = await state.provider.getNetwork();
    el.walletStatus.textContent = "已连接";
    el.account.textContent = shortAddress(state.account);
    el.network.textContent = `${network.name} (${network.chainId})`;

    await refreshCounter();
    el.clickBtn.disabled = false;
    setStatus("钱包已连接，随时可以点击计数。");
  } catch (error) {
    setStatus(`连接失败：${error.message || error}`);
  } finally {
    el.connectBtn.disabled = false;
  }
}

function delay(ms) {
  return new Promise((resolve) => setTimeout(resolve, ms));
}

async function runDemoClick() {
  const ok = window.confirm("模拟 MetaMask：确认发送交易并支付 Gas 吗？");
  if (!ok) {
    throw new Error("用户取消了交易。");
  }

  setStatus("模拟交易已提交，等待链上确认...");
  await delay(1200);

  state.demoCounter += 1;
  localStorage.setItem(DEMO_STORAGE_KEY, String(state.demoCounter));
}

async function runChainClick() {
  const tx = await state.contract.click();
  setStatus(`交易已提交：${tx.hash.slice(0, 10)}...`);
  const receipt = await tx.wait();
  setStatus(`交易已确认，区块高度 ${receipt.blockNumber}`);
}

async function onClickCounter() {
  if (!state.signer) {
    setStatus("请先连接钱包。");
    return;
  }

  el.clickBtn.disabled = true;
  try {
    if (state.isDemo) {
      await runDemoClick();
    } else {
      await runChainClick();
    }
    await refreshCounter();
    setStatus("计数成功 +1");
  } catch (error) {
    const message = error?.message || String(error);
    if (error?.code === 4001 || /rejected|denied/i.test(message)) {
      setStatus("你取消了交易签名。");
    } else {
      setStatus(`点击失败：${message}`);
    }
  } finally {
    el.clickBtn.disabled = false;
  }
}

function bindWalletEvents() {
  if (!window.ethereum || !window.ethereum.on) {
    return;
  }

  window.ethereum.on("accountsChanged", (accounts) => {
    if (!accounts.length) {
      state.signer = null;
      state.contract = null;
      state.account = "";
      el.walletStatus.textContent = "未连接";
      el.account.textContent = "-";
      el.clickBtn.disabled = true;
      setStatus("钱包已断开，请重新连接。");
      return;
    }
    window.location.reload();
  });

  window.ethereum.on("chainChanged", () => {
    window.location.reload();
  });
}

function init() {
  syncModeHint();
  el.connectBtn.addEventListener("click", connectWallet);
  el.clickBtn.addEventListener("click", onClickCounter);
  refreshCounter();
  bindWalletEvents();
}

init();
