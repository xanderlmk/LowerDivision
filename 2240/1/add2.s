# add2.s
# Xander Reyes
# a sample MIPS program to demonstrate MIPS basics 
# Usage: $ spim -f add2.s

        .data                # data segment begins here
str1:  .asciiz "The sum of "
str2:  .asciiz " and "
str3:  .asciiz " is "
str4: .asciiz " \n"

        .text                # code segment begins here 
main:
        la $a0, str1    # the sum of
        li $v0, 4
        syscall
        
        
        li $a0, 1738        # 1738
        move $t0, $a0
        li $v0, 1
        syscall

        la $a0, str2
        li $v0, 4            # and
        syscall              # execute the call 


        li $a0, 502           # 502
        move $t1, $a0
        li $v0, 1
        syscall
        
        la $a0, str3            # is
        li $v0, 4
        syscall
        
        addu $a0, $t1, $t0      # 2240
        move $t3, $a0 
        li $v0, 1
        syscall

        la $a0, str4
        li $v0, 4
        syscall

        li $v0, 10           # 10 is system call to exit
        syscall              # execute the call 


