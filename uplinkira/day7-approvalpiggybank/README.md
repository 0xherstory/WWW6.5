# Day7 ApprovalPiggyBank MVP

## What this day covers

1. Manager-controlled member system
2. ETH deposits by members
3. Manager approval before withdrawal
4. Actual ETH transfer on `withdraw`
5. Manager handover with `transferBankManager`

## Files

1. `src/day7_approvalpiggybank.sol`: Solidity contract
2. `ui/dapp-demo/`: minimal interaction demo

## Run demo

```bash
python -m http.server 5173
```

Open:

```txt
http://localhost:5173/uplinkira/day7-approvalpiggybank/ui/dapp-demo/
```

## Demo mode vs on-chain mode

1. Default is Demo mode (local simulation with localStorage).
2. For chain mode, deploy contract and set `contractAddress` in `ui/dapp-demo/app.js`.

## Day6 vs Day7 difference

1. Day6 withdraw is accounting-only.
2. Day7 withdraw requires approval and sends ETH back to the caller wallet.
