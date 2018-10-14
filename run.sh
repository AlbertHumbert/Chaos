mkdir build
source ./build.sh
mkdir -p isodir/boot/grub
cp build/chaos.bin isodir/boot/chaos.bin
cp src/grub.cfg isodir/boot/grub/grub.cfg
grub-mkrescue -o ./build/chaos.iso isodir
qemu-system-i386 -cdrom ./build/chaos.iso
