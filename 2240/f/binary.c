#include <stdio.h>

void binary(int num)
{
    if (num == 0){
        printf("0");
        return;
    }
    int digit;
    digit = num % 2;
    num = num / 2;
    binary(num);
    printf("%d", digit);
}

int main()
{
    printf("Enter a number: ");
    int number;
    scanf("%d", &number);
    printf("number: %d\n", number);

    printf("binary digits: ");
    binary(number);
    printf("\n");

    return 0;
}

