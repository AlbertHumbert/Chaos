#include <stdio.h>
#include <kernel/tty.h>

void kernel_main()
{
    terminal_initialize();
    puts("          \n\n\n");
    puts("          Hello, World!\n");
	puts("          \n\n\n");
    
}
