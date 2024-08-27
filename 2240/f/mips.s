.globl main

.data 
name: .asciiz "xander\n"

.text

main:

li $v0, 4
la $a0, name
syscall

li $v0, 10
syscall
