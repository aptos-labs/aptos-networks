/// This proposal updates the list of validators allowed to join the validator set.
/// This can be combined with remove_validators to prevent validators from rejoining the set.
script {
    use aptos_framework::aptos_governance;
    use aptos_framework::stake;

    fun main(proposal_id: u64) {
        let framework_signer = &aptos_governance::resolve(proposal_id, @aptos_framework);
        stake::add_allowed_validators(framework_signer, &vector[
            // TODO: Update list of validators to add to the allowed list.
            @0xda557f6d45952778e0c4c7296dc8f8303d846d5453800efd7b03cfbd5f8def04
        ]);

        stake::remove_allowed_validators(framework_signer, &vector[
            // TODO: Update list of validators to remove from the allowed list.
            @0xda557f6d45952778e0c4c7296dc8f8303d846d5453800efd7b03cfbd5f8def04
        ]);

        // End the epoch so the validator set change takes effect.
        aptos_governance::reconfigure(framework_signer);
    }
}
