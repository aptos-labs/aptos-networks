This package contains a complete framework upgrade. The framework upgrade currently uses the system backdoor to execute and does not go through normal governance. This contains the following transactions:

* `01-gas.move` - both the gas feature v4 upgrade as well as a relaxation to the maximum transaction size to allow the remaining transactions to pass (1024K)
* `02-stdlib.move` - standard library update
* `03-aptosstdlib.move` - aptos standard library update
* `04-framework.move` - aptos framework update
* `05-token.move` - aptos token update
* `06-gas.move` - reduce the maximum transaction size to 64KB
* `07-features` - enable feature 3 -- new crypto functions

Upgrades were generated with
```
cargo run -p aptos -- governance generate-upgrade-proposal \
--account $addr \
--package-dir aptos-move/framework/$package \
--output $package.move \
--testnet
```

Gas was generated with `cargo run -p aptos-gas` while changing the following lines in the `update_gas_schedule.move`:
```
-    fun main(proposal_id: u64) {
-        let framework_signer = aptos_governance::resolve(proposal_id, @0000000000000000000000000000000000000000000000000000000000000001);
+    fun main(core_resources: &signer){
+        let framework_signer = aptos_governance::get_signer_testnet_only(core_resources, @0000000000000000000000000000000000000000000000000000000000000001);
```

The files originated from aptos-core githash: `659c6e573af02471ed16b314f955531f1d930e3b`
