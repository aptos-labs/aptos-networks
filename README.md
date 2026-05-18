# Aptos genesis blob and waypoint for different networks

- `devnet/`: Developer testnet, upgraded weekly on Thursday from main branch, data will be wiped when upgrade.
- `ait3/`: Aptos Incentivized Testnet 3, short lived testing network.
- `testnet/`: Aptos stable testnet, data will be persisted during upgrades. 
- `mainnet/`: Aptos Mainnet

## Fetching LFS files

Large binaries (e.g. `digest_key.bin`, `pp.bin`) are stored in Git LFS but excluded from default fetches to keep clones fast. After cloning, pull only the network you need:

```bash
git lfs pull --include="devnet/*"
# or
git lfs pull --include="testnet/*"
```

To fetch everything: `git lfs pull --include="*"`.
