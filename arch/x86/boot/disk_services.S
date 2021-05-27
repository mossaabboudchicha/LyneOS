/* 

Copyright (C) 2021 Mossaab BOUDCHICHA

Using BIOS routines as disk services: display caracters and strings 

*/

# function parameters :
# %bx : the offset in the memory where we have to load the sectors %es:%bx (%es=0x00)
# %di : the number of sectors to load 
# %si : start from sector

.code16

# read %di sectors from %si to %es:%bx


.global read_sectors 

 read_sectors:
	
	# we have to save all registers 
	pusha 

	# Using BIOS read sectors routine
	and		%di,0x0000FFFF
	and		%si,0x0000FFFF
	mov 	%di,%ax   # put the first parameter (nbr of sectors to read) in %al
	mov 	%si,%cx	  # put the second parameter (start reading sectors from) in %cl
	mov		$0x02,%ah
	movb	$0x00,%dh # the head
	movb	$0x00,%ch # the cylinder
	int     $0x13
	jc      _error_reading_carry
	cmp	    %al,0x01   # compare the number of sectors read with number of sectors we have to read
	jb      _error_reading_comp
	mov     $success_reading_msg,%bx
	call    print_string
	
_end_read_sectors:
	popa
	ret

_error_reading_carry:
	mov    $error_reading_msg_carry,%bx
	jmp    _error_reading

_error_reading_comp:
	mov    $error_reading_msg_comp,%bx
	jmp    _error_reading

_error_reading:
	call   print_string
	jmp	   _end_read_sectors

# Reset the disk controller.

.global reset_disk_controller

reset_disk_controller:
    pusha
    movw    $0x0000, %ax
    movb    $0x80, %dl
    int     $0x13
    popa
    ret


error_reading_msg_carry:	.asciz	" Error reading sector from disk (carry error) \n"

error_reading_msg_comp:	.asciz	" Error reading sector from disk comparaison \n"

success_reading_msg:	.asciz	" successfully reading sector from disk \n"
