#
# Navigator : Eduardo Meza
# Driver : Xander Reyes
# xlab13.s
# a program to demonstrate the structure of a MIPS source program for lab1
# take this file and modify it
#
# Usage: $ spim -f lab1.s

     .data                   # what follows is in data segment of executable
stuff: .asciiz "Go Roadrunners\n"    # the z adds a trailing \0 null char
#choosenum: .asciiz "Choose number: "
.text                   # code follows 
main:
    #la $a0, choosenum       # load address into $a0
    #li $v0, 4               # print string
    # syscall

    # li $v0, 5
    # syscall
    # move $t0, $v0
        
     li $t0, 3              # load immediate value 3 into $t0
loop:
    
     li $t1, 1171250         # this will be the delay for each string
     jal delay               # jump and load delay

     la $a0, stuff           # stuff is an address of a string
     jal printf

     li $v0, 4               # 4 is syscall to print a string
     syscall                 # execute the call 
     
     
     add $t0, $t0, -1       # subtract 1
     bgt $t0, $0, loop       # check if the loop has iterated 3 times
     
     li $v0, 10              # 10 is system call to exit
     syscall                 # execute the call 

delay:
    addi $t1, $t1, -1       # this loop will cause the delay
    bgez $t1, delay         # by subtracting 1 each loop from a big number
    jr $ra                  # jump back to register address
