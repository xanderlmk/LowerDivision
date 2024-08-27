#include <stdio.h>



int main()
{
    union{
        float fnum;
        unsigned int inum;
    }   number;
    number.fnum = -2.5;

    printf("\nfloat %f in IEEE 754: \n", number.fnum);
    int i;
    for (i=31; i>=0; i--)
    {
        printf("%i",(number.inum >> i) & 1);
        if (i==31 || i == 31-8)
        {
            printf(" ");
        }
    }

    return 0;
}
