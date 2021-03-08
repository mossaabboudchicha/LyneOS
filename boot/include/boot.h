#ifndef BOOT_H
#define BOOT_H

/* kernel setup file memory and disk locations*/

#define	BOOT_SEG   0x0000
#define BOOT_OFFSET 0x7c00
#define BOOT_SECTOR_SIZE  0x200

#define SETUP_SEG  0x0000
#define SETUP_OFFSET 0x9000
/*#define SETUP_SEG  0xFFFF
#define SETUP_OFFSET 0xFF10*/
#define SETUP_START_SECTOR	0X03
#define SETUP_NBR_SECTORS	0X02


#define BOOT_SIG	0xAA55
#define BOOT_SIG_SIZE  0x2

#define STACK_OFFSET BOOT_OFFSET

#endif
