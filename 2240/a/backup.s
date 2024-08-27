# Author: Xander Reyes
# Please complete the decrypt10 function.
# Coding is in the AT&T syntax.
# A stack-frame is not needed.
# See instructions on lab page.

.text
.global decrypt10
.type decrypt10, @function


.global decrypt10xx
.type decrypt10xx, @function

decrypt10:
    
    movq %rdi, %rsi         # store the address in rsi
top1:
    movb (%rsi), %al        # a character is 8-bits
                            # so store a character into al (8bit register)
    cmp $0, %al             # check for EOF
    je done1                # if EOF done
    

    ror $2, %al             # roll al over 2bits
    
    movb %al, (%rsi)        # move AL back into rsi
    
    inc %rsi                # increament rsi by one
    
    jmp top1                # loop till each character is done

done1:


    ret          # return from the function



decrypt10xx:
    
    movq %rdi, %rsi         # store the address in rsi
top2:

    movb (%rsi), %al
    cmp $0, %al
    je done2
   
    mov %al, %bl          # copy AL into BL
    mov %al, %cl          # copy AL into CL

    shr $1, %bl             # shift BL right by 1 bit
    shr $6, %cl             # shift CL right by 6 bits
    
    and $1, %bl             #  and 1 and %bl
    and $1, %cl             #  and 1 and %cl

    xor %bl, %cl            # exclusive or BL and CL
    
    
    mov %bl, %cl            # copy BL into CL

    shl $1, %bl             # shift BL left by 1-bit
    shl $6, %cl             # shift CL left by 6-bits

    or %cl, %bl             # or them out
    
    xor %al, %cl 

                
    ror $2, %al

    movb %al, (%rsi)              
    
    inc %rsi
    
    jmp top2

done2:

    ret          # return from the function

