// Script hash: c4684791 
// Modifying on-chain feature flags:
// Enabled Features: [SaferResourceGroups, SaferMetadata]
// Disabled Features: []
//
script {
    use aptos_framework::aptos_governance;
    use std::features;

    fun main(proposal_id: u64) {
        let framework_signer = aptos_governance::resolve_multi_step_proposal(
            proposal_id,
            @0000000000000000000000000000000000000000000000000000000000000001,
            vector[163u8,186u8,181u8,78u8,48u8,68u8,124u8,246u8,236u8,34u8,4u8,71u8,142u8,6u8,102u8,243u8,207u8,56u8,74u8,145u8,225u8,183u8,172u8,60u8,115u8,52u8,94u8,118u8,161u8,161u8,22u8,190u8,],
        );
        let enabled_blob: vector<u64> = vector[
            31, 32,
        ];

        let disabled_blob: vector<u64> = vector[

        ];

        features::change_feature_flags(&framework_signer, enabled_blob, disabled_blob);
        aptos_governance::reconfigure(&framework_signer);
    }
}
