#
# Copyright (C) 2021 Mossaab BOUDCHICHA 
# The LyneOS kernel Makefile 


VERBOSE_MODE ?=0

# The SRC_DIR can be specified by the commande line option SRC_DIR=
# by default it is the current directory in which the make has been used

# The BUILD_DIR can be specified by the commande line option BUILD_DIR=
# The default build directory if the user doesn't specify any build dir

srctree := $(CURDIR)
builddir := $(if $(BUILD_DIR),$(BUILD_DIR),$(CURDIR)/build/)

# Get the current architecture 
SUBARCH := $(shell uname -m | sed -e s/i.86/x86/ -e s/x86_64/x86/ \
				  -e s/sun4u/sparc64/ \
				  -e s/arm.*/arm/ -e s/sa110/arm/ \
				  -e s/s390x/s390/ -e s/parisc64/parisc/ \
				  -e s/ppc.*/powerpc/ -e s/mips.*/mips/ \
				  -e s/sh[234].*/sh/ -e s/aarch64.*/arm64/ )

# The default architecture is specified by default by the makefile,
# but it can be overridden by command line options ARCH=
ARCH		?= $(SUBARCH)
CROSS_COMPILE	?= 

# GCC preprocessor,compiler,linker for cross-compiler
AS = $(CROSS_COMPILE)as
LD = $(CROSS_COMPILE)ld
CC = $(CROSS_COMPILE)gcc
CPP = $(CC) -E 
OBJDUMP = $(CROSS_COMPILE)objdump

NOSTDINC_FLAGS  = -nostdinc -isystem $(shell $(CC) -print-file-name=include)
HEADERS_INCLUDE_DIR = -I$(srctree)/include -I$(srctree)/arch/$(ARCH)/include

CFLAGS := -c -Wall -ffreestanding -O2
CFLAGS += $(NOSTDINC_FLAGS)
CPPFLAGS := $(HEADERS_INCLUDE_DIR)
QEMU = qemu-system-x86_64
 

ifneq ($(VERBOSE_MODE),1)
	Q = 
else
	Q = @
endif

# Export VARIABLES so they can be used by sub-process
export ARCH CROSS_COMPILE AS LD CC CPP OBJDUMP NOSTDINC_FLAGS HEADERS_INCLUDE_DIR
export CFLAGS CPPFLAGS srctree builddir Q


.PHONY:install install_qemu clean

# The default target when no target is specified

install:bootblock
	mkdir -p $(builddir)
	mv $(BOOT)/*.bin  $(builddir)
	mv $(BOOT)/*.o  $(builddir)
	
install_qemu:install
	$(QEMU) $(builddir)/bootblock.bin

clean:
	rm -rf $(builddir)




# we have to get the architecture dependent Makefile
include arch/$(ARCH)/Makefile
