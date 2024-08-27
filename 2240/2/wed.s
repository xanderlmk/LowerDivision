# wed.s
# a sample MIPS program to read a file
# Usage: $ spim -f wed.s

        .data                # data segment begins here
fname:  .asciiz "myfile.txt"
buffer: .space 100
#var1: .word 69
#var2: .word 1738

        .text                # code segment begins here 
main:

        li $v0, 13           # open a file with syscall
        la $a0, fname        # load address of the filename
        li $a1, 0            # set flag to read only (0)
        syscall              
                             # file descriptor stored in $v0   
        move $s1, $v0        # save file descriptor in $s1
read:
        li $v0, 14           # close the file
        move $a0, $s1        # store the file descriptor($v0)   
        la $a1, buffer       # store address of a buffer
        li $a2, 1            # read just 1 character
        syscall              # execute

        li $v0, 11           # 11 is syscall to print char
        la $s0, buffer       # load address of buffer
        lb $a0, ($s0)        # load a byte from buffer
        syscall
        j read               # get next character from file





 
        li $v0, 16           # close the file
        move $a0, $s1        # store the file descriptor($v0)   
        syscall                    

       




        
        li $a0, 10           # 10 is ascii value for linefeed
        li $v0, 11           # 11 is syscall to print char
        syscall

        li $v0, 10           # 10 is system call to exit
        syscall              # execute the call 


