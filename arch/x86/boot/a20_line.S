/* 

Copyright (C) 2021 Mossaab BOUDCHICHA

Check A20 line and enabled it if necessary,this must be done before any access to more than 1Mb of memory

in some BIOS(s) this can be enabled ,so we have to check before 

*/

# here we have to check if the value in memory address %bx (0xFFFF:0x7E0E) == boot signature in 0x7c00+0x1FE 
# the reason of this check is that in the case of A20 line disabled ,the memory wraps after 1 Mib so that
# 0xFFFF:0x7E0E = 0x107DFE wich is higher then 1 Mib by 0x7DFE and 0x7DFE = 0x7c00+0x1FE

#include <asm/boot.h>
#include <asm/setup.h>

.code16


.global check_a20

check_a20:
	# save registers that we are going to overwrite
	pusha
	push   %ds
	push   %es
	push   %si
	push   %di
	# initialize counter to prevent infinite loop in the case that the 2 methods used to enable a20 line fail
	mov   $0x0,%cx 
	# set %es to 0xFFFF
_recheck_a20:
	mov    %cx,%ax
	cmp    $0x2,%ax
	jae    _fail_to_enable_a20
	xor    %ax,%ax
	not	   %ax
	mov    %ax,%es
	# set %bp to 0x7C00+0x200-0x2+0x10=>0x7E0E  ,final test address 0xFFFF:0x7E0E to check the memory wrap

	mov    $SIG_MEM_ADD,%bp
	cmpw   $BOOT_SIG,%es:(%bp)
	# in the case the memory wraps si the a20 gate is disabled, we have to enable a20 line 
	je	   _enable_a20
	mov	   $a20_enabled_msg,%bx
	call   print_string
	jmp    _exit_a20


_enable_a20:
	# use 2 methods to ensure that the gate will be enabled
	call _ps2_enable_a20
	call _fast_a20gate_enable_a20
	inc  %cx
	jmp  _recheck_a20

# Enable the A20 line (gate) if disabled using 8042 PS/2 Controller (sometimes refer to it as Keyboard controller)
_ps2_enable_a20:
	# disable interrupts here
	cli
	# save the state of registers
	pusha
	call  _wait_until_ready_a20
	call  _disable_keyboard
	call  _wait_until_ready_a20
	call  _read_data_cmd
	call  _wait_until_ready_a20_read
	call  _read_data
	# save the data read in the stack
	push  %ax
	call  _wait_until_ready_a20
	call  _write_data_cmd
	# restore the data from the stack to modify it and write it to PS2 controller again to enable A20 line
	pop   %ax
	call  _write_data
	call  _wait_until_ready_a20
	call  _enable_keyboard
	popa
	# enable interrupts
	sti
	ret

# Enable the A20 line (gate) if disabled using FAST A20 gate
_fast_a20gate_enable_a20:
	push %ax	
	inb	 $FAST_A20_GATE_PORT,%al
	orb  $0x2,%al  # set bit 1
	outb %al,$FAST_A20_GATE_PORT
	pop  %ax
	ret


_wait_until_ready_a20:
	inb	 $PS2_STATUS_PORT,%al
	test %al,0x2	# the second bit have to be clear to indicate that input is ready to accept command
	jnz  _wait_until_ready_a20
	ret

_wait_until_ready_a20_read:
	inb	 $PS2_STATUS_PORT,%al
	test %al,0x1	# the first bit have to be set to indicate that output have data to read
	jz  _wait_until_ready_a20_read
	ret

_disable_keyboard:
	mov	  $DISABLE_KEYBOARD,%al
	outb  %al,$PS2_CMD_PORT
	ret

_enable_keyboard:
	mov	  $ENABLE_KEYBOARD,%al
	outb  %al,$PS2_CMD_PORT
	ret

_read_data_cmd:
	mov	  $READ_PS2_OUTPUT,%al
	outb  %al,$PS2_CMD_PORT
	ret

_write_data_cmd:
	mov	  $WRITE_PS2_OUTPUT,%al
	outb  %al,$PS2_CMD_PORT
	ret

_read_data:
	# read the data
	inb	  $PS2_DATA_PORT,%al
	ret

_write_data:
	# get the data from the stack
	#pop   %ax
	orb  $0x2,%al  # set bit 1
	outb  %al,$PS2_DATA_PORT
	ret


_fail_to_enable_a20:
	mov	   $a20_fail_enable_msg,%bx
	call   print_string
_die_a20:
	hlt
	jmp    _die_a20


_exit_a20:
    # retore registers before return
	pop  %di
	pop  %si
	pop  %es
	pop  %ds 
	popa
	ret

a20_enabled_msg:  .asciz    " A20 line is already enabled!"
a20_fail_enable_msg:  .asciz    " Fail to enable A20 line!"






