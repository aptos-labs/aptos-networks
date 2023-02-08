// Modifying on-chain feature flags:
// Enabled Features: [CodeDependencyCheck, TreatFriendAsPrivate, VMBinaryFormatV6]
// Disabled Features: []
//
script {
    use aptos_framework::aptos_governance;
    use std::features;

    fun main(proposal_id: u64) {
        let framework_signer = aptos_governance::resolve_multi_step_proposal(
            proposal_id,
            @0000000000000000000000000000000000000000000000000000000000000001,
            vector[193u8,106u8,150u8,195u8,64u8,130u8,23u8,194u8,169u8,249u8,220u8,205u8,176u8,186u8,131u8,182u8,250u8,42u8,70u8,146u8,228u8,121u8,132u8,194u8,247u8,15u8,202u8,118u8,212u8,64u8,184u8,239u8,],
        );
        let enabled_blob: vector<u64> = vector[
            1, 2, 5,
        ];

        let disabled_blob: vector<u64> = vector[

        ];

        features::change_feature_flags(&framework_signer, enabled_blob, disabled_blob);
    }
}
