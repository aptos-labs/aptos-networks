// Script hash: e1c4b36c87298eb3d552ba522211c6b7a6dc104f6f5074633377d1d8fda4e93f
// Modifying on-chain feature flags:
// Enabled Features: [EnableFunctionReflection, FunctionValueDispatch, LazyModuleInitialization, CheckFunctionTypeAbilities]
// Disabled Features: []
//
script {
    use aptos_framework::aptos_governance;
    use std::features;

    fun main(proposal_id: u64) {
        let framework_signer = aptos_governance::resolve_multi_step_proposal(proposal_id, @0x1, x"");

        let enabled_blob: vector<u64> = vector[
            105, 125, 127, 129,
        ];

        let disabled_blob: vector<u64> = vector[

        ];

        features::change_feature_flags_for_next_epoch(&framework_signer, enabled_blob, disabled_blob);
        aptos_governance::reconfigure(&framework_signer);
    }
}
