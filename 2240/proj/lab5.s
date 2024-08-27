# Xander Reyes
# Lab-5 Programming
#
# Parse a file
#
# a sample MIPS pogram to read a file
# Usage: $ spim -f lab5.s

        .data                # data segment begins here
fname:  .asciiz "myfile.txt"
buffer: .space 1             # buffer for reading a character
buffer2: .space 100
#var1: .word 69
#var2: .word 1738

        .text                # code segment begins here 
main:
        move $s1, $0          # buffer offset
        li $v0, 13           # open a file with syscall
        la $a0, fname        # load address of the filename
        li $a1, 0            # set flag to read only (0)
        syscall              
                             # file descriptor stored in $v0   
        move $s1, $v0        # save file descriptor in $s1
        
        #jal read
        
        jal read_till_space
        jal read_till_not_space 
        jal read_till_space
        
        j end

#----------------------------------------------------------------------
# original file reading until eof
#----------------------------------------------------------------------
read:
        li $v0, 14           # read the file
        move $a0, $s1        # store the file descriptor($v0)   
        la $a1, buffer       # store address of a buffer
        li $a2, 1            # read just 1 character
        syscall              # execute

        beqz $v0, end_of_read        # check for end of file, eof
                             # if  eof, jump to end


        li $v0, 11           # 11 is syscall to print char
        la $s0, buffer       # load address of buffer
        lb $a0, ($s0)        # load a byte from buffer
        syscall
               
        j read               # get next character from file
end_of_read:
        jr $ra
#---------------------------------------------------------------------
# parse the file using delimiter of a space
#---------------------------------------------------------------------
read_till_space:
        la $s2, buffer2      # store address of the buffer
        addu $s2, $s2, $s1   # offset buffer address
top1:
        li $v0, 14           # read the file
        move $a0, $s1        # store the file descriptor($v0)   
        la $a1, buffer       # store address of a buffer
        li $a2, 1            # read just 1 character
        syscall              # execute
        
        

        beq $v0, $zero, end_of_parse        # check for end of file, eof
                                            # if  eof, jump to end
        lb $t1, buffer
        beq $t1, 32, end_of_parse
        #beq $t1, 10, end_of_parse
        
        sb $t1, ($s2)        # store the one character in the buffer2
        addi $s2,$s2, 1      # increment +1

        li $v0, 11           # 11 is syscall to print char
        la $s0, buffer       # load address of buffer
        lb $a0, ($s0)        # load a byte from buffer
        syscall
               
        j top1               # get next character from file
end_of_parse:
        # print the buffer
        move $t1, $0
        sb $t1, ($s2)        # store the one character in the buffer2
        li $v0, 4            # 4 is syscall to print string
        la $a0, buffer2      # start of string
        syscall

        jr $ra
#------------------------------------------------------------------------
# reads until there's not a space
#------------------------------------------------------------------------
read_till_not_space:
top_ns:
        li $v0, 14           # read the file
        move $a0, $s1        # store the file descriptor($v0)   
        la $a1, buffer       # store address of a buffer
        li $a2, 1            # read just 1 character
        syscall              # execute
        
        

        beqz $v0, end_ns        # check for end of file, eof
                                            # if  eof, jump to end
        lb $t1, buffer
        bne $t1, 32, end_ns

              
        j top_ns               # get next character from file
end_ns:
        move $v0, $t1           # move value of $t1 to $v0
        sb $t1, buffer2
        #li $s1, 1
        jr $ra

#-------------------------------------------------------------------
# end of program
#------------------------------------------------------------------
end:
        li $v0, 16           # close the file
        move $a0, $s1        # store the file descriptor($v0)   
        syscall                   
       


        
        li $a0, 10           # 10 is ascii value for linefeed
        li $v0, 11           # 11 is syscall to print char
        syscall

        li $v0, 10           # 10 is system call to exit
        syscall              # execute the call 


