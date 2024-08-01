script {
    use aptos_framework::aptos_governance;
    use aptos_framework::jwks;

    fun main(core_resources: &signer) {
        let core_signer = aptos_governance::get_signer_testnet_only(core_resources, @0x1);
        let framework_signer = &core_signer;
        jwks::upsert_oidc_provider(framework_signer, b"https://accounts.google.com", b"https://accounts.google.com/.well-known/openid-configuration");
        jwks::upsert_oidc_provider(framework_signer, b"https://www.facebook.com", b"https://www.facebook.com/.well-known/openid-configuration");
        aptos_governance::reconfigure(framework_signer);
    }
}
