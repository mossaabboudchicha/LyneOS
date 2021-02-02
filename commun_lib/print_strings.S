.global __print_string
# print string in bx
__print_string:
    # its allways best practices to ensure that no register has to be changed in function calls
    pusha
	# go to print the string 
    mov    $0xe,%ah
    mov     %bx,%si

__print_char:
    lodsb
    andb    %al,%al
    jz      __end_print
    int     $0x10
    jmp    __print_char

__end_print: 
    # restore all registers before return
    popa
    ret

.global __print_string2
# print string in bx but with hexadecimal numbers 
__print_string2:
    pusha
    mov %bl,%al
    mov $0x07,%bx
    mov $0x0e,%ah
    int $0x10
__end_print2:
    popa
    ret
