script {
    use aptos_framework::aptos_governance;
    use aptos_framework::block;
    use aptos_framework::staking_config;

    fun main(proposal_id: u64) {
        let framework_signer = &aptos_governance::resolve(proposal_id, @aptos_framework);
        // Update epoch interval from 1 hour to 2 hours.
        let epoch_interval_secs = 2 * 60 * 60;
        let epoch_interval_microsecs = epoch_interval_secs * 1000000;
        block::update_epoch_interval_microsecs(&framework_signer, epoch_interval_microsecs);

        // Update the per-epoch voting power increase limit from 20% to 10%.
        staking_config::update_voting_power_increase_limit(framework_signer, 10);

        // Always trigger a reconfig event at the end of a proposal execution.
        aptos_governance::reconfigure(framework_signer);
    }
}
