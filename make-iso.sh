#!/bin/sh
set -e
. ./build.sh

mkdir -p isodir
mkdir -p isodir/boot
mkdir -p isodir/boot/grub

cp sysroot/boot/chaos.kernel isodir/boot/chaos.kernel
cat > isodir/boot/grub/grub.cfg << EOF
menuentry "chaos" {
	multiboot /boot/chaos.kernel
}
EOF
grub-mkrescue -o chaos.iso isodir

