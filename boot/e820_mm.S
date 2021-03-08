/* 

Copyright (C) 2021 Mossaab BOUDCHICHA

Detect memory using BIOS routines and put it in apropriate data structure 

*/


.code16 

.global detect_lowmem

detect_lowmem:
	pusha
	clc
	int   $0x12
	jc	  _fail_to_detect_mem
	mov    $success_detect_low_msg,%bx 
    call   print_string
_return_to_call:
    popa
    ret

_fail_to_detect_mem:
	mov    $fail_detect_low_msg,%bx 
    call   print_string
    jmp    _return_to_call
	



success_detect_low_msg :   .asciz  " Detecting low memory successfully proceed" 
fail_detect_low_msg :   .asciz  " Failed to detect low memory" 


