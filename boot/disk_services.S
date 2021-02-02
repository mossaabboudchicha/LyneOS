
# disk services : read sector(s) to memory/write sector(s) from memory

.code16

# read %di sectors from %si to %es:%bx

.global __read_sectors 

__read_sectors:
	
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
	jc      __error_reading_carry
	cmp	    %al,0x01   # compare the number of sectors read with number of sectors we have to read
	jb      __error_reading_comp
	mov    $success_reading_msg,%bx
	call   __print_string
	
__end_read_sectors:
	popa
	ret

__error_reading_carry:
	mov    $error_reading_msg_carry,%bx
	jmp    __error_reading

__error_reading_comp:
	mov    $error_reading_msg_comp,%bx
	jmp    __error_reading

__error_reading:
	call   __print_string
	jmp	   __end_read_sectors


	# Here we have to include print_strings 
    .include "../commun_lib/print_strings.S"


error_reading_msg_carry:	.asciz	"Error reading sector from disk carry \n"

error_reading_msg_comp:	.asciz	"Error reading sector from disk comparaison \n"

success_reading_msg:	.asciz	"successfully reading sector from disk \n"
