# Gas Schedule Changes

Gas feature version: 54 -> 55

- [X] I have reviewed the gas schedule changes below.

## Changes

| change   | parameter                                     |  old |   new | sign-off |
| -------- | --------------------------------------------- | ---: | ----: | -------- |
| added    | instr.pack_closure.per_abs_val_unit           |    / |   140 |          |
| added    | misc.abs_val.closure_per_captured_layout_byte |    / |     1 |          |
| added    | misc.value_traversal.base                     |    / | 11010 |          |
| added    | misc.value_traversal.per_abs_val_unit         |    / |   420 |          |
| added    | txn.high_limit_txn_excess_price_multiplier    |    / |    10 |          |
| modified | txn.high_limit_txn_min_price_per_gas_unit     | 1000 |   100 |          |
| added    | txn.min_module_bytecode_version               |    / |     8 |          |
