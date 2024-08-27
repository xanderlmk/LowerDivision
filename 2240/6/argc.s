# filename: argc.s
# purpose: simply show the count of command-line arguments

.text
main:
    #move $s0, $a0
    li $v0, 1         # 1 = print an integer
    #move $a0, $s0     # value to print already in a0
    syscall           #

    jal newline
    jal newline
 
    li $v0, 10        # 10=exit
    syscall           #

newline:
    li $v0, 11        # print character
    li $a0, 10        # newline for clean program output  
    syscall           #
	jr $ra


