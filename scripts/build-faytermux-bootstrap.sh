#!/usr/bin/env bash
# Build a FayTermux-native bootstrap with upstream's source build machinery.
# Run from a Linux host with Docker installed; do not run inside Android Termux.
set -euo pipefail
cd "$(dirname "$0")/.."
ARCH="${1:-aarch64}"
case "$ARCH" in aarch64|arm|i686|x86_64) ;; *) echo "Unsupported ABI: $ARCH" >&2; exit 2;; esac

# Verify that the native source tree targets FayTermux before any compilation.
grep -q '^TERMUX_APP__PACKAGE_NAME="com.fay.termux"$' scripts/properties.sh || {
  echo "Wrong native package identity; refusing to build" >&2; exit 1;
}
command -v docker >/dev/null || { echo "Docker required" >&2; exit 1; }
echo "Building FayTermux bootstrap for $ARCH (this can take a long time)."
./scripts/run-docker.sh ./scripts/build-bootstraps.sh -f --architectures "$ARCH"
test -s "bootstrap-$ARCH.zip" || { echo "No bootstrap archive produced" >&2; exit 1; }
sha256sum "bootstrap-$ARCH.zip"
echo "Built bootstrap-$ARCH.zip; verify prefix, archive contents and runtime before release."
