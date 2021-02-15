/*

Copyright (C) 2021 Mossaab BOUDCHICHA

THIS is the LyneOS setup function,it be loaded by the bootloader at memory adress 0x0000:0x9000 (segment:offset).

This function set up the environement for the executing of the final kernel image.

*/

#include "include/boot.h"
#include "include/setup.h"


.code16


.global start


start:
    mov     %cs,%ax
    mov     %ax,%ds
    mov     %ax,%es
 # Set Video mode 80X25 text mode 
    mov    $0x00,%ah
    mov    $0x03,%al
    int    $0x10

    # reset %bx
    xor    %bx,%bx

    # we have to do carriage return before all
    mov    $0x000D,%bx
    call   print_string2

    # return to line 
    mov    $0x000A,%bx
    call   print_string2

    # Print string in the screen 
    # we have to put the adresse of the screen to print in bx
    xor    %bx,%bx
    mov    $msg_to_print,%bx 
    call   print_string

    # now we have to check the A20 line
    call check_a20

 _end_prog:   
    jmp  _end_prog
    #ljmp    $0xf000,$0xfff0 for reset
    #hlt     wait for the next interrupt

    # here if we want to load the MBR 
    # load setup to memory and jump to it
    #hlt     
    #mov     $BOOT_OFFSET,%bx  
    #mov     $SETUP_NBR_SECTORS,%di
    #mov     $0X01,%si
    #mov     $0x82,%dl
    #call    read_sectors

    # jump to setup and start execute its code
    #ljmp      $BOOT_SEG,$BOOT_OFFSET



msg_to_print: .asciz    "Setup LyneOS! \n"
msg_clear: .asciz    " "




#.fill 512-(.- msg_to_print),1,0