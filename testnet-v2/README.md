# Testnet waypoints

This directory contains the genesis blob and waypoints for Testnet V2, bootstrapped on 2026-10-06.
I'll check what's actually in `testnet-v2/` so the instructions use the right file names and waypoint.

Here's a draft. I took the file names, waypoint and checksum from the live `testnet-v2/` directory on GitHub, and the node version from what testnet currently runs (`aptos-node-v1.49.4`, chain ID 2).

---

# Testnet has been reset: how to reconnect

Aptos Testnet was reset and relaunched from a new genesis on **2026-10-06**. The chain ID is still **2** and the public endpoints are unchanged, but the chain is new:

- All accounts, balances, deployed packages and transaction history from the old testnet are gone.
- An existing node database belongs to the old chain and **will not work**. Every node operator (validators, validator fullnodes and public fullnodes) must **wipe their data and start over** with the new genesis and waypoint.

## New network files

The files are in [`testnet-v2/`](https://github.com/aptos-labs/aptos-networks/tree/main/testnet-v2):

| File | Value |
|---|---|
| `genesis.blob` | sha256 `38fe1af7169755cb9c66bb5092002e8bcd29418b46166b8af314a00aa13ae381` |
| `waypoint.txt` | `0:ea4bcba78880bf8f7e1c8fa196218ba86269b456ac45c5816157857413fe1b62` |

> **Don't use the old `testnet/` directory.** Its genesis, waypoints and backup configs belong to the previous chain.

**Node version:** `aptos-node-v1.49.4` or later.

## Fullnodes (public fullnodes and validator fullnodes)

1. **Stop the node.**

2. **Wipe the database.** Delete the entire data directory, which is the `storage.dir` in your config (for example `/opt/aptos/data`). Don't restore from backups or snapshots of the old testnet.

3. **Download the new files** and check the checksum:
   ```bash
   curl -fLo genesis.blob https://raw.githubusercontent.com/aptos-labs/aptos-networks/main/testnet-v2/genesis.blob
   curl -fLo waypoint.txt https://raw.githubusercontent.com/aptos-labs/aptos-networks/main/testnet-v2/waypoint.txt
   shasum -a 256 genesis.blob   # must be 38fe1af7...e381
   ```

4. **Point your config at the new files**, replacing the old ones:
   ```yaml
   base:
     waypoint:
       from_file: /opt/aptos/genesis/waypoint.txt
   execution:
     genesis_file_location: /opt/aptos/genesis/genesis.blob
   ```
   Remove any hard-coded waypoint from the old testnet.

5. **Upgrade to `aptos-node-v1.49.4`** and start the node.

6. **Check it's syncing the new chain:**
   ```bash
   curl -s localhost:8080/v1
   ```
   `chain_id` should be `2`, and `epoch` and `ledger_version` should track https://api.testnet.aptoslabs.com/v1. If your node reports an epoch in the tens of thousands, it's still on the old chain's data: stop it and wipe again.

**Kubernetes (aptos-node helm chart):** update the genesis secret with the new `genesis.blob` and `waypoint.txt`, and increase `chain.era` by one. The chart names its storage volume and genesis secret after the era, so this gives the node a fresh, empty volume. Delete the old volume afterwards.

## Validators

Validators also need a fresh start. On top of the fullnode steps:

1. **Wipe all consensus state**, not just the database. Delete `secure-data.json` (the safety-rules storage, usually in the data directory). If you leave it in place, the node will refuse to vote on the new chain.

2. **Keep your identity keys** (`validator-identity.yaml` and `validator-full-node-identity.yaml`) if you're rejoining with the same keys. Your consensus and network keys are unchanged.

3. **Restart with the new genesis and waypoint.** Your node will sync as a fullnode until it rejoins the validator set.

4. **Set up your stake pool again on the new chain.** Your previous pool doesn't exist on the new chain. The Aptos team will fund your owner and operator accounts with your previous stake amount; contact us if they aren't funded yet.

   **Plain stake pool** (run as the owner):
   ```bash
   aptos stake initialize-stake-owner \
     --initial-stake-amount <octas> \
     --operator-address <operator> \
     --voter-address <voter> \
     --profile <owner-profile>
   ```

   **Delegation pool** (run as the owner): use the **same creation seed** as before so the pool gets the same address, which is the address on the allowlist. Commission is given in hundredths of a percent, so `1000` means 10%.
   ```bash
   aptos move run --function-id 0x1::delegation_pool::initialize_delegation_pool \
     --args u64:<commission> hex:<original-seed> \
     --profile <owner-profile>
   ```
   Then add your stake to the pool.

5. **Register your keys and join** (run as the operator):
   ```bash
   aptos node update-consensus-key --pool-address <pool> --operator-config-file operator.yaml --profile <operator-profile>
   aptos node update-validator-network-addresses --pool-address <pool> --operator-config-file operator.yaml --profile <operator-profile>
   aptos node join-validator-set --pool-address <pool> --profile <operator-profile>
   ```
   Your validator becomes active at the next epoch.

Testnet still has a validator allowlist. Previously allowlisted pool addresses carry over. If you need a new address added, contact the Aptos team.

## Developers and dApps

- Testnet accounts and contracts were not migrated. Recreate your accounts, fund them from the faucet, and redeploy your Move packages.
- Indexers and anything else that stored old testnet data (transaction versions, event sequence numbers, account state) should reset that data.
- The REST, indexer and faucet endpoints are unchanged.

---

# Submitting framework upgrades on testnet

1. Download the aptos-core Github repo and make sure you're on the main branch: https://github.com/aptos-labs/aptos-core
2. Make sure you have a CLI profile for testnet-voter with the credentials for a voter account corresponding
   to a stake pool.
3. To create a proposal on-chain, in the aptos-core repo, run

```
aptos governance propose --is-multi-step \
--metadata-url https://raw.githubusercontent.com/aptos-labs/aptos-networks/main/testnet/proposals/sources/v1.2.3/metadata.json \
--pool-address $pool_address \
--script-path /path/to/aptos-networks/testnet/proposals/sources/v1.2.3/0-move-stdlib.move \
--framework-local-dir /path/to/aptos-core/aptos-move/framework/aptos-framework/ \
--profile testnet-voter
```

4. Verify that the proposal is created on chain by going to https://governance.aptosfoundation.org/ and select testnet.
5. Vote on the proposal with a voter account with at least 100M stake. Use the UI above or run:

```
aptos governance vote --proposal-id <proposal-id> \
--yes \
--profile testnet-voter \
--pool-addresses $pool_address_1,$pool_address_2
```

6. The proposal should become resolved after 30 minutes. To execute a multi-step proposal, execute the following command
   once per script (they should be ordered already in the proposal directory):

```
aptos governance execute-proposal --proposal-id <proposal-id> \
--profile testnet-voter \
--script-path path/to/step.move \
--max-gas 500000 \
--framework-local-dir /path/to/aptos-core/aptos-move/framework/aptos-framework/
```
