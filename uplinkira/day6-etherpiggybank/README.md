# Day6 EtherPiggyBank MVP

## What this day covers

1. Role model: bank manager + members
2. Member registration with `addMember`
3. `payable` deposit flow in ETH
4. Member balance tracking and internal ledger withdrawal

## Files

1. `src/day6_etherpiggybank.sol`: Solidity contract
2. `ui/dapp-demo/`: minimal interaction demo

## Run demo

```bash
python -m http.server 5173
```

Open:

```txt
http://localhost:5173/uplinkira/day6-etherpiggybank/ui/dapp-demo/
```

## Demo mode vs on-chain mode

1. Default is Demo mode (local simulation with localStorage).
2. For chain mode, deploy contract and set `contractAddress` in `ui/dapp-demo/app.js`.

## Important behavior

Day6 `withdraw` updates member accounting balances only.  
It does **not** transfer ETH back to user wallet yet.
