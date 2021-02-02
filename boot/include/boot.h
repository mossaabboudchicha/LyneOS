#ifndef BOOT_H
#define BOOT_H

/* kernel setup file memory and disk locations*/

#define SETUP_SEG  0x9000
#define SETUP_OFFSET 0xA2
#define SETUP_START_SECTOR	0X03
#define SETUP_NBR_SECTORS	0X01


#define BOOT_SIG	0xAA55

#endif
