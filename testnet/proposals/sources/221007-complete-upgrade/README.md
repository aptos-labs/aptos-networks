This package contains a complete framework upgrade. The framework upgrade currently uses the system backdoor to execute and does not go through normal governance. This contains the following transactions:

* `01-gas.move` - both the gas feature v3 upgrade as well as a relaxation to the maximum transaction size to allow the remaining transactions to pass (1024K)
* `02-stdlib.move` - standard library update
* `03-aptosstdlib.move` - aptos standard library update
* `04-framework.move` - aptos framework update
* `05-token.move` - aptos token update
* `06-gas.move` - reduce the maximum transaction size to 64KB
* `07-features` - enable feature 1 and 2 (code dependency check and public(friends) is considered private)

Note, these files can be reproduced from this commit hash: `63e5c543742f17e0f09b98ea39f40744c7cf4abf`. With the caveat that `04-framework.move` was manually modified to be split into separate chunks due to limitations in the current code generation. In addition the headers of each file were modified to support the `aptos_governance::get_signer_testnet_only was swapped in`. See the following example:

```
2,3d1
<
< // source digest: C6010D18D1B2ECE7A3CBE99BD0AF58729CB5AFBD428FF872102CB9726643707D
9,10c7,8
<     fun main(proposal_id: u64){
<         let framework_signer = aptos_governance::resolve(proposal_id, @0000000000000000000000000000000000000000000000000000000000000001);
---
>     fun main(account: &signer) {
>         let framework_signer = aptos_governance::get_signer_testnet_only(account, @0x1);
```
