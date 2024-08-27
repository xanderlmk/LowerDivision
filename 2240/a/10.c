#include <stdio.h>

int main(void)
{
    //float f1 = 1.0f/10.0f;
    //float tot = 0.0f;

    double f1 = 1.0/10.0;
    double tot = 0.0;
    printf("total: %lf\n", tot); 
    
    tot = tot + f1;
    tot = tot + f1;
    tot = tot + f1;
    tot = tot + f1;
    tot = tot + f1;
    tot = tot + f1;
    tot = tot + f1;
    tot = tot + f1;
    tot = tot + f1;
    tot = tot + f1;
    
    printf("total: %1.20lf\n", tot); 

    if (tot == 1.0f)
        printf("Good Total!!!\n");

    return 0;
}
