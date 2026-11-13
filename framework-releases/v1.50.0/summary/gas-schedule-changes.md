# Gas Schedule Changes

Gas feature version: 53 -> 55

- [x] I have reviewed the gas schedule changes below.

## Changes

| change   | parameter                                                        |  old |   new | sign-off |
| -------- | ---------------------------------------------------------------- | ---: | ----: | -------- |
| added    | aptos_framework.init.get_caller_address_and_module_id.base       |    / |  7350 |          |
| added    | aptos_framework.transaction_context.is_multisig_payload_txn.base |    / |  7350 |          |
| added    | aptos_framework.transaction_context.is_orderless_txn.base        |    / |  7350 |          |
| added    | instr.pack_closure.per_abs_val_unit                              |    / |   140 |          |
| added    | misc.abs_val.closure_per_captured_layout_byte                    |    / |     1 |          |
| added    | misc.abs_val.closure_per_ty_tag_unit                             |    / |     1 |          |
| added    | misc.abs_val.closure_v2                                          |    / |   200 |          |
| added    | misc.value_traversal.base                                        |    / | 11010 |          |
| added    | misc.value_traversal.per_abs_val_unit                            |    / |   420 |          |
| added    | move_stdlib.string.index_of.per_byte                             |    / |   360 |          |
| added    | move_stdlib.string.is_char_boundary.per_byte                     |    / |   290 |          |
| added    | txn.high_limit_txn_excess_price_multiplier                       |    / |    10 |          |
| modified | txn.high_limit_txn_min_price_per_gas_unit                        | 1000 |   100 |          |
| added    | txn.min_module_bytecode_version                                  |    / |     8 |          |
