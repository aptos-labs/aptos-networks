/// This proposal disables module publishing, including upgrades.
script {
    use aptos_framework::aptos_governance;
    use aptos_framework::code;

    fun main(proposal_id: u64) {
        let framework_signer = &aptos_governance::resolve(proposal_id, @aptos_framework);
        // Can change to true to re-enable module publishing.
        code::set_publish_allowed(framework_signer, false);

        // End the epoch so the change is synchronized.
        aptos_governance::reconfigure(framework_signer);
    }
}
