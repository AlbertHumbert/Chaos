[BITS 16]




lgdt [eax]      ; load gdt code selector

cli             ; unable interrupts


in al, 92h      ; enable A20
or al, 00000010b
out 92h, al


mov eax, cr0    ; enter protected mode
or eax, 1
mov cr0, eax


