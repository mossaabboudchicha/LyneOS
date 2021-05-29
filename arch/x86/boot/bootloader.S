/* 

Copyright (C) 2021 Mossaab BOUDCHICHA

THIS is the LyneOS bootloader,The BIOS load this code at memory address 0x7c00 and jump to it
This code will be executed in real mode,it will load the kernel setup at memory address 
0x9000:0x00 (segment:offset) and jump to it.

*/

#include <asm/boot.h>

# code16 to indicate that this program will run in real mode 
.code16

.text
#specify the entry point of the program (default entry point name as expected by GCC linker)
.global _start

 _start:
    ljmp    $BOOT_SEG,$start


 start:
    # good practice to setup segment registers and the stack 
    cli
    movw    %cs,%ax
    movw    %ax,%ds
    movw    %ax,%es
    movw    %ax,%ss
    mov     $STACK_OFFSET,%sp
    sti
    push    %dx         # we have to save this register,it contain the load drive number 
    # print loading message
    lea     start_msg,%bx
    call    print_string

    # set segment registers to 0x7c00
    xor     %ax,%ax
    mov     %cs,%ax
    mov     %ax,%ds
    
    # load setup in the memory using BIOS read sectors routine  
    mov     $SETUP_SEG,%ax
    push    %ax
    pop     %es
    mov     %ax,%fs
    xor     %ax,%ax

    # load setup to memory and jump to it
    # we have to get the nbr of bytes in the setup,here we have to basing on linker symbols
    mov     $SETUP_OFFSET,%bx  
    mov     $SETUP_NBR_SECTORS,%di
    mov     $SETUP_START_SECTOR,%si
    pop     %dx
    call    read_sectors

    # jump to setup and start execute its code
    ljmp      $SETUP_SEG,$SETUP_OFFSET

_end_boot_sector:
    # we have not to return from setup but if it is the case we have to handle that
    jmp     _end_boot_sector

.include "print_strings.S"
.include  "disk_services.S"

# Message to print in OS
start_msg : .string   " Loading LyneOS kernel....\n"

#.fill 510-(.- main),1,0
.space 0x1FE - (. - _start)

.word BOOT_SIG









