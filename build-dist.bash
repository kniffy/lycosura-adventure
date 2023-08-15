#!/usr/local/bin/bash
set -eu

# for release, we want a tiny stripped
# and optimized file, and packed zstd
csc -o adv -O5 -strip main.scm
zstd -19 -o adv.zst adv
rm adv
