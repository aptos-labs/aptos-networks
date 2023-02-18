# For bootstrapping your validator node:

- The branch to use is `testnet`, commit 8f0cbd9396264cdce520d2e1002424b1592c576f
- The docker image tag to use is testnet_8f0cbd9396264cdce520d2e1002424b1592c576f
- Sha256 for the docker image is a3c6ec71d747cbc026b563e3c1778434abf51a548757cb3bff3bc51c004601a6
- REST API endpoint: https://testnet.aptoslabs.com
- Docs to follow: https://aptos.dev/nodes/ait/connect-to-testnet

# Submitting framework upgrades on testnet
1. Download the aptos-core Github repo and make sure you're on the main branch: https://github.com/aptos-labs/aptos-core
2. Make sure you have a CLI profile for testnet-voter with the credentials for a voter account corresponding
to a stake pool.
3. To create a proposal on-chain, in the aptos-core repo, run
cargo run -p aptos -- governance propose --is_multi_step true \
--metadata-url /path/to/aptos-networks/testnet/proposals/sources/v1.2.3/metadata.json \
--pool-address $pool_address \
--script-path /path/to/aptos-networks/testnet/proposals/sources/v1.2.3/0-move-stdlib.move \
--framework-local-dir /path/to/aptos-core/aptos-move/framework/aptos-framework/ \
--profile testnet-voter
4. Verify that the proposal is created on chain by going to https://governance.aptosfoundation.org/ and select testnet.
5. Vote on the proposal with a voter account with at least 100M stake. Use the UI above or run:
cargo run -p aptos -- governance vote --proposal-id <proposal-id> --pool-addresses $pool_address_1,$pool_address_2 --yes
6. The proposal should become resolved after 12 hours. To execute a multi-step proposal, execute the following command
once per script (they should be ordered already in the proposal directory):
cargo run -p aptos -- governance execute-proposal --proposal-id <proposal-id> \
--script-path path/to/step.move \
--max-gas 500000 \
--framework-local-dir /path/to/aptos-core/aptos-move/framework/aptos-framework/
