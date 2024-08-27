; lab8.asm
; CMPS 2240 lab8 
; Author: Xander Reyes 
; prompt and read two integers from stdin, compare and display larger integer
; uses printf and scanf from glibc 
;
; You job is to modify this program to sum the two integers and display the 
; result. You can leave existing code alone.
;
;
; To assemble and link:
;
;     $ nasm -f elf64 lab8.asm
;     $ gcc -o lab8 lab8.o   # use gcc so glibc will be linked in
;
; OR you could link manually with this:
; $ ld -dynamic-linker /lib64/ld-linux-x86-64.so.2 /usr/lib64/crt1.o \
;        /usr/lib64/crti.o lab8.o  /usr/lib64/crtn.o -lc -o lab8

; Example of printf() in a C program:
;
; printf("numbers: %ld %ld \n", num1, num2);
;

section .rodata                            ; rodata meand read-only data
   prompt1    db "Enter an integer: ", 0   ; 0 is null character
   prompt2    db "Enter another integer: ", 0
   format_str db "The greater of %ld and %ld is %ld.", 10, 0  ; 10 is LF
   sum_str    db "The sum of %ld and %ld is %ld.", 10, 0 
   num_format db "%ld", 0
   equal_str  db "%ld and %ld are equal.", 10, 0
section .text
   global main              ; main and _start are both valid entry points
   extern printf, scanf     ; these will be linked in from glibc 

   main:
      ; prologue
      push   rbp          ; save base pointer to the stack
      mov    rbp, rsp     ; base pointer = stack pointer 
      sub    rsp, 16      ; make room for two long LOCAL integers on the stack
      push   rbx          ; push callee saved registers onto the stack 
      push   r12          ; push automatically decrements stack pointer
      push   r13          ; r12, r13, etc. are general purpose registers
      push   r14          ;
      push   r15          ;
      pushfq              ; push register flags onto the stack

                                   ; prompt for first integer 
      mov    rdi, dword prompt1    ; double word is 4 bytes; a word is 2 bytes
                                   ; rdi = 32-bit address of prompt1
      xor    rax, rax              ; rax is return value register - zero it out
      call   printf                ; call the C function from glibc 

      ; read first integer 
      lea    rsi, [rbp-8]          ; load effective address - this instruction
                                   ; computes the address 8 bytes above the
                                   ; base pointer - the integer read by scanf 
 
      mov    rdi, dword num_format ; load rdi with address to format string
      xor    rax, rax              ; zero out return value register
      call   scanf                 ; call C function
                                   ; scanf reads the input as an integer

      ; prompt for second integer 
      mov    rdi, dword prompt2
      xor    rax, rax
      call   printf

      ; read second integer 
      lea    rsi, [rbp-16]
      mov    rdi, dword num_format
      xor    rax, rax
      call   scanf

      ; determine if num2 (second integer) is greater than num1 (first integer)
      xor    rbx, rbx      ; RBX = 0x0
      mov    rax, [rbp-16] ; RAX = num2 ; load rax with value at rdb-16
      cmp    rax, [rbp-8]  ; compute (num1) - (num2) and set condition codes
                            ; in machine status word register based on result
      jl    lessthan      ; jump if num1 < num2 
      je    equalto       ; jump if num1 == num2

      ; check num1 > num2
      mov    rdi, dword format_str  ; point to the address of format_str
      mov    rsi, [rbp-8]     ; num1
      mov    rdx, [rbp-16]    ; num2
      mov    rcx, [rbp-16]    ; greater of the two 
      xor    rax, rax         ; zero rax
      call   printf
      jmp sumofnum            ; unconditional jump to sumofnum
     
lessthan:
      ; check num1 < num2
      mov     rdi, dword format_str  ; point to the address of format_str
      mov     rsi, [rbp-8]   ; num1
      mov     rdx, [rbp-16]  ; num2
      mov     rcx, [rbp-8]   ; greater of the two
      xor     rax, rax       ; zero the rax register
      call   printf
      jmp sumofnum           ; unconditional jump to sumofnum

equalto:
      ; check num1 == num2
      mov    rdi, dword equal_str   ; point to the address of equal_str
      mov    rsi, [rbp-8]     ; num1
      mov    rdx, [rbp-16]    ; num2
      xor    rax, rax         ; zero rax
      call   printf


sumofnum:
      mov    rdi, dword sum_str   ; point to the address of sum_str
      mov    rsi, [rbp-8]     ; num1
      mov    rdx, [rbp-16]    ; num2
      mov   rcx, [rbp-16] ; load rcx with value 16 bytes from base ptr
      add   rcx, [rbp-8]  ; add num2 and num1 - store result in rcx

exit:
      call    printf         ;
                             ; restore stack frame
      popfq                  ; epilogue
      pop     r15            ;
      pop     r14            ;
      pop     r13            ;
      pop     r12            ;
      pop     rbx            ;
      add     rsp, 16        ; set back the stack level
      leave                  ; program is ending
      ret                    ; return


