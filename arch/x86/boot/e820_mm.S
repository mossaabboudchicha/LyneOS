/* 

Copyright (C) 2021 Mossaab BOUDCHICHA

Detect memory using BIOS routines and put it in apropriate data structure 

*/

#include <asm/e820.h>

.code16 

.global detect_lowmem

detect_lowmem:
	pusha
	clc
	int   $0x12
	jc	  _fail_to_detect_low_mem
	mov    $success_detect_low_msg,%bx 
    call   print_string


_return_to_call:
    popa
    ret

_fail_to_detect_low_mem:
	mov    $fail_detect_low_msg,%bx 
    call   print_string
    jmp    _return_to_call

.global detect_heighmem

detect_heighmem:

	pusha
	mov    %ds,%ax
	mov    %ax,%es
	mov    $E820Map,%di
	xor    %ebx,%ebx
	mov    %ebx,(E820Nr)

_continue_detect_high:
	mov    $E820Magic,%edx
	mov    $E820EntrySize,%ecx
	mov    $0xE820,%eax
	andw   $0xFFFF,%ax 
	int    $0x15   
	cmp    $E820Magic,%eax
	jne    _fail_to_detect_high_mem
	jc	   _fail_to_detect_high_mem
	cmp	   $0x0000,%ebx
	je     success_detect_high_mem

	# check if we have reached the max number of entries 
	mov   (E820Nr),%al
	cmp   $E820Max,%al
	je 	  success_detect_high_mem
	incb  (E820Nr)
	# now we have to increment the di by the size of the entry to add the next entry
	mov	   %di,%ax
	add    $E820EntrySize,%ax
	mov    %ax,%di
	jmp    _continue_detect_high

success_detect_high_mem:	
	mov    $success_detect_high_msg,%bx 
    call   print_string
    jmp   _return_to_call

_fail_to_detect_high_mem:
	mov    $fail_detect_high_msg,%bx 
    call   print_string
    jmp    _return_to_call
	



success_detect_low_msg :   .asciz  " Detecting low memory successfully proceed" 
success_detect_high_msg :   .asciz  " Detecting high memory successfully proceed" 
fail_detect_low_msg :   .asciz  " Failed to detect low memory" 
fail_detect_high_msg :   .asciz  " Failed to detect high memory" 



