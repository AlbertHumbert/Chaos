#include "tty.h"

void kernel_main()
{
    terminal_initialize();
    terminal_writestring("          \n\n\n");
    terminal_writestring("          Hello, World!\n");
	terminal_writestring("          \n\n\n");
}
