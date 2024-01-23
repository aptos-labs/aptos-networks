// Script hash: 0c9c9ae8 
// Execution config upgrade proposal

// config: V4(
//     ExecutionConfigV4 {
//         transaction_shuffler_type: SenderAwareV2(
//             32,
//         ),
//         block_gas_limit_type: ComplexLimitV1 {
//             effective_block_gas_limit: 20000,
//             execution_gas_effective_multiplier: 1,
//             io_gas_effective_multiplier: 1,
//             conflict_penalty_window: 6,
//             use_granular_resource_group_conflicts: false,
//             use_module_publishing_block_conflict: false,
//             block_output_limit: Some(
//                 3145728,
//             ),
//             include_user_txn_size_in_block_output: true,
//             add_block_limit_outcome_onchain: false,
//         },
//         transaction_deduper_type: TxnHashAndAuthenticatorV1,
//     },
// )

script {
    use aptos_framework::aptos_governance;
    use aptos_framework::execution_config;
    use std::vector;

    fun main(proposal_id: u64) {
        let framework_signer = aptos_governance::resolve_multi_step_proposal(proposal_id, @0x1, vector::empty<u8>());

        let execution_blob: vector<u8> = vector[
            4, 2, 32, 0, 0, 0, 2, 32, 78, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0,
            0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 0, 1, 0, 0,
            48, 0, 0, 0, 0, 0, 1, 0, 1,
        ];

        execution_config::set(&framework_signer, execution_blob);
    }
}
