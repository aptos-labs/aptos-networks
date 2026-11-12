// Script hash: 3757b267 
// Execution config upgrade proposal

// config: V3(
//     ExecutionConfigV3 {
//         transaction_shuffler_type: SenderAwareV1(
//             32,
//         ),
//         block_gas_limit: None,
//         transaction_deduper_type: TxnHashAndAuthenticatorV1,
//     },
// )

script {
    use aptos_framework::aptos_governance;
    use aptos_framework::execution_config;
    use std::vector;

    fun main(proposal_id: u64) {
        let framework_signer = aptos_governance::resolve_multi_step_proposal(proposal_id, @0000000000000000000000000000000000000000000000000000000000000001, vector::empty<u8>());

        let execution_blob: vector<u8> = vector[
            2, 1, 32, 0, 0, 0, 0, 1,
        ];

        execution_config::set(&framework_signer, execution_blob);
    }
}
