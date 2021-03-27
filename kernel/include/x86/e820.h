/*

Header file for BIOS int 0x15,EAX=E820 Detection memory,this file contains the data structure used to save
the detected memory entries and their types to be used later by the kernel

*/

#ifndef E820_H
#define E820_H

#include "../types.h"

/* Memory regions types as defined by BIOS */
#define RAM 1
#define UNUSABLE  2
#define ACPI_DATA 3 /* reclaimable memory*/
#define ACPI_NVS  4 
#define BAD_MEMORY 5 /* BAD memory ,we can add this type to 2 because from the kernel point of view it is the same thing*/

/* E820 map variables */

#define E820Map 0x258  /* memory map entries have to be strored from this memory address */
#define E820Nr 0x190  /* counter of entries to check if we have reached the max number */
#define E820Max 0x20   /* max number of entries */
#define E820EntrySize 0x14  /*20 byte for each entry */
#define E820Magic 0x534D4150  /* Magic number of E820 Memory detection */

#ifndef __ASSEMBLER__

/* E820 data structures */

typedef struct e820_entry{
	uint64_t address;
	uint64_t size; 
	uint8_t type;

} e820_entry;

struct e820map{
	e820_entry list[E820Max];
} 

#endif /* __ASSEMBLER__*/

#endif /* E820_H*/