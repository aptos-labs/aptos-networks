script {
    use aptos_framework::aptos_governance;
    use aptos_framework::stake;

    fun main(account: &signer) {
        let framework_signer = aptos_governance::get_signer_testnet_only(account, @0x1);
        let to_remove = vector[
            @0xc6c05a6b6aadf6c327244dcd0cae8ed808291c11dd8fff92c8387af0daf01869,
            @0xf7c045f174d8527bd300eb5e9e84fb6db43a9e80190f7b9597db095fa0995658,
            @0x3371dabee976bb94ac1b2e6c1c12fa7233ef004b358aa057661aa1bdf81fa13f,
            @0x6057d69013e3c00ca1e12b1526fa28f3265072cb88b67e7dafc59394ce865e0a,
            @0x682ca3a63ee7787220893b63c8675e6c8fd275ca6885a7bf5c04d3a72f3d872d,
            @0xbd2d5cb253a3ae97ee84039b34ec753c3bca038a41ab953b9f6df4ac38bf7d35,
            @0xc4a5af5fa6c1ae769157675c8fbe55c49e2cbd7ce89a8dec5f09a6ced957568d,
            @0x0346d9c515ef825ddfbe81cdd0123c0edd46c38467d334a184eae255e6397ee1,
            @0x6efb5440bcf2b65ba14f66eb5f03eeb9054287428c3644a13f50683933efa737,
            @0x750a7e5997bcb7cc87917880524d91c7a59847801b6fe0a8d2c632c0a10c9441,
            @0xb002aa58adac6cb37afe14ccc2c1697e1a2be2b2f1dd5163006fa4d0a830fd01,
            @0x19105a85b8d455e51a1b0f917dbb2464d47c47a325c20e5aaa64916299e06aa4,
            @0x5745700038ec507e6262e02507a0f706b2deb8bfe5620db830be3d0790074e9b,
            @0x6bda6b1f16c5bfb2493a6e95782ba983dd5027d79057f49b44a051facf952544,
            @0x352eb70e6ae3f13fd132bb56a79ddaa8b1ce41e4f26f3a8dc058c737728dc474,
        ];
        stake::remove_validators(&framework_signer, &to_remove);
        aptos_governance::reconfigure(&framework_signer);
    }
}
