// Alexander Reyes
//
// Submit only your solution to fib
int countzeros( int index, int length, int* array ) {

    if ( index == length) 
        return 0;
    else if (array[index] != 0)
	    return countzeros(index+1, length, array);
    else ( array[index] == 0);
        return countzeros(index+1, length, array) + 1;
}

