#!/usr/bin/env python3
"""Verify each touched release bundle: integrity plus full sign-off.

Used by the verify-release-bundles job in .github/workflows/verify-release-bundles.yaml.

Reads from the environment:
  BUNDLES:      space-separated bundle directory names, as emitted by
                detect_changed_bundles.py
  RELEASE_TOOL: path to the aptos-release-tool binary
                (default: target/release/aptos-release-tool)
  NETWORKS_ROOT: path to the aptos-networks checkout containing
                framework-releases/ (default: aptos-networks)

Exits non-zero if any bundle fails; all bundles are verified and reported
before exiting. Appends a per-bundle result table to $GITHUB_STEP_SUMMARY
when set.
"""

import os
import subprocess
import sys

TOOL = os.environ.get("RELEASE_TOOL", "target/release/aptos-release-tool")
NETWORKS_ROOT = os.environ.get("NETWORKS_ROOT", "aptos-networks")

def write_summary(lines: list[str]) -> None:
    step_summary = os.environ.get("GITHUB_STEP_SUMMARY")
    if step_summary:
        with open(step_summary, "a") as f:
            f.write("\n".join(lines) + "\n")


def main() -> int:
    bundles = os.environ.get("BUNDLES", "").split()
    if not bundles:
        print("no bundles to verify")
        return 0

    summary = ["## Release bundle verification", "", "| Bundle | Result |", "|---|---|"]
    failed = []
    for name in bundles:
        bundle_dir = os.path.join(NETWORKS_ROOT, "framework-releases", name)
        print(f"::group::verify-bundle {bundle_dir}", flush=True)
        result = subprocess.run([TOOL, "verify-bundle", "--bundle", bundle_dir, "--require-signoff"])
        print("::endgroup::", flush=True)

        if result.returncode == 0:
            summary.append(f"| `{name}` | ✅ verified, signed off |")
        else:
            summary.append(f"| `{name}` | ❌ failed |")
            print(f"::error::verify-bundle --require-signoff failed for framework-releases/{name}")
            failed.append(name)

    write_summary(summary)
    if failed:
        print(f"failed bundles: {' '.join(failed)}")
        return 1
    print(f"all {len(bundles)} bundle(s) verified and signed off")
    return 0


if __name__ == "__main__":
    sys.exit(main())
