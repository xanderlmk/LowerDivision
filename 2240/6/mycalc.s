# filename: mycalc.s
# Author: Xander Reyes
# description: 2240 lab-6 

# prompt the user to enter two integers, sum integers and display the result
.data
	iprompt: .asciiz "Enter an integer [return]:\n"
	newline: .asciiz "\n"
    errormsg:   .asciiz "\nUsuage spim -f mycalc.s <int> '+','-','\*' <int>\n"
    unvalidop:  .asciiz "\nUnvalid operator. (Use only '+', '-', '\*')\n"
    evennum:    .asciiz "EVEN\n"
    oddnum:     .asciiz "ODD\n"

    .text
#.globl read 
.globl main 
.ent  main

main:
	#jal read
    #b exit          # unconditional branch to exit
#.end  main
#read:

        # grab command line args
    # a0 is arg count and a1 points to list of args
    move $s0, $a0     #
    move $s1, $a1
    # zero out these registers just to be safe
    move $s2, $zero   #
    move $s3, $zero   #
    move $s4, $zero   #

                        # check if three arguments are given - the total number
                        # check if less than one arguments is  given
    li $t0, 3           #

    ble $a0, $t0, error # if arg count is <= 3 exit with err msg 

    # parse the first number, the first argument
    lw $a0, 4($s1)
    jal atoi
    move $s2, $v0
     
    # parse the second number, the third argument
    lw $a0, 12($s1)
    jal atoi
    move $s3, $v0

    # check ascii value for second argument '+','-','*'
    lw $a0, 8($s1)      # $a0 holds the address of the 2nd cmd line arg
    lb $t2, ($a0)       # grab the first bye at the address 8($s1)

 
    # load a0 and a1 with two integers
    move   $a0, $s2 
    move   $a1, $s3
    # move a0 => t0, a1 ==> t1
    move $t0, $a0
    move $t1, $a1
    

    beq $t2, 43, addfunc    # test for addition '+'
    beq $t2, 45, subfunc    # test for subtraction '-'
    beq $t2, 42, mulfunc    # test for multiplication '\*'
    
    # if there isn't a valid operator, this error string will print.   
    li $v0, 4           # print a string 
    la $a0, unvalidop    # load address of string
    syscall

    

	                    # prompt for first integer
	#li $v0 4            # 4 is print string
	#la $a0, iprompt     # load address of prompt into $a0 to print
	#syscall             # display the prompt 

	                    # read the first integer 
	#li $v0 5            # setup syscall 5 (read_int)
	#syscall             # integer returned in $v0
	#move $t0, $v0       # move first integer to $t0

	                    # prompt for second integer
	#li $v0 4            # 4 is print string
	#la $a0, iprompt     # load address of prompt into $a0 to print
	#syscall             # display the prompt 

	                    # read the second integer 
	#li $v0 5            # setup syscall 5 (read_int)
	#syscall             # integer returned in $v0
	#move $t1, $v0       # move first integer to $t1

	                    # sum the two integers
	#add $t2, $t0, $t1 

	#move $a0,$t2        # move the result into register $a0
	#li $v0, 1           # setup syscall 1 (print_int)
	#syscall             # make the call to display the integer 

	#li $v0, 4           # print newline
	#la $a0, newline  
	#syscall          
    
    
	b exit              # unconditional branch to exit

.end  main

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
    lbu $t1, 0($a0)
     
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

addfunc:
    # add the 1st argument and 3rd arguments, the integers.  
    add $t3, $t0, $t1
    move $a0, $t3
    li $v0, 1       # print_int
    syscall

    li $v0, 4           # new line
    la $a0, newline
    syscall
    
    # check if the sum is even
    li $t0, 2       # load 2 into $t0
    div $t3, $t0    # divide sum by $t0
    mfhi $t2            
    beq, $t2, $0, even      # if remainder == 0, EVEN

    # if the number is odd, it will not jump to 'even' label and instead print 'odd'
    li $v0, 4           # print a string
    la $a0, oddnum      # load address of string
    syscall


    j exit    

subfunc:
    # subtract the 1st argument and 3rd arguments, the integers.  
    sub $t3, $t0, $t1
    move $a0, $t3
    li $v0, 1              # print_int
    syscall

    li $v0, 4              # new line
    la $a0, newline
    syscall
    
    # check if the difference is even
    li $t0, 2               # load 2 into $t0
    div $t3, $t0            # divide sum by $t0
    mfhi $t2
    beq, $t2, $0, even       # if remainder == 0, EVEN


    # if the number is odd, it will not jump to 'even' label and instead print 'odd'
    li $v0, 4           # print a string
    la $a0, oddnum      # load address of string
    syscall

    j exit

mulfunc:
    # multiply the 1st argument and 3rd arguments, the integers.  
    mul $t3, $t0, $t1
     move $a0, $t3
    li $v0, 1               # print_int    
    syscall

    li $v0, 4               # new line
    la $a0, newline
    syscall
    
    # check if the product is even
    li $t0, 2               # load 2 into $t0
    div $t3, $t0            # divide sum by $t0
    mfhi $t2
    beq, $t2, $0, even       # if remainder == 0, EVEN


    # if the number is odd, it will not jump to 'even' label and instead print 'odd'
    li $v0, 4           # print a string
    la $a0, oddnum      # load address of string
    syscall

    j exit

error:
    li $v0, 4           # print a string
    la $a0, errormsg    # load address of string
    syscall

even:
    # will tell you the number is even.
    li $v0, 4           # print a string
    la $a0, evennum     # load address of string
    syscall


exit:
	li  $v0,10          # 10 is exit system call
	li $a0, 0
    syscall    


