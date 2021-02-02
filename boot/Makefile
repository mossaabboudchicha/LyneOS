# Juste for rappel : $^ is the dependencies
#				     $@ is the target 

GAS = as

CC = gcc

CC_AS_FLAGES = -c

LINKER = ld

BOOT_MEM_ADDR = 0x7c00

BOOT_LOADER_ENTRY_POINT = __main

BOOTLOADER_SRC = bootloader.S

# Build rules

build_all:bootloader.bin
	

bootloader.o:$(BOOTLOADER_SRC) 
	$(CC) $(CC_AS_FLAGES) -o $@ $^

bootloader.bin:bootloader.o
	$(LINKER) -o $@ --oformat binary -e $(BOOT_LOADER_ENTRY_POINT) -Ttext $(BOOT_MEM_ADDR) $^

clean:
	rm -rf *.o *.bin *.img *.elf *.sys *.asm

# Debug rules 

bootloader.elf:bootloader.o
	readelf	-a $^ > $@

bootloader.sys:bootloader.o
	objdump	-s $^ > $@

bootloader.asm:bootloader.o
	objdump	-D $^ > $@