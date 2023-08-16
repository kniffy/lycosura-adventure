#!/usr/bin/env bash
set -eu

# for release, we want a tiny stripped
# and optimized file, and packed zstd
csc -o adv -O4 -fixnum-arithmetic -strip -vvv main.scm
zstd --ultra -22 -o adv.zst adv
rm adv
