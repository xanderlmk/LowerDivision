# lab4b.s
# Xander Reyes
# Nested Loops

.text
.globl main
main:
    li $s0, 8          # width
    li $s1, 8           # height

    move $t1, $s1       # save height
#=====================================================================+
outer:                  # top of outer loop                           |
    move $t0, $s0       # save width every outer-loop iteration       |
#----------------------------------------------------------+          |
inner:                  # top of inner loop   
    

    beq   $t0, $t1, showdot  # branch to showdot if width == height  
        
    add $t0, $t0, -1    # decrement width counter          |          |
    li $v0, 11          # show character '@'               |          |
    li $a0, '@'         #                                  |          |
    syscall             #                                  |          |
    li $v0, 11          # space                            |          |
    li $a0, ' '         #                                  |          |
    syscall             #                                  |          |
    bgtz $t0, inner     # keep looping through columns?    |          |
#----------------------------------------------------------+          |
    jal newline         # newline every new row                       |
                        #                                             |
    add $t1, $t1, -1    # decrement height counter                    |
    bgtz $t1, outer     # keep looping through the rows?              |
#=====================================================================+
exit:
    jal newline         # newline at program end
    li   $v0, 10        # exit
    syscall

newline:                # newline function
    li $v0, 11          # 11 = show character
    li $a0, 10          # 10 = ascii newline
    syscall             #
    jr $ra              # return to $ra address


showdot: 
    add $t0, $t0, -1    # decrement width counter          |          |
    li $v0, 11         # show character '.'    
    li $a0, '.'         #                             
    syscall             
    li $v0, 11          # space
    li $a0, ' '         #
    beqz  $t0, exit     # once the last dot is in place exit.   
    jr inner

