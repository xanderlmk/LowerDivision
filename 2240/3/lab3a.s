# Xander Reyes

# Fib example from Appendix A, pp A-27 to A-29 (on CD)
#
# This implements the following program:
#
#   int main()
#   {
#       printf("The fibonacci number 11 is %d\n", fact(5));
#   }
#
#   int fact(int n)
#   {
#       if (n < 1)
#           return 1;
#       else
#           return n * fact(n-1);
#   }
#
.text
.globl main   # Start execution at main
.globl printf # 
.ent main     # Begin the definition of main

              # The book makes use of frame pointers in this example.
              # As described on page A-27, by convention a frame is 24 bytes
              # to store a0 - a3 and ra. This includes 4 bytes of padding.
              # To save fp, another 8 bytes are added (4 for fp and 4 for 
              # padding), making the frame 32 bytes long. Even though a0-a3
              # are not saved to the stack, space is still reserved on the
              # stack for them.
main:

  addi  $sp, $sp, -32 # Stack frame is 32 bytes long
  sw  $ra, 20($sp)    # Save return address
  sw  $fp, 16($sp)    # Save old frame pointer
  addi  $fp, $sp, 28  # point to first word in bottom of frame 

                      # With the return address and frame pointer saved, main()
                      # can now make all its needed function calls
  li  $a0, 11         # Put argument (11) in $a0
  jal  fib            # Call fibonacci function
  move $t0, $v0       # move result to t0

  la  $a0 msg         # load address of msg into $a0
  jal printf          # call printf
  
  la $a0 number
  move $a1, $t0
  jal printf

  li  $a0, 10         # ascii LF char
  li  $v0, 11         # syscall 1=print char 
  syscall             #

                      # Since the function calls are done, restore the return
                      # address and frame pointer.
  lw  $ra, 20($sp)    # Restore return address
  lw  $fp, 16($sp)    # Restore frame pointer
  addi  $sp, $sp, 32  # Pop stack frame

  li  $v0, 10         # 10 is the code to exiting the program
  syscall             # Execute the exit

.end main

.rdata
printf_buf:     .space 2
msg: .asciiz "The fibonacci of 11 is "
number:
    .asciiz "%d\n"
.ent fib  # Begin the definition of the fib function

.text      # Another segment of instructions
#---------------------------------------------------------------------------
fib:
#---------------------------------------------------------------------------
                      # As above, create a 32 byte frame to store a0-a3,
                      # ra and fp. For the fact procedure, a0 will be saved
                      # in offset 28 from the sp (offset 0 from the fp).

  addi $sp, $sp, -32  # Stack frame is 32 bytes long
  sw   $ra, 20($sp)   # Save return address
  sw   $fp, 16($sp)   # Save frame pointer
  addi $fp, $sp, 28   # Set up frame pointer
  sw   $a0, 0($fp)    # Save argument (n)
  

  lw    $v0, 0($fp)   # Load n
    
  li    $v1, 2        # Test value 2
  bgt   $v0, $v1, L2  # if n>2, branch to L2

  li $v0, 1           # Return 1
  j       L1          # Jump to return code



L2:
  lw    $v1, 0($fp)   # Load n
  addi  $v0, $v1, -1  # Compute n - 1
  move  $a0, $v0      # Move value to $a0
  jal   fib           # recursive call to fibonacci function
  sw $v0 4($sp)       # store the result of jal fib
    
  lw    $v1, 0($fp)  
  addi  $v0, $v1, -2  # Compute n - 2
  move  $a0, $v0      # Move value to $a0
  jal   fib           # recursive call to fibonacci function
  move $t0, $v0

  lw  $t1, 4($sp)     
  addu  $v0, $t0, $t1  # Compute fib(n-1) + fib(n-2) and  put result in $v0

L1:
  lw   $ra, 20($sp)  # Restore $ra
  lw   $fp, 16($sp)  # Restore frame pointer
  addi $sp, $sp, 32  # Pop stack frame
  jr   $ra           # Return to caller
.end fib

printf:
    subu  $sp, $sp, 36       # setup stack frame
    sw    $ra, 32($sp)       # save local environment
    sw    $fp, 28($sp)       # frame pointer
    sw    $s0, 24($sp)       # save $s registers
    sw    $s1, 20($sp)       # Callee is responsible for saving
    sw    $s2, 16($sp)       #   then restoring the $s registers.
    sw    $s3, 12($sp) 
    sw    $s4, 8($sp) 
    sw    $s5, 4($sp)
    sw    $s6, 0($sp)  
    addu  $fp, $sp, 36        # Modify the frame pointer.
    # It was pushed onto the stack above to save it.

    # grab the args and move into $s0..$s3 registers
    move $s0, $a0             # fmt string
    move $s1, $a1             # arg1 (optional)
    move $s2, $a2             # arg2 (optional)
    move $s3, $a3             # arg3 (optional)

    li   $s4, 0               # set argument counter to zero
    la   $s6, printf_buf      # set s6 to base of printf buffer

    main_loop:                    # process chars in fmt string
    lb   $s5, 0($s0)           # get next format flag
    addu $s0, $s0, 1           # increment $s0 to point to next char
    beq  $s5, '%', printf_fmt  # branch to printf_fmt if next char equals '%'
    beq  $0, $s5, printf_end   # branch to end if next char equals zero 

    printf_putc: 
    sb   $s5, 0($s6)           # if here we can store the char(byte) in buffer 
    sb   $0, 1($s6)            # store a null byte in the buffer
    move $a0, $s6              # prepare to make printf_str(4) syscall  
    li   $v0, 4                # load integer 4 into $v0 reg              
    syscall                    # make the call
    b    main_loop             # branch to continue the main loop

    printf_fmt: 
    lb   $s5, 0($s0)           # load the byte to see what fmt char we have 
    addu $s0, $s0, 1           # increment $s0 pointer 

    beq  $s4, 3,  main_loop    # if $s4 equals 3 branch to main_loop 
    beq  $s5,'d', printf_int   # decimal integer 
    beq  $s5,'s', printf_str   # string 
    beq  $s5,'c', printf_char  # ASCII char 
    beq  $s5,'%', printf_perc  # percent 
    b    main_loop             # if we made it here just continue 


    printf_shift_args:            # code to shift to next fmt argument
    move  $s1, $s2             # assign $s2 to $s1 
    move  $s2, $s3             # assign $s3 to $s2 
    add   $s4, $s4, 1          # increment arg count
    b     main_loop            # branch to main_loop

    printf_int:                   # print decimal integer
    move  $a0, $s1             # move $s1 into $v0 for print_int syscall
    li    $v0, 1               # load syscall no. 1 into $v0
    syscall                    # execute syscall 1
    b     printf_shift_args    # branch to printf_shift_args to process next arg

    printf_str:
    move  $a0, $s1             # move buffer address $s1 to $a0 for print_str(4) 
    li    $v0, 4               # setup syscall - load 4 into $v0 
    syscall
    b    printf_shift_args     # branch to shift_arg loop

    printf_char:                  # print ASCII character 
    sb    $s1, 0($s6)          # store byte from $s1 to buffer $s6
    sb    $0,  1($s6)          # store null byte in buffer $s6
    move  $a0, $s6             # prepare for print_str(1) syscall
    li    $v0, 4               # load 1 into $v0
    syscall                    # execute syscall 1
    b     printf_shift_args    # branch to printf_shift_args to process next arg

    printf_perc: 
    li   $s5, '%'              # handle %%
    sb   $s5, 0($s6)           # fill buffer with byte %
    sb   $0, 1($s6)            # add null byte to buffer 
    move $a0, $s6              # prepare for print_str(4) syscall
    li   $v0, 4              
    syscall                    # execute the call
    b    main_loop             # branch to main_loop

    printf_end:             # callee needs to clean up after itself
    lw   $ra, 32($sp)    # load word at address $sp+32 into return address reg 
    lw   $fp, 28($sp)    # load word at address $sp+28 into frame pointer reg 
    lw   $s0, 24($sp)    # restore values at addresses $sp+24 ... $sp+0 
    lw   $s1, 20($sp)    # ...
    lw   $s2, 16($sp)    # 
    lw   $s3, 12($sp)    # 
    lw   $s4,  8($sp)    # 
    lw   $s5,  4($sp)    # 
    lw   $s6,  0($sp)    # 
    addu $sp, $sp, 36    # release the stack frame
    jr   $ra             # jump to the return address




