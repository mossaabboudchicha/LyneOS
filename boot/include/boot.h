#ifndef BOOT_H
#define BOOT_H

/* kernel setup file memory and disk locations*/
#define SECTOR_SHIFT  0x9
#define SECTOR_SIZE   (0x1 << SECTOR_SHIFT)
#define GET_NBR_SECTOR(bytes)  ((bytes >> SECTOR_SHIFT)+0x1)

#define	BOOT_SEG   0x0000
#define BOOT_OFFSET 0x7c00
#define BOOT_SECTOR_SIZE  SECTOR_SIZE


#define SETUP_SEG  0x0000
#define SETUP_OFFSET 0x9000
/*#define SETUP_SEG  0xFFFF
#define SETUP_OFFSET 0xFF10*/
#define SETUP_START_SECTOR	0X03
#define SETUP_NBR_SECTORS	0X01
#define LOADED_SETUP_BYTES  SETUP_NBR_SECTORS*SECTOR_SIZE

#define BOOT_SIG	0xAA55
#define BOOT_SIG_SIZE  0x2

#define STACK_OFFSET BOOT_OFFSET

#endif
