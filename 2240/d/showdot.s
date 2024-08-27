
# This program follows the GNU AS (GAS) syntax rules.
# It is also AT&T syntax.
# Author: Xander Reyes
# This program to be called from a C program.
# Data can be declared here.
.section .data
string: .ascii  "Hello from assembler\n"


# The code is here...
.section .text
.global showDot
.type showDot, @function  # <--- this line is important

showDot:
    .cfi_startproc

	                 # The setPixel function is defined inside the C program.
	mov $200, %esi
    mov $200, %edi
    
    

    # Please get the pixel to draw at the center position.
	                 # How could you optimize this call somewhat?
                         # put parameter x into argument 1
                     # put parameter y into argument 2
	call setPixel    # call an external function
    
        ret
     .cfi_endproc
