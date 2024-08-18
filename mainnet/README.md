# Mainnet waypoints

This directory contains the genesis blob and waypoints for Mainnet. There are currently two waypoints available:
- `genesis_waypoint.txt`: The genesis waypoint, i.e., the waypoint for the genesis transaction at version `0`.
- `waypoint.txt`: A recent waypoint taken at version `1638030465`, epoch `8150`, on `07/17/2024`.

For operators running Mainnet nodes, we recommend using the most recent waypoint (this is the default selection
when following the developer documentation at: [aptos.dev](https://aptos.dev/en)). Using the most recent waypoint
will help to improve the security of your node (e.g., by preventing long-range attacks), and allow it to select
the most optimal syncing target when bootstrapping (improving syncing efficiency).
