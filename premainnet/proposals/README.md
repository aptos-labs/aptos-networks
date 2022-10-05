# Steps to create a proposal

1. Define a proposal:
    - Use the following template:
    ```
    script {
        use aptos_framework::aptos_governance;

        fun main(proposal_id: u64) {
      	    let framework_signer = aptos_governance::resolve(proposal_id, @1);
      			...
      	}
    }
    ```
    - Upgrade the framework, the account must match where the package is intended to be published. This will create a proposal in `stdlib.move`:
    ```
    cargo run -p -- governance generate-upgrade-proposal --account 0x1 --output stdlib.move \
        --package-dir aptos-move/framework/move-stdlib/
    ```
    - Upgrade the gas configuration, this will create a proposal in `gas/sources/update_gas_schedule.move`:
    ```
    cargo run -p aptos-gas -- --output gas
    ```
2. Upload the proposal to this GitHub repository:
    - Add the [metadata](https://github.com/aptos-labs/aptos-genesis-waypoint/blob/main/premainnet/proposals/metadata/0-update-duration-and-increase-limit.json) to the metadata folder.
    - Add the move file to the sources folder.
    - Please ensure consistent and accurate naming for both files.
3. To create a proposal on-chain, in the aptos-core repo, run
  ```
  cargo run -p aptos -- governance propose --metadata-url <url-to-metadata-file.json> \
     --pool-address $pool_address --script-path /path/to/proposal.move \
     --framework-local-dir /path/to/aptos-core/aptos-move/framework/aptos-framework/
  ```
4. To vote on a proposer, use the UI at https://governance.aptosfoundation.org/ or run
`cargo run -p aptos -- governance vote --proposal-id <proposal-id> --pool-address $pool_address --yes/no`
5. To execute a proposal that has passed, in the aptos-core repo, run
  ```
  cargo run -p aptos -- governance execute-proposal --proposal-id <proposal-id> \
     --script-path path/to/proposal.move --max-gas 500000 \
     --framework-local-dir /path/to/aptos-core/aptos-move/framework/aptos-framework/
  ```
