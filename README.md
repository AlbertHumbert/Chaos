##### Chaos

**write a fucking operating system**

**[see more](https://tocreate.app/2018/09/21/OperatingSystem/)**

###### build

* to complie the source files, you need a cross-compiler which generates executable i386-elf or i686-elf file

* compile a boot image based on GRUB multiboot


		cd src;zsh build.sh	


* you can use qemu to run the image in /build


		qemu-system-i386 -kernel chaos.elf	
		

###### about now

* simple build script
* bootable image in elf format
* print a "Hello, World !" on screen