script {
    use aptos_framework::aptos_governance;
    use aptos_framework::storage_gas::{new_gas_curve, new_storage_gas_config, new_usage_gas_config};
    use aptos_framework::gas_schedule::set_storage_gas_config;

    fun main(account: &signer) {
        let k: u64 = 1000;
        let m: u64 = 1000 * 1000;

        let item_config = new_usage_gas_config(
            2 * k * m, // 2 billion
            new_gas_curve(300 * k, 300 * k, vector[]),
            new_gas_curve(5 * m, 5 * m, vector[]),
            new_gas_curve(300 * k, 300 * k, vector[]),
        );
        let byte_config = new_usage_gas_config(
            1 * m * m, // 1TB
            new_gas_curve(300, 300, vector[]),
            new_gas_curve(5 * k, 5 * k, vector[]),
            new_gas_curve(5 * k, 5 * k, vector[]),
        );
        let config = new_storage_gas_config(item_config, byte_config);

        let framework_signer = aptos_governance::get_signer_testnet_only(account, @0x1);
        set_storage_gas_config(&framework_signer, config);
    }
}