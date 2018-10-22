#include <stdio.h>
#include <kernel/tty.h>

int putchar(int ic){
    terminal_putchar((char)ic);
    return ic;
}
