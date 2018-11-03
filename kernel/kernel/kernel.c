#include <stdio.h>
#include <kernel/tty.h>
#include <kernel/gdt.h>

void kernel_main()
{
    create_gdt();
    terminal_initialize();
    printf("          \n\n\n");
    printf("          Hello, World!\n");
	printf("          \n\n\n");
    
}
