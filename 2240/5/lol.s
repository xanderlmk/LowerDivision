# Xander Reyes
# Lab-5 Programming
#
# Parse a file
#
# a sample MIPS pogram to read a file
# Usage: $ spim -f lab5.s
# $s0 - buffer address
# $s1 - buffer address incrementer
# $s3 - file descriptor
# $s4 - eof flag

        .data                # data segment begins here
fname:  .asciiz "myfile.txt"
buffer: .space 1             # buffer for reading a character
buffer2: .space 100
mess1:  .asciiz "found a whitespace\n"
mess2:  .asciiz "character: "
mess3:  .asciiz "file descriptor: "
mess4:  .asciiz "found a non-whitespace\n"
mess5:  .asciiz "file is open \n"
mess6:  .asciiz "end-of-file <-------------------\n"
error1: .asciiz "did not file: "

        .text                # code segment begins here 
main:
        move $s1, $0          # buffer offset
        move $s4, $0
        li $v0, 13           # open a file with syscall
        la $a0, fname        # load address of the filename
        li $a1, 0            # set flag to read only (0)
        syscall              
                             # file descriptor stored in $v0   
        move $s3, $v0        # save file descriptor in $s3
        blez $s3, dnf        # check if file exits, jump to dnf
        
        #==for=debugging====================
        # li $v0, 4           # print string
        # la $a0, mess5
        # syscall
        #===================================

read_loop:                      # loop to read the whole file
        jal read_till_space     # call
        beq $v0, 1, loop_end    # check for eof, exit loop
        jal read_till_not_space # call
        beq $v0, 1 loop_end     # check for eof, exit loop
        jal read_till_space
loop_end:
        j end                   # program is finished

#---------------------------------------------------------------------
# parse the file using delimiter of a space
#---------------------------------------------------------------------
read_till_space:
        la $s0, buffer2      # store address of the buffer
        addu $s0, $s0, $s1   # offset buffer address
top1:
        li $v0, 14           # read the file
        move $a0, $s3        # store the file descriptor($v0)   
        la $a1, buffer       # store address of a buffer
        li $a2, 1            # read just 1 character
        syscall              # execute
        
        
        beq $v0, $0, end_of_parse        # check for end of file, eof

                                            # if  eof, jump to end
        lb $t4, buffer
        beq $t4, 32, end_of_parse   # test for space
        beq $t4, 10, end_of_parse   # test for newline
        beq $t4, 11, end_of_parse   # test for carrage return
        beq $t4, 9, end_of_parse    # test for tab
        
        
        sb $t4, ($s0)        # store the one character in the buffer2
        addi $s0,$s0, 1      # increment +1 to buffer
        
        #==for=debugging====================
        li $v0, 4               # print string
        la $a0, mess2
        syscall
        li $v0, 11              # print char
        move $a0, $t4
        syscall
        li $v0, 11              # print char
        la $a0, 10
        syscall
        #====================================

        j top1               # get next character from file
eof1:
        li $v0, 4 
        la $a0, mess6
        syscall
        li $s4,1 
end_of_parse:
        # print the buffer
        sb $0, ($s0)

        li $v0, 4
        la $a0, mess1
        syscall


        addiu $s0, $s0, 1
        sb $0, ($s0)

        li $v0, 4            # 4 is syscall to print string
        la $a0, buffer2      # start of string
        syscall
        li $v0, 11
        li $a0, 10

        move $v0, $s4
        jr $ra
#------------------------------------------------------------------------
# reads until there's not a space
#------------------------------------------------------------------------
read_till_not_space:
top2:
        li $v0, 14           # read the file
        move $a0, $s3        # store the file descriptor($v0)   
        la $a1, buffer       # store address of a buffer
        li $a2, 1            # read just 1 character
        syscall              # execute
        
        

        beqz $v0, eof2        # check for end of file, eof
                                            # if  eof, jump to end
        lb $t4, buffer
        beq $t4, 32, top2
        beq $t4, 10, top2
        beq $t4, 13, top2
        beq $t4, 9, top2

              
        j end2               # get next character from file
eof2:
        li $v0, 4
        la $a0, mess6
        syscall
        li $s4, 1
end2:
        sb $t1, buffer2
        li $s1, 1

         #==for=debugging====================
        li $v0, 4               # print string
        la $a0, mess4
        syscall
        li $v0, 4               # print string
        la $a0, mess2
        syscall
        li $v0, 11              # print char
        move $a0, $t4
        syscall
        li $v0, 11              # print char
        la $a0, 10
        syscall
        #====================================

        

        move $v0, $s4
        jr $ra

#-------------------------------------------------------------------
# end of program
#------------------------------------------------------------------
end:
        li $v0, 16           # close the file
        move $a0, $s1        # store the file descriptor($v0)   
        syscall                   
       
        
        li $v0, 10           # 10 is ascii value for linefeed
        li $a0, 11           # 11 is syscall to print char
        syscall

        li $v0, 10           # 10 is system call to exit
        syscall              # execute the call 

dnf:

        li $v0, 4           # print string
        la $a0, error1
        syscall
        li $v0, 4           # print string
        la $a0, fname
        syscall

        j end
