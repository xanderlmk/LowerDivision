#include <iostream>
#include <chrono>
#include <cstdlib>
#include <ctime>
#include <unistd.h>

using namespace std;

void show_array(int array[], int size)
{
    for( int i = 0; i < size; i++)
    {
        cout << array[i] << " ";
    }
    cout << endl;
}

void swap(int *a, int *b)
{
    int tmp = *a;
    *a = *b;
    *b = tmp;
}


void fill_array_random(int array[], int size, int lbounds, int ubounds)
{
    for (int i = 0; i < size; i++)
    {
        array[i] = (rand() % (ubounds - lbounds)) + lbounds;
    }
}

void fill_array_inc(int array[], int size)
{
    for (int i = 0; i < size; i++)
    {
        array[i] = i + 1;
    }
}

void fill_array_dec(int array[], int size)
{
    int a = 1;
    for (int i = size - 1; i >= 0; i--)
    {   
        array[i] = a;
        a++;
    }
}

void bubble_sort(int array[], int size) //bubble sort
{
    for (int i = 0; i < size; i++)
    {
        for (int ii = 0; ii < size-1; ii++)
        {
            if (array[ii] > array[ii+1]) 
            {
                int tmp = array[ii];
                array[ii] = array[ii+1];
                array[ii+1] = tmp;
            }
        }
    }
}

void opti_bubble_sort(int array[], int size) // optimized bubble sort
{
    bool x = false;

    do
    {
        x = false;

        for (int i = 0; i < size-1; i++)
        {
            if (array[i] > array[i+1]) // swap the values if i > i+1 and x will become true because there is a swap.
            {
                x = true;
                int tmp = array[i];
                array[i] = array[i+1];
                array[i+1] = tmp;
            }
        }

    } while (x != false);
}

void insertion_sort(int array[], int size)
{
 int i, key, j;
    for (i = 1; i < size; i++)
    {
        key = array[i];
        j = i - 1;
 
        while (j >= 0 && array[j] > key) // when array at position j is greater  than array[i], which is key, array of j will keep going till it is less than key.
        {
            array[j + 1] = array[j];
            j = j - 1;
        }
        array[j + 1] = key;
    }
}
void insertion_sort1(int array[], int l,int h)
{
 int i, key, j;
    for (i = l; i <= h; i++)
    {
        key = array[i];
        j = i - 1;
 
        while (j >= 0 && array[j] > key) // when array at position j is greater  than array[i], which is key, array of j will keep going till it is less than key.
        {
            array[j + 1] = array[j];
            j = j - 1;
        }
        array[j + 1] = key;
    }
}

void selection_sort(int array[], int size)
{
    int i, j, min_idx;

    for (i = 0; i < size-1; i++)
    {
        // Find the minimum element in unsorted array
        min_idx = i;
        for (j = i+1; j < size; j++)
        {
        if (array[j] < array[min_idx])
            min_idx = j;
        }

        int tmp = array[min_idx];
        array[min_idx] = array[i];
        array[i] = tmp;
    }
}

int get_pivot_pos(int array[], int l, int h)
{
    int a = array[l];
    int b = array[(l+h)/2];
    int c = array[h];
    int pos;

    if ( (a > b && a < c)|| (a < b && a > c) )
        pos = l;
    else if ( (b > a && b < c) || (b > c && b < a) )
        pos = (l+h)/2;
    else //( (c > a && c < b) || (c > b && c < a) );
        pos = h;
        
    return pos;
}

int partition(int array[], int l, int h)
{
    int pv = get_pivot_pos(array,l,h);
    swap(&array[pv], &array[h]);
    
    int k = array[h];
    int j = h-1;
    int i = l;

    while (i < j) 
    {
        //cout << "i " << i << " j " << j << endl;

        if (array[j] < k && array[i] > k) //k is the pivot value
            {
                swap(&array[i], &array[j]);
            }
        if (array[i] <= k)
        {
            i++;
        }
        if (array[j] >= k)
        {
            j--;
        }

        //show_array(array, 17);
    }
    swap(&array[i], &array[h]);

    return i;

}

void quicksort(int data[], int l,int h)
{
     // modify to call an insertion sort
  // if partition size is 5 or less
  //
   if ((h-l) <= 5)
  {
      insertion_sort1(data, l, h);
  }
   else
   {
    if (l < h)
    {
        int p = partition(data, l, h);
        quicksort(data, l, p-1);
        quicksort(data, p+1, h);
    }
   }
  
}

int main()
{
    srand(time(NULL));

    // more code here

    int arraysize;
    
    int test[10] = { 1, 29, 100, 47, 25, 8, 10, 7 , 8, 17};
    /*
    int chosen;
   
    cout << "Choose 10 random integers: " << endl;
    for (int i = 0; i < 10; i++)
    {
        cin >> test[i];
    }
    insertion_sort(test, 10);
    show_array(test, 10);
    */
/*
    cout << "Enter array size: ";
    cin >> arraysize;
    int array[arraysize];

    cout << "Bubble sort (Random) took ";
    fill_array_random(array, arraysize, 1000, 1000000); 
    auto start = chrono::steady_clock::now();
    bubble_sort(array, arraysize);
    auto end = chrono::steady_clock::now();
    cout << chrono::duration_cast<chrono::milliseconds>(end-start).count() << endl;
 
   
    cout << "Optimized Bubble sort (Increasing) took ";
    fill_array_inc(array, arraysize);
    start = chrono::steady_clock::now();
    opti_bubble_sort(array, arraysize);
    end = chrono::steady_clock::now();
    cout << chrono::duration_cast<chrono::milliseconds>(end-start).count() << endl;

    cout << "Bubble sort (Increasing) took ";
    fill_array_inc(array, arraysize);
    start = chrono::steady_clock::now();
    bubble_sort(array, arraysize);
    end = chrono::steady_clock::now();
    cout << chrono::duration_cast<chrono::milliseconds>(end-start).count() << endl;

    cout << "Bubble sort (Decreasing) took ";
    fill_array_dec(array, arraysize);
    start = chrono::steady_clock::now();
    bubble_sort(array, arraysize);
    end = chrono::steady_clock::now();
    cout << chrono::duration_cast<chrono::milliseconds>(end-start).count() << endl;
    
    cout << "Insertion sort (Random) took ";
    fill_array_random(array, arraysize, 1000, 1000000);
    start = chrono::steady_clock::now();
    insertion_sort(array, arraysize);
    end = chrono::steady_clock::now();
    cout << chrono::duration_cast<chrono::milliseconds>(end-start).count() << endl;
    
    cout << "Insertion sort (Increasing) took ";
    fill_array_inc(array, arraysize); 
    start = chrono::steady_clock::now();
    insertion_sort(array, arraysize);
    end = chrono::steady_clock::now();
    cout << chrono::duration_cast<chrono::milliseconds>(end-start).count() << endl;
 
    cout << "Insertion sort (Decreasing) took ";
    fill_array_dec(array, arraysize); 
    start = chrono::steady_clock::now();
    insertion_sort(array, arraysize);
    end = chrono::steady_clock::now();
    cout << chrono::duration_cast<chrono::milliseconds>(end-start).count() << endl;


    cout << "Selection sort (Random) took ";
    fill_array_random(array, arraysize, 1000, 1000000); 
    start = chrono::steady_clock::now();
    selection_sort(array, arraysize);
    end = chrono::steady_clock::now();
    cout << chrono::duration_cast<chrono::milliseconds>(end-start).count() << endl;


    cout << "Selection sort (Increasing) took ";
    fill_array_inc(array, arraysize); 
    start = chrono::steady_clock::now();
    selection_sort(array, arraysize);
    end = chrono::steady_clock::now();
    cout << chrono::duration_cast<chrono::milliseconds>(end-start).count() << endl;
 
    cout << "Selection sort (Decreasing) took ";
    fill_array_dec(array, arraysize); 
    start = chrono::steady_clock::now();
    selection_sort(array, arraysize);
    end = chrono::steady_clock::now();
    cout << chrono::duration_cast<chrono::milliseconds>(end-start).count() << endl;
    
   */
    int size; 
    cout << "Enter array size for Quick sort: ";
    cin >> size;
    int data[size];
   
    cout << "Quick sort (Random) took ";
    fill_array_random(data, size, 1000, 1000000); 
    auto start = chrono::steady_clock::now();
    quicksort(data, 0, size-1);
    auto end = chrono::steady_clock::now();
    cout << chrono::duration_cast<chrono::milliseconds>(end-start).count() << endl;
    //show_array(data, size);

    return 0;
}
