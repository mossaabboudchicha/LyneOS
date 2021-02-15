#ifndef SETUP_H
#define	SETUP_H

/* used to check the memory wrap 0x10 is the difference between 0xFFFF:0x0000 and 1Mib 0xFFFF:0x0010*/

#define  SIG_MEM_ADD	BOOT_OFFSET+(BOOT_SECTOR_SIZE-BOOT_SIG_SIZE)+0x10 

/* 8042 PS/2 Controller I/O port */ 
#define  PS2_STATUS_PORT  0x64 
#define  PS2_CMD_PORT  0x64 
#define  PS2_DATA_PORT  0x64 

/* 8042 PS/2 Controller commands */ 
#define  DISABLE_KEYBOARD 0xAD
#define  ENABLE_KEYBOARD 0xAE
#define  READ_PS2_OUTPUT 0xD0
#define  WRITE_PS2_OUTPUT 0xD1

/* FAST A20 Gate */ 
#define FAST_A20_GATE_PORT  0x92


#endif