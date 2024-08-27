#
# Navigator : Eduardo Meza
# Driver : Xander Reyes
# xlab13.s
# a program to demonstrate the structure of a MIPS source program for lab1
# take this file and modify it
#
# Usage: $ spim -f xlab13.s

.data                   # what follows is in data segment of executable
stuff: .asciiz "Go Roadrunners\n"    # string    
.text
# code follows 
main:
    
     add $t9, $t9, 1       # this loop will cause the delay
     bne $t9, 577500, main
     move $t9, $0

     la $a0, stuff              # stuff is an address of a string
     li $v0, 4                  # 4 is syscall to print a string

     syscall                    # execute the call 

     add $t8, $t8, 1            # add 1
     bne $t8, 3, main           # check if the loop has iterated 3 times
     
     li $v0, 10                 # 10 is system call to exit
     syscall                    # execute the call 
