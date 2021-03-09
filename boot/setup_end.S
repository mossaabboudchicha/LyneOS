/*

Copyright (C) 2021 Mossaab BOUDCHICHA

THIS file must be linked at the end of setup file,this is used to check that the setup code has been loaded
correctly in the memory.

*/

.code16
.text

#include "include/boot.h"
#include "include/setup.h"

_start_end_setup:
.global setup_check_sig1
.global setup_check_sig2


setup_check_sig1: .word SETUP_SIG1
setup_check_sig2: .word SETUP_SIG2