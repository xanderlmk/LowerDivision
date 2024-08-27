# file: lab4a.s
# Xander Reyes
# Register Usage:  
#      $t0 - loop variable i  
#      $s0 - size of the array 
#      $s1 - base address of the array (i.e., a[0])
#      $t1 - holds i + 1 
#      $t2 - holds address a[i]; calculated as s1 (base address) + 4*i

.data
my_array:
        .space 120        # allocate 20 bytes to hold 5 4-byte integers 
newline:
        .asciiz   "\n"
onespace:
        .asciiz   " "
 
.text
.globl main
.ent main

main:
       li $s0, 30            # $s0 holds the size of the array
       la $s1, my_array      # load base address of array into $s1
       addi $t0, $zero, 0    # initialize i to 0
top:
       slt $t1, $t0, $s0     # set on less than
                             # t1 = (i < size) ? 1 : 0;
       beq $t1, $zero, second_line  # jump to second loop if i >= size
       addi $t1, $t0, 0     # Add 0 to i, store in t1
       add  $t1, $t1, $t1   # multiply i by 2,but add # + #
       addi $t1, $t1, 1     # add one to make value odd

       sll $t2, $t0, 2       # shift left logical.
                             # Calculate i*4, store in t2
       add $t2, $t2, $s1     # Calculate address of a[i]
       sw $t1, 0($t2)        # Store t1 to element address
       addi $t0, $t0, 1      # Increment i



       li $v0, 1             # print the element you just stored in the array 
       lw $a0, 0($t2)        # load int value from the array into a register
       syscall 
       li $v0, 4
       la $a0,onespace 
       syscall
       j top                 # Go to next iteration


second_line:

       li $v0, 11            # print new line   
       la $a0, 10
       syscall
       
      li $s0, 30            # $s0 holds the size of the array
       la $s1, my_array      # load base address of array into $s1
       addi $t0, $zero, 0    # initialize i to 0
top2:
       slt $t1, $t0, $s0     # set on less than
                             # t1 = (i < size) ? 1 : 0;
       beq $t1, $zero, Exit  # jump to second loop if i >= size
       addi $t1, $t0, 0     # Add 0 to i, store in t1
       add  $t1, $t1, $t1   # multiply i by 2,but add # + #
       addi $t1, $t1, 1     # add one to make value odd

       sll $t2, $t0, 2       # shift left logical.
                             # Calculate i*4, store in t2
       add $t2, $t2, $s1     # Calculate address of a[i]
       lw $t1, 0($t2)        # Load t1 to element address
div37: 
       li $t3, 7
       li $t4, 3
       lw $a0, 0($t2)
       div $a0, $t3
       mfhi $a0
       beq $a0, $0, show

       div $a0, $t4
       mfhi $a0
       beq $a0, $0, show
     
next_num:
       addi $t0, $t0, 1      # Increment i
       j top2


how:
       li $v0, 1             # print the element you just stored in the array 
       lw $a0, 0($t2)        # load int value from the array into a register
       syscall 
       li $v0, 4
       la $a0,onespace 
       syscall

       j next_num
        
       

Exit:
       li $v0, 4             # display a newline
       la $a0, newline
       syscall
       li $v0, 10            # exit
       li $a0, 0
       syscall
.end main


