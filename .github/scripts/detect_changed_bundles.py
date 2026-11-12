#!/usr/bin/env python3
"""Detect release bundle directories (framework-releases/<version>/) touched by a PR.

Used by the detect-bundle-changes job in
.github/workflows/verify-release-bundles.yaml. Must run inside a checkout of
the PR's merge result, with full history fetched.

Reads from the environment:
  BASE_SHA / HEAD_SHA: the PR's base and head commits. The diff uses
      BASE...HEAD (merge-base), so a stale PR is not blamed for bundles that
      landed on the base branch after it diverged.

Emits GitHub Actions step outputs (appended to $GITHUB_OUTPUT, or printed to
stdout when run locally):
  any:     "true" if at least one touched bundle still exists in the merge
           result (a directory absent from it was deleted by the PR; there is
           nothing left to verify)
  bundles: the touched bundle directory names, space-separated, sorted

Fails (exit 1) on a file sitting directly under framework-releases/ (bundles
are directories), or on a bundle directory name outside the allowed character
set.
"""

import os
import re
import subprocess
import sys

BUNDLE_BASE = "framework-releases"

NAME_RE = re.compile(r"^[A-Za-z0-9][A-Za-z0-9._-]*$")


def fail(message: str) -> None:
    print(f"::error::{message}")
    sys.exit(1)


def write_output(key: str, value: str) -> None:
    github_output = os.environ.get("GITHUB_OUTPUT")
    if github_output:
        with open(github_output, "a") as f:
            f.write(f"{key}={value}\n")
    else:
        sys.stdout.write(f"{key}={value}\n")


def main() -> int:
    base = os.environ["BASE_SHA"]
    head = os.environ["HEAD_SHA"]

    # -z: NUL-separated, unquoted paths, so unusual file names arrive verbatim.
    diff = subprocess.run(
        ["git", "diff", "--name-only", "-z", f"{base}...{head}", "--", f"{BUNDLE_BASE}/"],
        check=True,
        capture_output=True,
        text=True,
    )
    paths = [p for p in diff.stdout.split("\0") if p]

    dirs = set()
    for path in paths:
        rest = path[len(BUNDLE_BASE) + 1 :]
        name, sep, _ = rest.partition("/")
        if not sep:
            fail(
                f"stray file directly under {BUNDLE_BASE}/: {path};"
                f" bundles are directories ({BUNDLE_BASE}/<version>/...)"
            )
        if not NAME_RE.match(name):
            fail(f"bundle directory name {name!r} contains unsupported characters")
        dirs.add(name)

    existing = []
    for name in sorted(dirs):
        if os.path.isdir(os.path.join(BUNDLE_BASE, name)):
            existing.append(name)
        else:
            print(f"bundle '{name}' is deleted by this PR; nothing to verify")

    write_output("any", "true" if existing else "false")
    write_output("bundles", " ".join(existing))
    print(f"changed bundles: {' '.join(existing) or 'none'}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
