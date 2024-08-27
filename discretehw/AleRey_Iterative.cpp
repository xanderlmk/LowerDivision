// Alexander Reyes

int fib( int n ) {
    if ( n == 0) // fib(0) is 0
        return 0;
    int kmm = 0; // k - 1 
    int k = 1; // k
    int i = 1; // the index
    while( i < n)
    {
        int tmp = kmm + k; //temp value, (k-1) + k
        kmm = k; // increase k-1 to k 
        k = tmp; // make k = to temp value, which is the current sum of the Ai.
        i++; // move up an integer on the index
    }

	return k;
}

