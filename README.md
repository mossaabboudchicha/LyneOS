# LyneOS
LyneOS is small Unix-like Operating system kernel,this kernel is X86 architecture specific,in terms of design, it is a monolithic kernel like many other Unix-based kernels.

# Make custom options : 
 1) In new x86 computers,it is highly possible that the A20 gate is automatically activated by the BIOS, so if you want to compile the kernel without enable A20 gate you have to run make as follows:
 	$ make EXTENDED_FLAGS="-DIGNORE_A20CHECK" 