# Juste for rappel : $^ is the dependencies
#				     $@ is the target 

GAS = as

CC = gcc

CC_AS_FLAGES = -c

LINKER = ld

SETUP_MEM_ADDR = 0xA2

SETUP_ENTRY_POINT = __start

SETUP_SRC = setup.S

# Build rules

build_all:setup.bin

setup.o:$(SETUP_SRC)
	$(CC) $(CC_AS_FLAGES) -o $@ $^


setup.bin:setup.o
	$(LINKER) -o $@ --oformat binary  -e $(SETUP_ENTRY_POINT) -Ttext $(SETUP_MEM_ADDR) $^


clean:
	rm -rf *.o *.bin *.img *.elf *.sys *.asm

# Debug rules 

setup.elf:setup.o
	readelf	-a $^ > $@


setup.sys:setup.o
	objdump	-s $^ > $@

setup.asm:setup.o
	objdump	-D $^ > $@