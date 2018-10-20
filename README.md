##### Chaos

**write a fucking operating system**

**[see more](https://tocreate.app/2018/09/21/OperatingSystem/)**

###### build

* to complie the source files, you need a cross-compiler which generates executable i386-elf or i686-elf file


* compile a boot image based on GRUB multiboot


		sudo sh build.sh	
		
		
* if you want to run the kernel on real hardware , make sure you have GRUB2 and xorriso installed，you can run the following command to create a iso image with GRUB mutiboot header

		sudo sh  make-iso.sh
		
		
* test the iso with qemu


		qemu-system-i386 -cdrom chaos.iso


* or just simply use the following script to get it all done, it will comile the source, make an iso image, and open qemu


		 sudo sh start-qemu.sh
		

###### about now

* makefile for kernel and libc
* GRUB mutiboot iso 
* print a "Hello, World !" on screen





###### path config 

* path config works on osx 10.11.16 that might help when complie os code, gcc, grub and etc, note that you should replace with YOUR path



```
	
	#bison
	export PATH="/usr/local/opt/bison/bin:$PATH"

	#flex
	export PATH="/usr/local/opt/flex/bin:$PATH"

	#textinfo
	export PATH="/usr/local/opt/texinfo/bin:$PATH"

	#objconv
	export PATH="/Users/alberthumbert/os/build-objconv:$PATH"

	#gcc if your are using osx or you dont want a specific gcc to compile a cross gcc
	export PATH="/usr/local/Cellar/gcc/8.2.0/bin:$PATH"
	alias gcc='gcc-8'
	alias g++='g++-8'
	alias c++='c++-8'

	#cross-compile
	export PREFIX="$HOME/os/cross"
	export TARGET=i686-elf
	export PATH="$PREFIX/bin:$PATH"

	export LDFLAGS="-L/usr/local/opt/bison/lib -L/usr/local/opt/flex/lib -L/usr/local/opt/texinfo/lib "
	export CPPFLAGS="-I/usr/local/opt/flex/include"

	#grub
	export PATH="/Users/alberthumbert/os/build-grub:$PATH"
```