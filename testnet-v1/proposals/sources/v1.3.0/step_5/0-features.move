// Script hash: 615fd005 
// Modifying on-chain feature flags:
// Enabled Features: [MultisigAccounts, MultiEd25519PkValidateV2Natives, Sha512AndRipeMd160Natives, Blake2b256Native]
// Disabled Features: []
//
script {
    use aptos_framework::aptos_governance;
    use std::features;
    use std::vector;

    fun main(proposal_id: u64) {
        let framework_signer = aptos_governance::resolve_multi_step_proposal(proposal_id, @0000000000000000000000000000000000000000000000000000000000000001, vector::empty<u8>());

        let enabled_blob: vector<u64> = vector[
            10, 7, 3, 8,
        ];

        let disabled_blob: vector<u64> = vector[

        ];

        features::change_feature_flags(&framework_signer, enabled_blob, disabled_blob);
    }
}
