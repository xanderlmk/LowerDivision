#include <stdio.h>
#include <string.h>
extern int func(char* s1, char* s2, int);
// the definition of func is written in assembly language
__asm__(".globl func\n\t"
        ".type func, @function\n\t"
        "func:\n\t"
        ".cfi_startproc\n\t"
        "mov (%rdi), %esi\n\t"
        "mov (%rsi), %edi\n\t"
        "mov %rdx, (%ecx)\n\t"
        "cld\n\t"
        "rep movsb\n\t" 
        "ret\n\t"
        ".cfi_endproc");

int main(void)
{
    char name1[7] = "Gordon";
    char name2[100];
    char name3[100];
    int i;
    int slen = (int)sizeof(name1);
    for (i=0; i<slen; i++)
    {
        name2[i] = name1[i];
    }
    //use inline assembly to copy name1 to name3 using movsb
    //
    


    printf("sizeof name1: %i\n", (int)sizeof(name1));
    printf("name2 **%s**\n", name2);
    func(name1, name3, slen);

   // strcpy(name3,func(name3, name1));
    printf("name3 **%s**\n", name3);
    
    return 0;
}

