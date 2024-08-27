#include <stdio.h>

static inline void hello(int a, int b)
{
    printf("WAZZAKILLA %i %i\n", a, b);
};

int main(void)
{
    hello(1, 2);

    return 0;
}


