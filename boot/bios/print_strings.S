/* 

Copyright (C) 2021 Mossaab BOUDCHICHA

Using BIOS routines as display services: display caracters and strings 

*/

# function parameters :
# %bx : the address of the first caracter to print

.code16

.global print_string

print_string:
    # its allways best practices to ensure that no register has to be changed in function calls
    pusha
	# go to print the string 
    mov    $0xe,%ah
    mov     %bx,%si

_print_char:
    lodsb
    andb    %al,%al
    jz      _end_print
    int     $0x10
    jmp    _print_char

_end_print: 
    # restore all registers before return
    popa
    ret

.global print_string2
# print string in bx but with hexadecimal numbers 
print_string2:
    pusha
    mov %bl,%al
    mov $0x07,%bx
    mov $0x0e,%ah
    int $0x10
_end_print2:
    popa
    ret
