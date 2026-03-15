const CONFIG = {
  // Fill with deployed address to enable on-chain mode.
  contractAddress: "",
  abi: [
    "function bankManager() view returns (address)",
    "function members(address user) view returns (bool)",
    "function balances(address user) view returns (uint256)",
    "function withdrawalApproval(address user) view returns (uint256)",
    "function totalDeposits() view returns (uint256)",
    "function contractEthBalance() view returns (uint256)",
    "function addMember(address member)",
    "function deposit() payable",
    "function approveWithdrawal(address member, uint256 amountWei)",
    "function withdraw(uint256 amountWei)",
    "function transferBankManager(address newManager)",
  ],
};

const STORAGE_KEY = "uplinkira-day7-approval-piggybank";

const el = {
  mode: document.getElementById("mode"),
  status: document.getElementById("status"),
  manager: document.getElementById("manager"),
  account: document.getElementById("account"),
  isMember: document.getElementById("isMember"),
  myBalance: document.getElementById("myBalance"),
  myApproval: document.getElementById("myApproval"),
  totalDeposits: document.getElementById("totalDeposits"),
  contractBalance: document.getElementById("contractBalance"),
  memberInput: document.getElementById("memberInput"),
  depositInput: document.getElementById("depositInput"),
  approveMemberInput: document.getElementById("approveMemberInput"),
  approveAmountInput: document.getElementById("approveAmountInput"),
  withdrawInput: document.getElementById("withdrawInput"),
  newManagerInput: document.getElementById("newManagerInput"),
  connectBtn: document.getElementById("connectBtn"),
  refreshBtn: document.getElementById("refreshBtn"),
  addMemberBtn: document.getElementById("addMemberBtn"),
  depositBtn: document.getElementById("depositBtn"),
  approveBtn: document.getElementById("approveBtn"),
  withdrawBtn: document.getElementById("withdrawBtn"),
  transferBtn: document.getElementById("transferBtn"),
};

function makeInitialDemo() {
  return {
    manager: "",
    members: {},
    balances: {},
    approvals: {},
    totalDepositsWei: "0",
    contractBalanceWei: "0",
  };
}

const state = {
  isDemo: !/^0x[a-fA-F0-9]{40}$/.test(CONFIG.contractAddress),
  provider: null,
  signer: null,
  account: "",
  contract: null,
  demo: JSON.parse(localStorage.getItem(STORAGE_KEY) || "null") || makeInitialDemo(),
};

function setStatus(message) {
  el.status.textContent = message;
}

function persistDemo() {
  localStorage.setItem(STORAGE_KEY, JSON.stringify(state.demo));
}

function shortAddress(address) {
  if (!address) return "-";
  return `${address.slice(0, 6)}...${address.slice(-4)}`;
}

function normalizeAddress(address) {
  return address.toLowerCase();
}

function toWeiFromEthInput(raw) {
  const value = String(raw || "").trim();
  if (!value) return null;
  try {
    return ethers.parseEther(value);
  } catch {
    return null;
  }
}

function formatEth(weiLike) {
  try {
    return Number(ethers.formatEther(weiLike)).toFixed(6);
  } catch {
    return "0.000000";
  }
}

async function connectWallet() {
  if (!window.ethereum) {
    setStatus("MetaMask not detected.");
    return;
  }

  try {
    state.provider = new ethers.BrowserProvider(window.ethereum);
    await state.provider.send("eth_requestAccounts", []);
    state.signer = await state.provider.getSigner();
    state.account = await state.signer.getAddress();

    if (!state.isDemo) {
      state.contract = new ethers.Contract(CONFIG.contractAddress, CONFIG.abi, state.signer);
    } else if (!state.demo.manager) {
      const key = normalizeAddress(state.account);
      state.demo.manager = state.account;
      state.demo.members[key] = true;
      state.demo.balances[key] = "0";
      state.demo.approvals[key] = "0";
      persistDemo();
    }

    el.refreshBtn.disabled = false;
    el.addMemberBtn.disabled = false;
    el.depositBtn.disabled = false;
    el.approveBtn.disabled = false;
    el.withdrawBtn.disabled = false;
    el.transferBtn.disabled = false;

    setStatus("Wallet connected.");
    await refresh();
  } catch (error) {
    setStatus(`Connect failed: ${error.message || error}`);
  }
}

async function addMember() {
  const member = el.memberInput.value.trim();
  if (!/^0x[a-fA-F0-9]{40}$/.test(member)) {
    setStatus("Member address is invalid.");
    return;
  }

  el.addMemberBtn.disabled = true;
  try {
    if (state.isDemo) {
      if (normalizeAddress(state.account) !== normalizeAddress(state.demo.manager)) {
        throw new Error("Only manager can add member.");
      }

      const key = normalizeAddress(member);
      if (state.demo.members[key]) {
        throw new Error("Member already exists.");
      }

      state.demo.members[key] = true;
      state.demo.balances[key] = "0";
      state.demo.approvals[key] = "0";
      persistDemo();
    } else {
      const tx = await state.contract.addMember(member);
      setStatus(`Tx sent: ${tx.hash.slice(0, 10)}...`);
      await tx.wait();
    }

    el.memberInput.value = "";
    setStatus("Member added.");
    await refresh();
  } catch (error) {
    setStatus(`Add member failed: ${error.message || error}`);
  } finally {
    el.addMemberBtn.disabled = false;
  }
}

async function deposit() {
  const amountWei = toWeiFromEthInput(el.depositInput.value);
  if (!amountWei || amountWei <= 0n) {
    setStatus("Deposit amount must be greater than 0.");
    return;
  }

  el.depositBtn.disabled = true;
  try {
    if (state.isDemo) {
      const key = normalizeAddress(state.account);
      if (!state.demo.members[key]) {
        throw new Error("Only member can deposit.");
      }

      const oldBal = BigInt(state.demo.balances[key] || "0");
      state.demo.balances[key] = (oldBal + amountWei).toString();
      state.demo.totalDepositsWei = (BigInt(state.demo.totalDepositsWei) + amountWei).toString();
      state.demo.contractBalanceWei = (BigInt(state.demo.contractBalanceWei) + amountWei).toString();
      persistDemo();
    } else {
      const tx = await state.contract.deposit({ value: amountWei });
      setStatus(`Tx sent: ${tx.hash.slice(0, 10)}...`);
      await tx.wait();
    }

    el.depositInput.value = "";
    setStatus("Deposit success.");
    await refresh();
  } catch (error) {
    setStatus(`Deposit failed: ${error.message || error}`);
  } finally {
    el.depositBtn.disabled = false;
  }
}

async function approveWithdrawal() {
  const member = el.approveMemberInput.value.trim();
  const amountWei = toWeiFromEthInput(el.approveAmountInput.value);
  if (!/^0x[a-fA-F0-9]{40}$/.test(member)) {
    setStatus("Approve member address is invalid.");
    return;
  }
  if (!amountWei || amountWei < 0n) {
    setStatus("Approve amount is invalid.");
    return;
  }

  el.approveBtn.disabled = true;
  try {
    if (state.isDemo) {
      if (normalizeAddress(state.account) !== normalizeAddress(state.demo.manager)) {
        throw new Error("Only manager can approve.");
      }
      const key = normalizeAddress(member);
      if (!state.demo.members[key]) {
        throw new Error("Unknown member.");
      }
      const memberBalance = BigInt(state.demo.balances[key] || "0");
      if (amountWei > memberBalance) {
        throw new Error("Amount exceeds member balance.");
      }

      state.demo.approvals[key] = amountWei.toString();
      persistDemo();
    } else {
      const tx = await state.contract.approveWithdrawal(member, amountWei);
      setStatus(`Tx sent: ${tx.hash.slice(0, 10)}...`);
      await tx.wait();
    }

    el.approveMemberInput.value = "";
    el.approveAmountInput.value = "";
    setStatus("Approval updated.");
    await refresh();
  } catch (error) {
    setStatus(`Approve failed: ${error.message || error}`);
  } finally {
    el.approveBtn.disabled = false;
  }
}

async function withdraw() {
  const amountWei = toWeiFromEthInput(el.withdrawInput.value);
  if (!amountWei || amountWei <= 0n) {
    setStatus("Withdraw amount must be greater than 0.");
    return;
  }

  el.withdrawBtn.disabled = true;
  try {
    if (state.isDemo) {
      const key = normalizeAddress(state.account);
      if (!state.demo.members[key]) {
        throw new Error("Only member can withdraw.");
      }

      const approval = BigInt(state.demo.approvals[key] || "0");
      const balance = BigInt(state.demo.balances[key] || "0");
      const contractBal = BigInt(state.demo.contractBalanceWei || "0");

      if (amountWei > approval) throw new Error("Amount exceeds approval.");
      if (amountWei > balance) throw new Error("Amount exceeds balance.");
      if (amountWei > contractBal) throw new Error("Insufficient contract ETH.");

      state.demo.approvals[key] = (approval - amountWei).toString();
      state.demo.balances[key] = (balance - amountWei).toString();
      state.demo.totalDepositsWei = (BigInt(state.demo.totalDepositsWei) - amountWei).toString();
      state.demo.contractBalanceWei = (contractBal - amountWei).toString();
      persistDemo();
    } else {
      const tx = await state.contract.withdraw(amountWei);
      setStatus(`Tx sent: ${tx.hash.slice(0, 10)}...`);
      await tx.wait();
    }

    el.withdrawInput.value = "";
    setStatus("Withdraw success.");
    await refresh();
  } catch (error) {
    setStatus(`Withdraw failed: ${error.message || error}`);
  } finally {
    el.withdrawBtn.disabled = false;
  }
}

async function transferManager() {
  const newManager = el.newManagerInput.value.trim();
  if (!/^0x[a-fA-F0-9]{40}$/.test(newManager)) {
    setStatus("New manager address is invalid.");
    return;
  }

  el.transferBtn.disabled = true;
  try {
    if (state.isDemo) {
      if (normalizeAddress(state.account) !== normalizeAddress(state.demo.manager)) {
        throw new Error("Only manager can transfer manager role.");
      }

      const key = normalizeAddress(newManager);
      if (!state.demo.members[key]) {
        state.demo.members[key] = true;
        state.demo.balances[key] = state.demo.balances[key] || "0";
        state.demo.approvals[key] = state.demo.approvals[key] || "0";
      }
      state.demo.manager = newManager;
      persistDemo();
    } else {
      const tx = await state.contract.transferBankManager(newManager);
      setStatus(`Tx sent: ${tx.hash.slice(0, 10)}...`);
      await tx.wait();
    }

    el.newManagerInput.value = "";
    setStatus("Manager transferred.");
    await refresh();
  } catch (error) {
    setStatus(`Transfer failed: ${error.message || error}`);
  } finally {
    el.transferBtn.disabled = false;
  }
}

async function refresh() {
  try {
    let manager;
    let isMember;
    let myBalanceWei;
    let myApprovalWei;
    let totalDepositsWei;
    let contractBalanceWei;

    if (state.isDemo) {
      const key = normalizeAddress(state.account);
      manager = state.demo.manager || "";
      isMember = !!state.demo.members[key];
      myBalanceWei = BigInt(state.demo.balances[key] || "0");
      myApprovalWei = BigInt(state.demo.approvals[key] || "0");
      totalDepositsWei = BigInt(state.demo.totalDepositsWei || "0");
      contractBalanceWei = BigInt(state.demo.contractBalanceWei || "0");
    } else {
      [manager, isMember, myBalanceWei, myApprovalWei, totalDepositsWei, contractBalanceWei] = await Promise.all([
        state.contract.bankManager(),
        state.contract.members(state.account),
        state.contract.balances(state.account),
        state.contract.withdrawalApproval(state.account),
        state.contract.totalDeposits(),
        state.contract.contractEthBalance(),
      ]);
    }

    el.manager.textContent = shortAddress(manager);
    el.account.textContent = shortAddress(state.account);
    el.isMember.textContent = String(isMember);
    el.myBalance.textContent = formatEth(myBalanceWei);
    el.myApproval.textContent = formatEth(myApprovalWei);
    el.totalDeposits.textContent = formatEth(totalDepositsWei);
    el.contractBalance.textContent = formatEth(contractBalanceWei);
  } catch (error) {
    setStatus(`Refresh failed: ${error.message || error}`);
  }
}

function init() {
  el.mode.textContent = state.isDemo ? "Mode: Demo (local simulation)" : "Mode: On-chain";
  el.connectBtn.addEventListener("click", connectWallet);
  el.refreshBtn.addEventListener("click", refresh);
  el.addMemberBtn.addEventListener("click", addMember);
  el.depositBtn.addEventListener("click", deposit);
  el.approveBtn.addEventListener("click", approveWithdrawal);
  el.withdrawBtn.addEventListener("click", withdraw);
  el.transferBtn.addEventListener("click", transferManager);
}

init();
