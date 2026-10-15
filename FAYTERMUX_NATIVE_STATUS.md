# FayTermux native packages fork

This branch is an experimental fork of Termux's package build system for
Android application ID `com.fay.termux`.

## Identity

`scripts/properties.sh` now sets `TERMUX_APP__PACKAGE_NAME` to
`com.fay.termux`. The upstream properties code derives the private app
directory and prefix from this value. This is **not** yet a tested bootstrap.

## Build and release checklist

1. Run upstream property validation and build tooling in a supported Linux/Docker build environment.
2. Build a minimal apt-android-7 bootstrap for each architecture: aarch64, arm, i686, x86_64.
3. Ensure all ELF interpreter paths, shebangs, scripts, configuration files, and embedded prefixes match `/data/data/com.fay.termux/files/usr`.
4. Publish checksummed bootstrap archives and a signed apt repository built for the same prefix.
5. Validate artifacts with `FayTermux/scripts/verify_fay_bootstrap_release.py`.
6. Update the app fork's Gradle download and identity settings only after verified artifacts exist.
7. Install alongside official Termux and run package manager smoke tests.

## Important caveats

- A renamed app without its own compatible native binaries cannot safely use official Termux bootstraps.
- Bootstrap checksums, download URLs, and package repository signing keys must be obtained from actual builds, never fabricated.
- This branch has not yet built or released any bootstrap archives.
