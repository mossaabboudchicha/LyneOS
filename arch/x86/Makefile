#
# Copyright (C) 2021 Mossaab BOUDCHICHA 
# The LyneOS kernel Makefile 

# This is architecture specific Makefile,this will allow to add architecture specific 
# rules and flags,this file will also be included in the main Makefile

BOOT = arch/$(ARCH)/boot

.PHONY:bootblock 
	
# BUILD the bootblock
bootblock:
	$(Q)$(MAKE) -C $(BOOT)

