#include <stdio.h>

//todo print with base
int print_int(int num){
    
    static char * digits = "0123456789";
    char buf[16];
    int sub =  num;
    int count = 0;

    //get print buf
    while(sub!=0){
        buf[count]='0'+(sub%10);
        sub/=10;
        count++;
    }

    //vga print
    for(int i = 0;i<16;i++){
        putchar(buf[i]);
    }
}

int printf(const char * format, ...){
    return 0;
}
