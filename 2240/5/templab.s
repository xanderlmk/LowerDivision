#
# Author: Xander Reyes
# Lab-5 programming in-class
#
# example of no-op instruction
# 
# Parse a file with MIPS
#
# Usage: $ spim -f lab5a.s
#
# registers I have chosen to use:
# -------------------------------
# $s0 - buffer address
# $s1 - buffer address incrementer
# $s3 - file descriptor
# $s4 - eof flag
# 
#

.data # data segment begins here
	fname:    .asciiz "myfile.txt"
	mess1:    .asciiz "found a whitespace\n"
	mess2:    .asciiz "character: "
	mess3:    .asciiz "file descriptor: "
	mess4:    .asciiz "found a non-whitespace\n"
	mess5:    .asciiz "file is open\n"
	mess6:    .asciiz "end-of-file <--------------------\n"
	read_buf: .space  1   # buffer for reading a character
	buffer:   .space  100
    error1: .asciiz "did not file: "

.text                    # code segment begins here 
main:
	move $s1, $zero      # buffer offset
	move $s4, $zero      # eof flag 0=not eof 1=eof
	li $v0, 13           # open a file with syscall
	la $a0, fname        # load address of the filename
	li $a1, 0            # set flags to read only
	syscall              # execute the call 
	move $s3, $v0        # save the file descriptor in $s1
    blez $s3, dnf        # check if file exits, jump to dnf
	
    #==for=debugging========================
	li $v0, 4       # print string
	la $a0, mess5
	syscall
	#=======================================

read_loop:
	                            # This is a loop to read the whole file.
	jal read_until_whitespace   # call
	beq $v0, 1, loop_end        # check for eof, exit loop
	jal read_until_not_space    # call
	beq $v0, 1, loop_end        # check for eof, exit loop
	j read_loop                 # continue looping

loop_end:
	j end                       # program is finished


#======================================================================
# subroutines are below
#======================================================================

read_until_whitespace:
#---------------------------------------------------------------------
#READ_UNTIL_WHITESPACE
#read file while placing characters into buffer starting at buffer[0]
#---------------------------------------------------------------------
	la $s0, buffer        # save buffer address
	addu $s0, $s0, $s1    # increment pointer to buffer
top1:
	li $v0, 14            # read a file
	move $a0, $s3         # file descriptor
	la $a1, read_buf      # buffer to be filled
	li $a2, 1             # read 1 char
	beq $v0, $0, end1     # this means end-of-file eof
	syscall
	lb $t4, read_buf      # get character from read buffer
	beq $t4, 32, end1     # test for space
	beq $t4, 10, end1     # test for newline
	beq $t4, 13, end1     # test for carrage return
	beq $t4,  9, end1     # test for tab
    
	sb $t4, ($s0)         # as reading, save each character in buffer
    
    addiu $s0, $s0, 1     # increment pointer to buffer
	#==for=debugging========================
	li $v0, 4         # print string
	la $a0, mess2
	syscall
	li $v0, 11        # print char
	move $a0, $t4
	syscall
	li $v0, 11        # print char
	li $a0, 10
	syscall
	#=======================================
    
   
	j top1
eof1:
	li $v0, 4         # print string
	la $a0, mess6     #
	syscall           #
	li $s4, 1         # set eof flag
end1:
	sb $0, ($s0)      # null terminator for string just read
	#==for=debugging========================
	li $v0, 4         # print string
	la $a0, mess1     #
	syscall           #
	#=======================================

	#==for=debugging========================
	#show the string that was just parsed
	#
	addiu $s0, $s0, 1  # increment pointer to buffer
	sb $zero, ($s0)    # store a null terminator 
	li $v0, 4          # print string
	la $a0, buffer     # buffer address
	syscall            #
	li $v0, 11         # 11 is print char
	li $a0, 10         # 10 is linefeed
	syscall
	#=======================================

    li $t0,'0'
    bltu $t4, $t0, done1
    li $t0, '9'
    bltu $t4, $t0, done1
	
    lw $a0, ($t4)
    jal atoi
    move $t4, $v0

done1:
	move $v0, $s4      # set return value
	jr $ra             # done


read_until_not_space:
#---------------------------------------------------------------------
#read file looking for something other than whitespace
#---------------------------------------------------------------------
top2:
	li $v0, 14          # read a file
	move $a0, $s3       # file descriptor
	la $a1, read_buf    # buffer to be filled
	li $a2, 1           # read 1 char
	syscall
	beq $v0, $0, eof2   # this means end-of-file eof
	lb $t4, read_buf    # load 1-byte from buffer
	beq $t4, 32, top2   # test for space
	beq $t4, 10, top2   # test for newline
	beq $t4, 13, top2   # test for carrage return
	beq $t4,  9, top2   # test for tab

    j end2

eof2:
	li $v0, 4         # print string
	la $a0, mess6     #
	syscall           #
	li $s4, 1         # set eof flag
end2:
	sb $t4, buffer      # save character at start of buffer

	li $s1, 1

	#==for=debugging========================
	li $v0, 4           #print string
	la $a0, mess4
	syscall
	li $v0, 4           #print string
	la $a0, mess2
	syscall
	li $v0, 11          #print char
	move $a0, $t4
	syscall
	li $v0, 11          #print char
	li $a0, 10
	syscall
	#=======================================

	move $v0, $s4       # set return value
	jr $ra              # return

#------------------------------------------------------------------
# end of program
#------------------------------------------------------------------
end:
	li $v0, 16           # close the file
	move $a0, $s1        # store the file descriptor
	syscall              # execute the call 

	li $v0, 11           # 11 is syscall to print char
	li $a0, 10           # 10 is ascii value for linefeed
	syscall

	li $v0, 10           # 10 is system call to exit
	syscall              # execute the call 
#-------------------------------------------------------------------
# did not find file
#-------------------------------------------------------------------
dnf:

        li $v0, 4           # print string
        la $a0, error1
        syscall
        li $v0, 4           # print string
        la $a0, fname
        syscall

        j end

# --------- ATOI FUNCTION 
atoi:
    
    move $v0, $zero
     
    # detect sign
    li $t0, 1
    lbu $t1, 0($a0)
    bne $t1, 45, digit
    li $t0, -1
    addu $a0, $a0, 1

digit:
    # read character
    lbu $t1, 0($t4)
     
    # finish when non-digit encountered
    bltu $t1, 48, finish
    bgtu $t1, 57, finish
     
    # translate character into digit
    subu $t1, $t1, 48
     
    # multiply the accumulator by ten
    li $t2, 10
    mult $v0, $t2
    mflo $v0
     
    # add digit to the accumulator
    add $v0, $v0, $t1
     
    # next character
    addu $a0, $a0, 1
    b digit

finish:
    mult $v0, $t0
    mflo $v0
    jr $ra
#----------------------------------------



