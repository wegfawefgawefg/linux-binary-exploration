#include <stdio.h>

static int POTATO = 4;

// function that adds 2 nums
int add(int num1, int num2)
{
    return POTATO + num2;
}

int main()
{
    int sum = add(1, 2);
    printf("%d", sum);

    return 0;
}
