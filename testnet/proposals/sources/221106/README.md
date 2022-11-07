This update removes a handful of validators from the validator set due to lack of participation:

at roughly 7:15 PM on 11/06/2022:

`aptos node analyze-validator-performance --analyze-mode=all --url=https://fullnode.testnet.aptoslabs.com/v1 --start-epoch=-12`

produced the following non-participating nodes:

```
53         |  0.05%     | 100.000%   | 0          | 53         | 0          | 0          | c6c05a6b6aadf6c327244dcd0cae8ed808291c11dd8fff92c8387af0daf01869
53         |  0.05%     | 100.000%   | 0          | 53         | 0          | 0          | f7c045f174d8527bd300eb5e9e84fb6db43a9e80190f7b9597db095fa0995658
15         |  0.01%     | 100.000%   | 0          | 15         | 0          | 0          | 3371dabee976bb94ac1b2e6c1c12fa7233ef004b358aa057661aa1bdf81fa13f
4          |  0.00%     | 100.000%   | 0          | 4          | 0          | 0          | 6057d69013e3c00ca1e12b1526fa28f3265072cb88b67e7dafc59394ce865e0a
4          |  0.00%     | 100.000%   | 0          | 4          | 0          | 0          | 682ca3a63ee7787220893b63c8675e6c8fd275ca6885a7bf5c04d3a72f3d872d
4          |  0.00%     | 100.000%   | 0          | 4          | 0          | 0          | bd2d5cb253a3ae97ee84039b34ec753c3bca038a41ab953b9f6df4ac38bf7d35
4          |  0.00%     | 100.000%   | 0          | 4          | 0          | 0          | c4a5af5fa6c1ae769157675c8fbe55c49e2cbd7ce89a8dec5f09a6ced957568d
3          |  0.00%     | 100.000%   | 0          | 3          | 0          | 0          | 0346d9c515ef825ddfbe81cdd0123c0edd46c38467d334a184eae255e6397ee1
3          |  0.00%     | 100.000%   | 0          | 3          | 0          | 0          | 6efb5440bcf2b65ba14f66eb5f03eeb9054287428c3644a13f50683933efa737
3          |  0.00%     | 100.000%   | 0          | 3          | 0          | 0          | 750a7e5997bcb7cc87917880524d91c7a59847801b6fe0a8d2c632c0a10c9441
3          |  0.00%     | 100.000%   | 0          | 3          | 0          | 0          | b002aa58adac6cb37afe14ccc2c1697e1a2be2b2f1dd5163006fa4d0a830fd01
2          |  0.00%     | 100.000%   | 0          | 2          | 0          | 0          | 19105a85b8d455e51a1b0f917dbb2464d47c47a325c20e5aaa64916299e06aa4
2          |  0.00%     | 100.000%   | 0          | 2          | 0          | 0          | 5745700038ec507e6262e02507a0f706b2deb8bfe5620db830be3d0790074e9b
1          |  0.00%     | 100.000%   | 0          | 1          | 0          | 0          | 6bda6b1f16c5bfb2493a6e95782ba983dd5027d79057f49b44a051facf952544
0          |  0.00%     |     NaN%   | 0          | 0          | 0          | 0          | 352eb70e6ae3f13fd132bb56a79ddaa8b1ce41e4f26f3a8dc058c737728dc474
```
