# Juste for rappel : $^ is the dependencies
#				     $@ is the target 

GAS = as

CC = gcc

CC_AS_FLAGES = -c

LINKER = ld

EMU-X86 = qemu-system-x86_64

CUR_DIR := $(shell pwd)

BOOT_DIR := $(CUR_DIR)'/boot'



# Build rules

build_all:kernelEmu

only_build:kernel.img

bootblock:
	make -C $(BOOT_DIR)


kernel.img:bootblock 
	#cat $^ > $@
	dd if=/dev/zero of=kernel.img  count=4
	dd if=$(BOOT_DIR)/bootloader.bin of=kernel.img count=2
	dd if=$(BOOT_DIR)/setup.bin of=kernel.img seek=2 count=2

	

kernelEmu:kernel.img
	
	$(EMU-X86) $^

usb_sdb:kernel.img
	dd if=/dev/zero of=/dev/sdb count=4
	dd if=kernel.img of=/dev/sdb count=4

usb_sdc:kernel.img
	dd if=/dev/zero of=/dev/sdc count=4
	dd if=kernel.img of=/dev/sdc count=4

clean:
	rm -rf *.o *.bin *.img *.elf *.sys *.asm *.prep

	make clean -C $(BOOT_DIR)

