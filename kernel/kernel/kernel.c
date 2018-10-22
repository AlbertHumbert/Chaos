#include <stdio.h>
#include <kernel/tty.h>

void kernel_main()
{
    terminal_initialize();
    printf("          \n\n\n");
    printf("          Hello, World!\n");
	printf("          \n\n\n");
    
}
