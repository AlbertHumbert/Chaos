i686-elf-as ./src/start.s -o ./build/start.o
i686-elf-gcc -std=gnu99 -ffreestanding -g -c ./src/kernel.c -o ./build/kernel.o
i686-elf-gcc -std=gnu99 -ffreestanding -g -c ./src/tty.c -o ./build/tty.o
i686-elf-gcc -ffreestanding -nostdlib -g -T ./src/linker.ld ./build/start.o ./build/kernel.o ./build/tty.o -o ./build/chaos.bin -lgcc
