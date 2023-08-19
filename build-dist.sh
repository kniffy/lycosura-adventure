#!/usr/bin/env sh

# for release, we want a tiny stripped
# and optimized file, and packed zstd
echo 'did you strip the pos command, and the load text.scm thing'
echo 'if this is gold, youre using the wrong build steps'
sleep 10
csc -O4 -fixnum-arithmetic -strip -debug-level 0 -vvv -c text.scm
csc -O4 -fixnum-arithmetic -strip -debug-level 0 -vvv -c main.scm
csc -o adv -O4 -fixnum-arithmetic -strip -debug-level 0 -vvv main.o text.o
zstd --ultra -22 -o adv.zst adv
rm adv main.o text.o
