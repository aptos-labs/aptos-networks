script {
    use aptos_framework::aptos_governance;
    use std::features;

    fun main(account: &signer) {
        let framework_signer = aptos_governance::get_signer_testnet_only(account, @0x1);
        features::change_feature_flags(&framework_signer, vector[1, 2], vector[]);
    }
}
