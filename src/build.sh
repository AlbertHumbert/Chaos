i686-elf-gcc -std=gnu99 -ffreestanding -g -c start.s -o ../build/start.o
i686-elf-gcc -std=gnu99 -ffreestanding -g -c kernel.c -o ../build/kernel.o
i686-elf-gcc -std=gnu99 -ffreestanding -g -c tty.c -o ../build/tty.o
i686-elf-gcc -ffreestanding -nostdlib -g -T linker.ld ../build/start.o ../build/kernel.o ../build/tty.o -o ../build/chaos.elf -lgcc
