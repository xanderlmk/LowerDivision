// Alexander Reyes
// Submit only your solution to fib
int fib( int n ) {
    if (n == 0)
        return 0;
    else if ( n == 1)
        return 1;
    else
        return  (fib(n-2) + fib(n-1)); // fib(n-2) is the previous - 1, fib(n-1) is the previous
}

