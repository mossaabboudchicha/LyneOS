# Juste for rappel : $^ is the dependencies
#				     $@ is the target 

GAS = as

CC = gcc

CC_AS_FLAGES = -c

CC_PREP_FLAGES = -E


LINKER = ld

CONCAT_CMD = cat

# Bootloader vars

BOOT_MEM_ADDR = 0x7c00

BOOT_LOADER_ENTRY_POINT = main

BOOTLOADER_SRC = bootloader.S

# Setup vars

SETUP_MEM_ADDR = 0x9000

SETUP_ENTRY_POINT = start

SETUP_SRC = setup.S 

A20_LINE_SRC = a20_line.S

CUR_DIR := $(shell pwd)

BIOS_LIB_DIR := $(CUR_DIR)/bios

PRINTS_SRC = $(BIOS_LIB_DIR)/print_strings.S

DISK_SRC = $(BIOS_LIB_DIR)/disk_services.S

# Build rules

only_build:bootloader.bin setup.bin

# Bios lib

prints.o:$(PRINTS_SRC) 
	$(CC) $(CC_AS_FLAGES) -o $@ $^

disk_services.o:$(DISK_SRC)
	$(CC) $(CC_AS_FLAGES) -o $@ $^

# Bootloader

bootloader.o:$(BOOTLOADER_SRC) 
	$(CC) $(CC_AS_FLAGES) -o $@ $^

bootloader.bin:bootloader.o
	$(LINKER) -o $@ --oformat binary -e $(BOOT_LOADER_ENTRY_POINT) -Ttext $(BOOT_MEM_ADDR) $^

# Setup

setup.o:$(SETUP_SRC)
	$(CC) $(CC_AS_FLAGES) -o $@ $^

a20_line.o:$(A20_LINE_SRC)
	$(CC) $(CC_AS_FLAGES) -o $@ $^

setup.bin:setup.o prints.o disk_services.o a20_line.o 
	$(LINKER) -o $@ --oformat binary  -e $(SETUP_ENTRY_POINT) -Ttext $(SETUP_MEM_ADDR) $^

clean:
	rm -rf *.o *.bin *.img *.elf *.sys *.asm *.prep

# Debug rules 

bootloader.prep:$(BOOTLOADER_SRC)
	$(CC) $(CC_PREP_FLAGES) $^ > $@

bootloader.elf:bootloader.o
	readelf	-a $^ > $@

bootloader.sys:bootloader.o
	objdump	-s $^ > $@

bootloader.asm:bootloader.o
	objdump	-D $^ > $@

setup.prep:$(SETUP_SRC)
	$(CC) $(CC_PREP_FLAGES) $^ > $@
	
a20_line.prep:$(A20_LINE_SRC)
	$(CC) $(CC_PREP_FLAGES) $^ > $@

setup.elf:setup.o
	readelf	-a $^ > $@

setup.sys:setup.o
	objdump	-s $^ > $@

setup.asm:setup.o
	objdump	-D $^ > $@