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

    #initialize counter of check of the setup load
    xor     %cx,%cx
    #check that the bootloader loaded this setup file correctly in memory
_check_good_load:
    cmpw    $SETUP_SIG1,setup_check_sig1
    jne     _bad_setup_load
    cmpw    $SETUP_SIG2,setup_check_sig2
    jne     _bad_setup_load
    jmp     _good_setup_load

_bad_setup_load:
    cmp     $0x0,%cx
    ja      _final_bad_setup_load  
    inc     %cx
    # setup file have > 1 sector loaded by the bootloader,we have to load the remaining sectors
    # before continue
    # get the remaining sectors to load,here we have to use symbols from setup linker script ,
    # because at this stage we can't know the size of setup file,only linker script know
    xor     %ax,%ax
    mov     $_esetup,%ax
    sub     $_ssetup,%ax
    # we have to exclude the already loaded bytes (1 sector) by the bootloader
    sub     $LOADED_SETUP_BYTES,%ax
    mov     $SETUP_OFFSET+SECTOR_SIZE,%bx
    mov     $SETUP_START_SECTOR+0x1,%si
    shr     $SECTOR_SHIFT,%ax
    add     $0x1,%ax
    mov     %ax,%di
    call    read_sectors
    jmp     _check_good_load

_final_bad_setup_load:
    mov     $bad_setup_load_msg,%bx 
    call    print_string
    jmp     _end_prog

_good_setup_load:
    # Reset the disk controller.
    call    reset_disk_controller
    
    # Set Video mode 80X25 text mode 
    call    set_80X25_video_mode

    # Print string in the screen 
    # we have to put the adresse of the screen to print in bx
    xor    %bx,%bx
    mov    $msg_to_print,%bx 
    call   print_string

    # now we have to check the A20 line
    call   check_a20

    # now we have to detect memory
    call   detect_lowmem 

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



msg_to_print: .asciz    " LyneOS kernel Initialization...\n"
msg_clear: .asciz    " "
bad_setup_load_msg: .asciz " Error loading setup file...!"



#.fill 512-(.- msg_to_print),1,0