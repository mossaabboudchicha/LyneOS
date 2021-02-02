/*

Copyright (C) 2021 Mossaab BOUDCHICHA

THIS is the LyneOS setup function,this code will first kernel code to be executed,
it be will be loaded by the bootloader at memory adress 0x9000:0x00 (segment:offset).

This function set up the environement for the executing of the final kernel image by doing the following :

*/

.code16


.global __start

__start:
    mov     %cs,%ax
    mov     %ax,%ds
    mov     %ax,%es
 # Set Video mode 80X25 text mode 
    mov    $0x00,%ah
    mov    $0x03,%al
    int    $0x10

    # Change the color in the screen
    mov    $0x0B,%ah
    mov    $0x00,%bh
    mov    $0x01,%bl
    int    $0x10

    # reset %bx
    xor    %bx,%bx
    # we have to do carriage return before all
    mov    $0x000D,%bx
    call   __print_string2
    # return to line 
    mov    $0x000A,%bx
    call   __print_string2
    # Print string in the screen 
    # we have to put the adresse of the screen to print in bx
    xor    %bx,%bx
    mov    $msg_to_print,%bx 
    call   __print_string

_end_prog:
    
    jmp _end_prog
    
    # Here we have to include print_strings 
    .include "../commun_lib/print_strings.S"

msg_to_print: .asciz    "Setup LyneOS! \n"
msg_clear: .asciz    " "

.fill 512-(.- msg_to_print),1,0