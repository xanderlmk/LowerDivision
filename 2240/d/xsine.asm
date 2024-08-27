; Sample x86 program to calculate the sine of a real number.
; Xander Reyes
; CMPS-2240
;
; Some code written by student Tiara Smith in Fall 2020
;
; To assemble and link:
;
;   $ nasm -f elf64 xsine.asm
;   $ gcc -o xsine xsine.o   # use gcc so glibc will be linked in
;
; OR you could link manually with this:
; $ ld -dynamic-linker /lib64/ld-linux-x86-64.so.2 /usr/lib64/crt1.o \
;        /usr/lib64/crti.o xsine.o  /usr/lib64/crtn.o -lc -o xsine

section .rodata
    num_format db "%ld", 0
    format3_str db 10, "The value of d is: %f", 10, 10, 0 ; 10 is newline
    format4_str db "Sine(d) * 10 is: %f", 10, 10, 0
    int_format  db "Sine float converted to integer is: %i", 10, 10, 0

section .data
   val dq 123.45
   m   dq 10.0

section .text
   global main            ; main and _start are both valid entry points
   extern printf, scanf   ; these will be linked in from glibc 

   main:
                          ; prologue - setup a stack frame
   push    rbp            ; save base pointer to the stack
   mov     rbp, rsp       ; base pointer = stack pointer 
   sub     rsp, 16        ; make room for two long integers on the stack
   push    rbx            ; push callee saved registers onto the stack 
   push    r12            ; push automatically decrements stack pointer
   push    r13            ;
   push    r14            ;
   push    r15            ;
   pushfq                 ; push register flags onto the stack

                          ; working with floating-point registers
   movq xmm0, qword [val] ; move a 64 bit word
   mov rdi, format3_str   ; a format string saying the value of d
   mov rax, 1             ; move 1 into rax
   call printf            ; call printf to print integer
   mov rdi, format4_str   ; a format string saying the sine value
   fld qword [val]        ; push a value onto the floating point stack
   fsin                   ; calculate the sine
   fmul qword [m]         ; multiply by 10.0 just for fun
   fstp qword [val]       ; load a value from the floating pt stack (pop)
   movq xmm0, qword [val] ; move a 64-bit word to floating-point register
   call printf            ; calls printf
                          ;
   movsd xmm0, [val]      ; store back into xmm0 register
   cvttsd2si rax, xmm0    ; convert to integer 
   mov rsi, rax           ; move in an argument for printf
   mov rdi, int_format    ; format string to show integer
   push 0                 ; putting 0 onto stack
   pop rax                ; (pop) zero out rax register 
   call printf 
                          ; epilogue - cleanup the stack frame
   popfq                  ; pop the register flags
   pop     r15            ; pop in reverse order
   pop     r14            ;
   pop     r13            ;
   pop     r12            ;
   pop     rbx            ;
   add     rsp, 16        ; restore the starting stack level
   leave
   ret


