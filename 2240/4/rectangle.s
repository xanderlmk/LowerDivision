# rectangle.s
# demo of nested loops
# fill a rectangle with characters
# author: gordon griesel

.text
.globl main
main:
    li $s0, 16          # width
    li $s1, 9           # height

    move $t1, $s1       # save height
#=====================================================================+
outer:                  # top of outer loop                           |
    move $t0, $s0       # save width every outer-loop iteration       |
#----------------------------------------------------------+          |
inner:                  # top of inner loop                |          |
    li $v0, 11          # show a character twice           |          |
    li $a0, '@'         #                                  |          |
    syscall             #                                  |          |
    li $v0, 11          # again...                         |          |
    li $a0, '@'         #                                  |          |
    syscall             #                                  |          |
    add $t0, $t0, -1    # decrement width counter          |          |
    bgtz $t0, inner     # keep looping through columns?    |          |
#----------------------------------------------------------+          |
    jal newline         # newline every new row                       |
                        #                                             |
    add $t1, $t1, -1    # decrement height counter                    |
    bgtz $t1, outer     # keep looping through the rows?              |
#=====================================================================+
    jal newline         # newline at program end
    li   $v0, 10        # exit
    syscall

newline:                # newline function
    li $v0, 11          # 11 = show character
    li $a0, 10          # 10 = ascii newline
    syscall             #
    jr $ra              # return to $ra address

