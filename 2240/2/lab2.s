# Xander Reyes
# filename: lab2.s
# purpose:  test output facilities in print.s and input facilities in read.s

#  spim> re "lab2.s"
#  spim> re "print.s"
#  spim> re "read.s"
#  spim> run
#  spim> exit 

.text
.globl  main       # globl = main can be accessed from outside this file.
.ent  main         # entry point for main
.globl printf

main:
    la  $a0,format1     # Load address of format string #1 into $a0
    jal printf          # call printf

                        # test single %d 
    la  $a0,format2     # load address of format string #2 into $a0
    jal printf          # call printf

                        # test one %d format string
    la  $a0,format3     # load address of format string #3 into $a0
    li  $a1, 2022       # load integer 2022 into $a1
    jal printf          # call printf

                        # promt user to input first name
    la  $a0,format4     # load address of format string #4 
    jal printf          # call printf

                        # read the firstname string
    la $a0 fname_buf    # load address of fname_buf
    li $v0 8            # setup syscall 8 (read_string)
    syscall             # address of string fname_buf returned in $a0


                        # promt user to input last name
    la  $a0,format5     # load address of format string #5 into $a0
    jal printf          # call printf 

                        # read the lastname string
    la $a0 lname_buf    # load address of lname_buf
    li $v0 8            # setup syscall 8 (read_string)
    syscall 


                        # promt user to enter 3 digit ID
    la  $a0 format6     # load address of format string #6 into $a0
    jal printf          # call printf 

                        # read the integer and display it 
    li $v0 5            # setup syscall (read_int) 
    syscall             # integer returned in $v0
    move $t0 $v0        # move the integer into temp $t0


    la $a0, firstn      # load address of format firstn into $a0
    la $a1, fname_buf   # load address of fname_buff
    jal printf          # call printf

    la $a0, lastn       # load address of format firstn into $a0
    la $a1, lname_buf   # load address of lname_buff
    jal printf          # call printf


    la $a0, format7     # load addres of format #7 into $a0
    move $a1, $t0       # move int $t0 into register $a1
                        # this will print the int on register $a1
    jal printf          # call printf

    li  $v0,10          # 10 is exit-program system call
    syscall    

    .end  main

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


    .data
    format1: 
    .asciiz "Go\n"        # asciiz adds trailing null byte to string
    format2:
    .asciiz "CSUB Roadrunners\n"  
    format3: 
    .asciiz "in %d!\n"
    a_string:
    .asciiz "I am a string"
    format4: 
    .asciiz "first name: " 
    format5: 
    .asciiz "last name: "
    format6:
    .asciiz "ID Number (3 digit): "
    format7:
    .asciiz "id:        %d\n"
    firstn:
    .asciiz "firstname: %s"
    lastn:
    .asciiz "lastname:  %s"
    fname_buf:
    .space 32
    lname_buf:
    .space 32

    printf_buf:     .space 2
