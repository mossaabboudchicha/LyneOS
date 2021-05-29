/*

Copyright (C) 2021 Mossaab BOUDCHICHA

THIS is simple linker script for the setup.

*/

OUTPUT_FORMAT("binary")
ENTRY(start)

SECTIONS {
	
	/*
      . mean the current Address,so we have to put the start address (we have to put the same value in SETUP_OFFSET in boot.h) 

	*/
	. = 0x9000;
	PROVIDE(_ssetup = .);
	.text :{
	       *(.text)
	}

	.data :{
	       *(.data)
	}

	.bss :{
	       *(.bss)
	}
	PROVIDE(_esetup = .);
}