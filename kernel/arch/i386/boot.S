/* Normal segment */
#define SEG_NULLASM                                         \
.word 0, 0;                                                 \
.byte 0, 0, 0, 0

#define SEG_ASM(type,base,lim)                              \
.word (((lim) >> 12) & 0xffff), ((base) & 0xffff);          \
.byte (((base) >> 16) & 0xff), (0x90 | (type)),             \
(0xC0 | (((lim) >> 28) & 0xf)), (((base) >> 24) & 0xff)

/* Application segment type bits */
#define STA_X       0x8     // Executable segment
#define STA_E       0x4     // Expand down (non-executable segments)
#define STA_C       0x4     // Conforming code segment (executable only)
#define STA_W       0x2     // Writeable (non-executable segments)
#define STA_R       0x2     // Readable (executable segments)
#define STA_A       0x1     // Accessed


# Create multiboot header, which requested by GRUB
# Declare constants for the multiboot header.
.set ALIGN,    1<<0             # align loaded modules on page boundaries
.set MEMINFO,  1<<1             # provide memory map
.set FLAGS,    ALIGN | MEMINFO  # this is the Multiboot 'flag' field
.set MAGIC,    0x1BADB002       # 'magic number' lets bootloader find the header
.set CHECKSUM, -(MAGIC + FLAGS) # checksum of above, to prove we are multiboot

# Declare a header as in the Multiboot Standard.
.section .multiboot
.align 4
.long MAGIC
.long FLAGS
.long CHECKSUM

# Reserve a stack for the initial thread
.section .bss
.align 16
stack_bottom:
.skip 16384 # 16 KiB
stack_top:

.section .data
.set PROT_MODE_CSEG,        0x8                     # kernel code segment selector
.set PROT_MODE_DSEG,        0x10                    # kernel data segment selector
.set CR0_PE_ON,             0x1                     # protected mode enable flag


# Bootstrap GDT
.p2align 2                                          # force 4 byte alignment
gdt:
SEG_NULLASM                                     # null seg
SEG_ASM(STA_X|STA_R, 0x0, 0xffffffff)           # code seg for bootloader and kernel
SEG_ASM(STA_W, 0x0, 0xffffffff)                 # data seg for bootloader and kernel

gdtdesc:
.word 0x17                                      # sizeof(gdt) - 1
.long gdt                                       # address gdt
.section .text

.globl _start
.type _start, @function

_start:

mov $stack_top, %esp
call _init

cli                                             # Disable interrupts


                                                # String operations increment

# Set up the important data segment registers (DS, ES, SS).
xorw %ax, %ax                                   # Segment number zero
movw %ax, %ds                                   # -> Data Segment
movw %ax, %es                                   # -> Extra Segment
#movw %ax, %ss                                   # -> Stack Segment


# Enable A20:
#  For backwards compatibility with the earliest PCs, physical
#  address line 20 is tied low, so that addresses higher than
#  1MB wrap around to zero by default. This code undoes this.
seta20.1:
inb $0x64, %al                                  # Wait for not busy(8042 input buffer empty).
testb $0x2, %al
jnz seta20.1

movb $0xd1, %al                                 # 0xd1 -> port 0x64
outb %al, $0x64                                 # 0xd1 means: write data to 8042's P2 port

seta20.2:
inb $0x64, %al                                  # Wait for not busy(8042 input buffer empty).
testb $0x2, %al
jnz seta20.2


movb $0xdf, %al                                 # 0xdf -> port 0x60
outb %al, $0x60                                 # 0xdf = 11011111, means set P2's A20 bit(the 1 bit) to 1

# Switch from real to protected mode, using a bootstrap GDT
# and segment translation that makes virtual addresses
# identical to physical addresses, so that the
# effective memory map does not change during the switch.
lgdt gdtdesc
movl %cr0, %eax
orl $CR0_PE_ON, %eax
movl %eax, %cr0


# Jump to next instruction, but in 32-bit code segment.
# Switches processor into 32-bit mode.
ljmp $PROT_MODE_CSEG, $protcseg
.code32                                        # Assemble for 32-bit mode
protcseg:
# Set up the protected-mode data segment registers
movw $PROT_MODE_DSEG, %ax                       # Our data segment selector
movw %ax, %ds                                   # -> DS: Data Segment
movw %ax, %es                                   # -> ES: Extra Segment
movw %ax, %fs                                   # -> FS
movw %ax, %gs                                   # -> GS
movw %ax, %ss                                   # -> SS: Stack Segment

# Set up the stack pointer and call into C. The stack region is from 0--start(0x7c00)
movl $0x0, %ebp
movl $_start, %esp

call kernel_main
spin:
jmp spin
# If bootmain returns (it shouldn't), loop.



