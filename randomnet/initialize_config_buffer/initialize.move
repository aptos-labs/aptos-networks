script {
    use aptos_framework::aptos_governance;
    use aptos_framework::config_buffer;

    fun main(core_resources: &signer) {
        let framework_signer = aptos_governance::get_signer_testnet_only(core_resources, @0x1);
        config_buffer::initialize(&framework_signer)
    }
}
