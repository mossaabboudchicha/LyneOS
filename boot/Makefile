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

SETUP_SRC = setup.S

SETUP_END_SRC = setup_end.S 

A20_LINE_SRC = a20_line.S

E820_MM_SRC = e820_mm.S

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

setup_end.o:$(SETUP_END_SRC)
	$(CC) $(CC_AS_FLAGES) -o $@ $^

a20_line.o:$(A20_LINE_SRC)
	$(CC) $(CC_AS_FLAGES) -o $@ $^

e820_mm.o:$(E820_MM_SRC)
	$(CC) $(CC_AS_FLAGES) -o $@ $^

setup.bin:setup.o prints.o disk_services.o a20_line.o e820_mm.o setup_end.o
	#$(LINKER) -o $@ --oformat binary  -e $(SETUP_ENTRY_POINT) -Ttext $(SETUP_MEM_ADDR) $^
	$(LINKER) -T setup.ld -o $@  $^

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

setup.elf:setup.o
	readelf	-a $^ > $@

setup.sys:setup.o
	objdump	-s $^ > $@

setup.asm:setup.o
	objdump	-D $^ > $@


setup_end.prep:$(SETUP_END_SRC)
	$(CC) $(CC_PREP_FLAGES) $^ > $@

setup_end.elf:setup_end.o
	readelf	-a $^ > $@

setup_end.sys:setup_end.o
	objdump	-s $^ > $@

setup_end.asm:setup_end.o
	objdump	-D $^ > $@


a20_line.prep:$(A20_LINE_SRC)
	$(CC) $(CC_PREP_FLAGES) $^ > $@

a20_line.elf:a20_line.o
	readelf	-a $^ > $@

a20_line.sys:a20_line.o
	objdump	-s $^ > $@

a20_line.asm:a20_line.o
	objdump	-D $^ > $@


prints.prep:$(PRINTS_SRC)
	$(CC) $(CC_PREP_FLAGES) $^ > $@

prints.elf:prints.o
	readelf	-a $^ > $@

prints.sys:prints.o
	objdump	-s $^ > $@

prints.asm:prints.o
	objdump	-D $^ > $@


disk_services.prep:$(DISK_SRC)
	$(CC) $(CC_PREP_FLAGES) $^ > $@

disk_services.elf:disk_services.o
	readelf	-a $^ > $@

disk_services.sys:disk_services.o
	objdump	-s $^ > $@

disk_services.asm:disk_services.o
	objdump	-D $^ > $@


e820_mm.prep:$(E820_MM_SRC)
	$(CC) $(CC_PREP_FLAGES) $^ > $@

e820_mm.elf:e820_mm.o
	readelf	-a $^ > $@

e820_mm.sys:e820_mm.o
	objdump	-s $^ > $@

e820_mm.asm:e820_mm.o
	objdump	-D $^ > $@