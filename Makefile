# Juste for rappel : $^ is the dependencies
#				     $@ is the target 

GAS = as

CC = gcc

CC_AS_FLAGES = -c

LINKER = ld

EMU-X86 = qemu-system-x86_64

CUR_DIR := $(shell pwd)

BOOT_DIR := $(CUR_DIR)'/boot'

KERNEL_DIR := $(CUR_DIR)'/kernel'


# Build rules

build_all:kernelEmu

only_build:kernel.img

bootloader.bin:
	make -C $(BOOT_DIR)

setup.bin:
	make -C $(KERNEL_DIR)

kernel.img:bootloader.bin  setup.bin 
	#cat $^ > $@
	dd if=/dev/zero of=kernel.img  count=4
	dd if=$(BOOT_DIR)/bootloader.bin of=kernel.img count=2
	dd if=$(KERNEL_DIR)/setup.bin of=kernel.img seek=2 count=2

	

kernelEmu:kernel.img
	
	$(EMU-X86) $^

clean:
	rm -rf *.o *.bin *.img *.elf *.sys *.asm

	make clean -C $(BOOT_DIR)

	make clean -C $(KERNEL_DIR)

