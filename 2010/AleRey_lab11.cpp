#include <iostream>
#include <chrono>
#include <cstdlib>
#include <ctime>

using namespace std;

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
    for (int i = size - 1; i >= 0; i--)
    {
        array[i] = i + 1;
    }
}

void bubble_sort(int array[], int size)
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

void opti_bubble_sort(int array[], int size)
{
    bool x = false;

    do
    {
        x = false;

        for (int i = 0; i < size-1; i++)
        {
            if (array[i] > array[i+1]) 
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
 
        while (j >= 0 && array[j] > key)
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

void show_array(int array[], int size)
{
    for( int i = 0; i < size; i++)
    {
        cout << array[i] << " ";
    }
    cout << endl;
}

int main()
{
    srand(time(NULL));

    // more code here

    int arraysize;
    /*
    int test[10];
    int chosen;
   
    cout << "Choose 10 random integers: " << endl;
    for (int i = 0; i < 10; i++)
    {
        cin >> test[i];
    }
    insertion_sort(test, 10);
    show_array(test, 10);
    */

    cout << "Enter array size: ";
    cin >> arraysize;
    int array[arraysize];

    cout << "Bubble sort (Random) took ";
    fill_array_random(array, arraysize, 1000, 1000000); 
    auto start = chrono::steady_clock::now();
    bubble_sort(array, arraysize);
    auto end = chrono::steady_clock::now();
    cout << chrono::duration_cast<chrono::milliseconds>(end-start).count() << endl;
 
   
    cout << "Optimized Bubble sort (Random) took ";
    fill_array_random(array, arraysize, 1000, 1000000);
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

    return 0;
}
