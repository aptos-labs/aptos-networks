# Steps to create a proposal

1. To create a proposal, in the aptos-core repo, run
  ```
  cargo run -p aptos -- governance propose --metadata-url <url-to-metadata-file.json> \
     --pool-address $pool_address --script-path /path/to/proposal.move --framework-git-rev mainnet
  ```
2. To vote on a proposer, use the UI at https://governance.aptosfoundation.org/ or run
`cargo run -p aptos -- governance vote --proposal-id <proposal-id> --pool-address $pool_address --yes/no`
3. To execute a proposal that has passed, in the aptos-core repo, run
  ```
  cargo run -p aptos -- governance execute-proposal --proposal-id <proposal-id> \
     --script-path path/to/proposal.move --framework-git-rev testnet --max-gas 500000
  ```

# Generate a proposal script for upgrading modules
In the aptos-core repo:
`cargo run -p aptos -- governance generate-upgrade-proposal --account 0x1 --package-dir aptos-move/framework/aptos-framework`
