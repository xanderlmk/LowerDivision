#
# Author: Xander Reyes
# Semester project phase 1 program
#
# This program was taken from lab5a.s, then modified.
#
# Parse a file with MIPS" .:-=+*#%@"
#
# Usage: $ spim -f lab7a.s
#
# registers I have chosen to use:
# -------------------------------
# $s0 - buffer address
# $s1 - buffer address incrementer
# $s3 - file descriptor
# $s4 - eof flag
# $s5 - width
# $s6 - height

.data # data segment begins here
	fname:    .asciiz "img75.ppm"
	#fname:    .asciiz "csub3.txt"
	#fname:    .asciiz "csub3.ppm"
    #fname:    .asciiz "minecraftskin.txt"
    #fname:    .asciiz "chadsteve1.ppm"
	mess1:    .asciiz "found a whitespace\n"
	mess2:    .asciiz "character: "
	mess3:    .asciiz "File descriptor: "
	mess4:    .asciiz "found a non-whitespace\n"
	mess5:    .asciiz "file is open\n"
	mess6:    .asciiz "end-of-file <--------------------\n"
	read_buf: .space  1   # buffer for reading a character
	buffer:   .space  100
    widths:   .asciiz "Image width: "
    heights:  .asciiz "Image height: "
    maxval:   .asciiz "Max color value: "
    error1:    .asciiz "Did not find file: " 
    p3num:    .asciiz "Good P3 file found."
    bpnum:    .asciiz "Non-valid ppm file, must be 3 or 6.\n"
    array1:   .asciiz " .:-=+*%#@"
.text                    # code segment begins here 
main:
	move $s1, $zero      # buffer offset
	move $s4, $zero      # eof flag 0=not eof 1=eof
	li $v0, 13           # open a file with syscall
	la $a0, fname        # load address of the filename
	li $a1, 0            # set flags to read only
	syscall              # execute the call 
	move $s3, $v0        # save the file descriptor in $s3
    blez $s3, dnf        # check if file exits, jump to dnf
    
    li $v0, 4       # print string
	la $a0, mess3
	syscall

    li $v0, 1       # print string
	la $a0, ($s3)
	syscall

    li $v0 ,11                  # new line
    li $a0, 10
    syscall
    


	#==for=debugging========================
	#li $v0, 4       # print string
	#la $a0, mess5
	#syscall
	#=======================================


read_loop:
	                            #
	jal read_until_whitespace   # read the P3
    
    la $a0, buffer              # load address of buffer into $a0
    lb $t7, 0($a0)
    lb $t9, 1($a0)

    bne $t7, 'P', badppm 
    beq $t9, '6', p6file          # if $t7==6, this is a p6 file, so jump to subroutine of a p6 file   
    bne $t9, '3', badp3           # if $t7!== 3, not a good file descriptor, jump to label
       
    li $v0, 4       # print string
	la $a0, p3num
	syscall



    jal read_until_not_space    # 

	jal read_until_whitespace   # read the width
    la $a0, buffer              # load address of buffer into a0
    jal atoi                    #
    move $s5, $v0               # v0 is the return value of atoi, move it into s5
    

    li $v0, 4                   # print a string (width)
    la $a0, widths
    syscall
    li $v0, 1                   # print the width
    move $a0, $s5
    syscall
    
	jal read_until_not_space    # read the height 
   	jal read_until_whitespace   # number starts here 
    la $a0, buffer              # load address of buffer into a0
    jal atoi                    #
    move $s6, $v0               # v0 is the return value of atoi, move it into s6
    
    li $v0 ,11                  # new line
    li $a0, 10
    syscall
    
    li $v0, 4                   # print a string (height)
    la $a0, heights
    syscall

    li $v0, 1                   # print the height
    move $a0, $s6
    syscall

    jal read_until_not_space    # read the max color, skip it
   	jal read_until_whitespace   # number starts here 
    
    li $v0, 14            # read one more character
	move $a0, $s3         # file descriptor
	la $a1, read_buf      # buffer to be filled
	li $a2, 1             # read 1 char
	syscall
    
    li $v0 ,11            # new line
    li $a0, 10
    syscall


    #move $t7, $s6       # save height
    
#=====================================================================+
outerp3:                  # top of outer loop                           |
    move $t8, $s5       # save width every outer-loop iteration       |

#----------------------------------------------------------+          |
innerp3:                  # top of inner loop                |          |
   	
   	jal read_until_whitespace   # number starts here 
    la $a0, buffer              # load address of buffer into a0
    jal atoi                    #
    
    li $t6, 64
    div $v0, $t6
    mflo $v0
    addi $v0, $v0, 32

    move $t5, $v0

    li $v0, 11
    move $a0, $t5
    syscall

   
     # skip the next two numbers 
   	jal read_until_whitespace   # skip 1st pair of numbers 
    jal read_until_not_space    # 
   	jal read_until_whitespace   # skip 2nd pair of numbers
    

    li $v0, 11          # show a character twice           |          |
    li $a0, ' '         #                                  |          |
    syscall             #                                  |          |
                       #                                   |          |
    add $t8, $t8, -1    # decrement width counter          |          |
    bgtz $t8, innerp3     # keep looping through columns?    |          |
#----------------------------------------------------------+          |
    li $v0, 11          # newline every new row                       |
    li $a0, 10          #                                             |
    syscall             #
    
    add $s6, $s6, -1    # decrement height counter                    |
    bgtz $s6, outerp3     # keep looping through the rows?              |
#=====================================================================+

    li $v0, 11          # newline every new row                       |
    li $a0, 10          #                                             |
    syscall   
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
    addi $sp, $sp, -16
    sw $ra, 4($sp)
    

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
	#==for=debugging========================
	#li $v0, 4         # print string
	#la $a0, mess6     # end-of-file message
	#syscall           #
	#=======================================
	li $s4, 1          # set eof flag

end1:
	sb $0, ($s0)      # null terminator for string just read
	#  .half 0xbead, 0xface==for=debugging========================
	#li $v0, 4         # print string
	#la $a0, mess1     #
	#syscall           #
	#=======================================
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

	lw $ra, 4($sp)
    addi $sp, $sp, 16

    jr $ra             # done


read_until_not_space:
#---------------------------------------------------------------------
#read file looking for something other than whitespace
#---------------------------------------------------------------------
    addi $sp, $sp, -16
    sw $ra, 4($sp)
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
	#==for=debugging========================
	#li $v0, 4         # print string
	#la $a0, mess6     # end-of-file message
	#syscall           #
	#=======================================
	li $s4, 1          # set eof flag
end2:
	sb $t4, buffer     # save character at start of buffer
	li $s1, 1

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
    
    lw $ra, 4($sp)
    addi $sp, $sp, 16

    jr $ra              # return

#------------------------------------------------------------------
# end of program
#------------------------------------------------------------------
end:
	li $v0, 16      # close the file
	move $a0, $s3   # set the file descriptor
	syscall         # 

	li $v0, 11      # 11 is syscall to print char
	li $a0, 10      # 10 is ascii value for linefeed
	syscall         #

	li $v0, 10      # 10 is system call to exit
	syscall         # <---- program ends here 
#------------------------------------------------------------------



#------------------------------------------------------------------
#--- ATOI FUNCTION ------------------------------------------------
#------------------------------------------------------------------
atoi:
    move $v0, $zero      # start return value at zero
                         # detect sign + or -
    li $t0, 1            # assume sign is positive
    lbu $t1, 0($a0)      # load byte from 1st argument into t1
    bne $t1, 45, digit   # if (t1 != '-') goto digit
    li $t0, -1           # save negative sign, will multiply by this later.
    addu $a0, $a0, 1     # move to the character after '-'
digit:
    lbu $t1, 0($a0)       # load next character from string

                          # finish when non-digit encountered
                          # must be a character between 0 and 9
    bltu $t1, '0', finish # check for characters before 0
    bgtu $t1, '9', finish # check for characters after 9
                          # translate character into digit
    subu $t1, $t1, '0'    # t1 = t1 - ascii value of '0'

                          # multiply the accumulator by ten
                          # this moves the decimal point
    li $t2, 10            # load 10
    mult $v0, $t2         # multiply
    mflo $v0              # get the result
                          # add digit to the accumulator
    add $v0, $v0, $t1     # did it.

                          # next character
    addu $a0, $a0, 1      # move to next character in argument
    b digit               # continue loop
finish:
    mult $v0, $t0         # set the number's sign
    mflo $v0              # put the result of multiply into v0
    jr $ra                # return
#------------------------------------------------------------------
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


badp3:
    li $v0, 4         # print string
	la $a0, bpnum
	syscall
    j end

badppm:
    j end

p6file:
    jal read_until_not_space    # 
        
    la $a0, buffer              # load address of buffer into $a0
    move $t7, $a0               # load a0 into t7
    lb $t7, 0($t7)
    beq $t7, 35, read_until_eol
    
    jal read_until_whitespace   # read the width
    la $a0, buffer              # load address of buffer into a0
    jal atoi                    #
    move $s5, $v0               # v0 is the return value of atoi, move it into s5
    

    li $v0, 4                   # print a string (width)
    la $a0, widths
    syscall
    li $v0, 1                   # print the width
    move $a0, $s5
    syscall
    
	jal read_until_not_space    # read the height 
   	jal read_until_whitespace   # number starts here 
    la $a0, buffer              # load address of buffer into a0
    jal atoi                    #
    move $s6, $v0               # v0 is the return value of atoi, move it into s6
    
    li $v0 ,11                  # new line
    li $a0, 10
    syscall
    
    li $v0, 4                   # print a string (height)
    la $a0, heights
    syscall

    li $v0, 1                   # print the height
    move $a0, $s6
    syscall
    
    li $v0 ,11                  # new line
    li $a0, 10
    syscall
    

    li $v0, 4                   # print a string (maxval)
    la $a0, maxval
    syscall

    jal read_until_not_space    # read the max color
    jal read_until_whitespace   # number starts here 
    la $a0, buffer
    jal atoi
    move $t2, $v0

    li $v0, 1                   # print max color value
    move $a0, $t2
    syscall

    
    li $v0, 14            # read one more character
	move $a0, $s3         # file descriptor
	la $a1, read_buf      # buffer to be filled
	 # allocate 10 consecutive words aligned on word boundary
                      # loads 32-bit integer value 0 in each wordli $a2, 1             # read 1 char
	syscall
    
    li $v0 ,11            # new line
    li $a0, 10
    syscall

  #=========================================== # allocate 10 consecutive words aligned on word boundary
                      # loads 32-bit integer value 0 in each word==================================
#=====================================================================+
outerp6:                  # top of outer loop                           |
    move $t8, $s5       # save width every outer-loop iteration       |

#----------------------------------------------------------+          |
innerp6:                  # top of inner loop                |          |
   	
    
    li $v0, 14            # read a file
	move $a0, $s3         # file descriptor
	la $a1, buffer      # buffer to be filled
	li $a2, 3             # read 3 char
	syscall
    
    la $t4, buffer              # load address of buffer
    lbu $t2, 0($t4)             # get the 1st character
    lbu $t6, 1($t4)             # get the 2nd character
    lbu $t5, 2($t4)             # get the 3rd character

   
    add $t2, $t2, $t6
    add $t2, $t2, $t5

    
    #srl $t3, $t2, 6
    #add $t4, $t3, 32
    
    li $t5, 3
    div $t2, $t5
    mflo $t2
 
    li $t5, 32
    div $t2, $t5
    mflo $t2
   
    #li $t5,32 
    #sub $t2, $t2, $t5,

    la $a0, array1
    add $t0, $a0, $t2
    
    #lb $t5, array2
    #add $t5, $0, $t2

    #move $a0, $t5

    lb $a0, ($t0)
    li $v0, 11
    syscall   
       
    li $v0, 11
    li $a0, ' '
    syscall

    add $t8, $t8, -1    # decrement width counter          |          |
    bgtz $t8, innerp6     # keep looping through columns?    |          |
#----------------------------------------------------------+          |
    li $v0, 11          # newline every new row                       |
    li $a0, 10          #                                             |
    syscall             #
    
    add $s6, $s6, -1    # decrement height counter                    |
    bgtz $s6, outerp6    # keep looping through the rows?              |
#=====================================================================+

    li $v0, 11          # newline every new row                       |
    li $a0, 10          #                                             |
    syscall   
loop_endp6:
	j end                       # program is finished


#=======================================================================
read_until_eol:
    addi $sp, $sp, -16
    sw $ra, 4($sp)
    

    la $s0, buffer        # save buffer address
	addu $s0, $s0, $s1    # increment pointer to buffer

top3:
	li $v0, 14            # read a file
	move $a0, $s3         # file descriptor
	la $a1, read_buf      # buffer to be filled
	li $a2, 1             # read 1 char
	beq $v0, $0, end3     # this means end-of-file eof
	syscall
	lb $t4, read_buf      # get character from read buffer
	beq $t4, 10, end1     # test for newline

	sb $t4, ($s0)         # as reading, save each character in buffer
	addiu $s0, $s0, 1     # increment pointer to buffer

    j top3

eof3:
    li $s4, 1          # set eof flag

end3:
	sb $0, ($s0)      # null terminator for string just read
	move $v0, $s4      # set return value

	lw $ra, 4($sp)
    addi $sp, $sp, 16

    jr $ra             # done

