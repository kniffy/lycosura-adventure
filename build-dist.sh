#!/usr/bin/env sh

# for release, we want a tiny stripped
# and optimized file, and packed zstd
csc -o adv -O4 -fixnum-arithmetic -strip -debug-level 0 -vvv main.scm
zstd --ultra -22 -o adv.zst adv
rm adv
