

# Bootloader vars

BOOT_MEM_ADDR = 0x7c00
BOOTLOADER_SRC = bootloader.S
BOOTLOADER_OBJ = bootloader.o
BOOTLOADER_NBR_SEC = 1
# setup vars

SETUP_LINKER_SCRIPT = setup.ld
SETUP_OBJ = setup.o\
			 e820_mm.o\
			 a20_line.o\
			 setup_end.o
SETUP_NBR_SEC = 2

# commun vars

LD_BINARYFLAGS = --oformat binary
BOOTBLOCK_NBR_SEC := 3

# Build rules

.PHONY:all 

all:bootblock.bin
	

# Bootloader

bootloader.bin:$(BOOTLOADER_OBJ)
	$(Q)$(LD) -o $@ $(LD_BINARYFLAGS) -Ttext $(BOOT_MEM_ADDR) $<


$(BOOTLOADER_OBJ):$(BOOTLOADER_SRC) 
	$(Q)$(CC) $(CFLAGS) $(CPPFLAGS) -o $@ $<


setup.bin:$(SETUP_OBJ)
	$(Q)$(LD) -T $(SETUP_LINKER_SCRIPT) -o $@ $^


$(SETUP_OBJ):%.o:%.S

bootblock.bin:bootloader.bin setup.bin
	dd	if=/dev/zero of=$@ count=$(BOOTBLOCK_NBR_SEC)
	dd	if=bootloader.bin of=$@ count=$(BOOTLOADER_NBR_SEC)
	dd 	if=setup.bin  of=$@ seek=$(BOOTLOADER_NBR_SEC) count=$(SETUP_NBR_SEC)

	



