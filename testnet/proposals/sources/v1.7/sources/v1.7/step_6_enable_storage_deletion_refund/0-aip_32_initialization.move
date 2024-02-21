// Script hash: a2b0e2ea 
// Initialize AIP-28 partial governance voting.
// This script MUST be run before enabling the feature flag, otherwise emitting the fee statement will fail.
script {
    use aptos_framework::aptos_governance;
    use aptos_framework::transaction_fee;

    fun main(proposal_id: u64) {
        let framework_signer = aptos_governance::resolve_multi_step_proposal(
            proposal_id,
            @0x1,
            vector[96u8,252u8,110u8,225u8,171u8,142u8,63u8,205u8,229u8,127u8,156u8,58u8,26u8,177u8,128u8,169u8,10u8,84u8,233u8,219u8,143u8,65u8,213u8,2u8,236u8,71u8,197u8,211u8,49u8,70u8,84u8,109u8,],
        );
        transaction_fee::initialize_storage_refund(&framework_signer);
    }
}
