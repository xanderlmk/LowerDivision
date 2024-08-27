#
# Author: Gordon Griesel
# Lab-5 programming in-class
#
# Parse a file with MIPS
# Usage: $ spim -f lab5b.s
# Author : Xander Reyes
#   
# registers I have chosen to use:
# -------------------------------
# $s0 - buffer address
# $s1 - buffer address incrementer
# $s3 - file descriptor
# $s4 - eof flag
# $s6 - grand total
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
    total:    .asciiz "sum:  "
    space:    .asciiz " " 
.text                    # code segment begins here 
main:
	move $s1, $zero      # buffer offset
	move $s4, $zero      # eof flag 0=not eof 1=eof
    move $s6, $zero      # initialize grand total to zero
	li $v0, 13           # open a file with syscall
	la $a0, fname        # load address of the filename
	li $a1, 0            # set flags to read only
	syscall              # execute the call 
	move $s3, $v0        # save the file descriptor in $s3

	#==for=debugging========================
	#li $v0, 4       # print string
	#la $a0, mess5
	#syscall
	#=======================================

read_loop:
	                            # This is a loop to read the whole file.
	jal read_until_whitespace   # call
	beq $v0, 1, loop_end        # check for eof, exit loop=
	jal read_until_not_space    # call
	beq $v0, 1, loop_end        # check for eof, exit loop


    #addition sign

	j read_loop                 # continue looping

loop_end:
    li $v0, 11         # newline
	li $a0, 10         # 
	syscall            #

    li $v0, 4               # print a string
    la $a0, total           #
    syscall                 #

    li $v0, 1               # show the grand total
    la $a0, ($s6)           # load address of $s6
    syscall           

	li $v0, 11         # newline
	li $a0, 10         # 
	syscall            #


	j end                       # program is finished


#======================================================================
# subroutines are below
#======================================================================

read_until_whitespace:
#---------------------------------------------------------------------
#READ_UNTIL_WHITESPACE
#read file while placing characters into buffer starting at buffer[0]
#---------------------------------------------------------------------
    addi $sp, $sp, -16    # open a stack frame
    sw  $ra, 4($sp)       # 
    
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
	#li $v0, 4         # print string
	#la $a0, mess2
	#syscall
	#li $v0, 11        # print char
	#move $a0, $t4
	#syscall
	#li $v0, 11        # print char
	#li $a0, 10
	#syscall
	#=======================================

	j top1
eof1:
	#li $v0, 4         # print string
	#la $a0, mess6     #
	#syscall           #
	li $s4, 1         # set eof flag
end1:
	sb $0, ($s0)      # null terminator for string just read
	#==for=debugging========================
	#li $v0, 4         # print string
	#la $a0, mess1     #
	#syscall           #
	#=======================================
    
    la $a0, buffer          # address of string or number in a string
    jal atoi                # call atoi
    add $s6, $s6, $v0       # accumulate the grand total
    
    la $a0, buffer
    lb $t0, 0($a0)
    blt $t0, '0', nonnum
    bgt $t0, '9', nonnum
    #bne $t0, '-', nonnum

    li $v0, 4
    la $a0, buffer
    syscall
    
    li $v0, 4               # print string
    la $a0, space           # load address of string
    syscall

    
nonnum:
   	#==for=debugging========================
	#show the string that was just parsed
	#
	#addiu $s0, $s0, 1  # increment pointer to buffer
	#sb $zero, ($s0)    # store a null terminator 
	#li $v0, 4          # print string
	#la $a0, buffer     # buffer address
	#syscall            #
	#li $v0, 11         # 11 is print char
	#li $a0, 10         # 10 is linefeed
	#syscall
	#=======================================

	move $v0, $s4      # set return value
    
    lw  $ra, 4($sp)      # restore the return address
    addi $sp, $sp, 16    # restore the stack pointer

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
	#done
	j end2
eof2:
	#li $v0, 4         # print string
	#la $a0, mess6     #
	#syscall           #
	li $s4, 1         # set eof flag
end2:
	sb $t4, buffer      # save character at start of buffer
	li $s1, 1

    
       #li $v0, 4
    #la $a0, buffer
    #syscall
    

	#==for=debugging========================
	#li $v0, 4           #print string
	#la $a0, mess4
	#syscall
	#li $v0, 4           #print string
	#la $a0, mess2
	#syscall
	#li $v0, 11          #print char
	#move $a0, $t4
	#syscall
	#li $v0, 11          #print char
	#li $a0, 10
	#syscall
	#=======================================

	move $v0, $s4       # set return value
	jr $ra              # return

#------------------------------------------------------------------
# end of program
#------------------------------------------------------------------
end:
	li $v0, 16           # close the file
	move $a0, $s3        # store the file descriptor
	syscall              # execute the call 

	li $v0, 11           # 11 is syscall to print char
	li $a0, 10           # 10 is ascii value for linefeed
	syscall

	li $v0, 10           # 10 is system call to exit
	syscall              # execute the call 

#------------------------------------------------------------------
#--- ATOI FUNCTION ------------------------------------------------
#------------------------------------------------------------------
atoi:
    move $v0, $zero
                         # detect sign + or -
    li $t0, 1            # assume sign is positive
    lbu $t1, 0($a0)      # load byte from 1st argument into t1
    bne $t1, 45, digit   # if (t1 != '-') goto digit
    li $t0, -1           # save negative sign, will multiply by this later.
    addu $a0, $a0, 1     # move to the character after '-'

digit:
    # read character     #
    lbu $t1, 0($a0)      # load next character
                         # finish when non-digit encountered
                         # must be a character between 0 and 9
    bltu $t1, 48, finish # check for characters before 0
    bgtu $t1, 57, finish # check for characters after 9
     
                         # translate character into digit
    subu $t1, $t1, 48    # t1 = t1 - '0'
     
                         # multiply the accumulator by ten
                         # this moves the decimal point
    li $t2, 10           # load 10
    mult $v0, $t2        # multiply
    mflo $v0             # get the result
     
                         # add digit to the accumulator
    add $v0, $v0, $t1    # did it.
     
                         # next character
    addu $a0, $a0, 1     # move to next character in argument
    b digit              # continue loop

finish:
    mult $v0, $t0        # set the number's sign
    mflo $v0             # put the result of multiply into v0
    jr $ra               # return
#------------------------------------------------------------------

