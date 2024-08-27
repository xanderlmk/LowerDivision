#include <iostream>
#include <fstream>

using namespace std;

int calc_hash(string word)
{
    int value[26] = { 1, 2, 3, 4 , 5 , 6, 7 , 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26};
    char letter[26] { 'a' , 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q' , 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z'};
    int x = 0; // this will be the variable that counts the hash value

    for (int i = 0; i < word.length(); i++) // this will run through each letter of the word
    {
        for (int ii = 0; ii < 26; ii++)
        {
            if (word[i] == letter[ii]) // if the current letter of the word is equal letter[ii], value[ii] will be added to x.
            {
                x = x + value[ii];
            }
        }
    }



    return x;
}

void show(int size, int collisions[])
{
    int hash_value = 0; //the hash value with the most collisions
    int largest_num = 0; // largest number of collisions

    for (int i = 1; i < size; i++)
    {
        cout << "Hash value: " << i  << ", Collisions: " <<  collisions[i] << endl;

        if ( i > 1)
        { 
            if (collisions[i] > largest_num)
            {
                hash_value = i; // if the collisions[i]'s collisions is greater than the current largest number of collisions,
                // hash_value will equal to i, which is the current hash value
                largest_num = collisions[i];   // if the collisions[i]'s collisions is greater than the current largest number of collisions,
                // largest_num will equal to collisions[i], the number of collisions at the i hash value.
            }
        }
    }

    cout << "Hash value with the most collisions: " << hash_value << endl;
    cout << "Largest number of collisions: " << largest_num << endl;
}

int main()
{
    int collisions[320] = {-1};
    int hash_val;
    int size = 320;

    ifstream fin;
    fin.open("enable1.txt");
    if (fin.is_open())
    {
        string word;

        while (!fin.eof())
        {
            fin >> word;

            if(fin.good())
            {
                hash_val = calc_hash(word);
                collisions[hash_val] = collisions[hash_val] + 1;
            }
        }

        fin.close();
    }

    show(size, collisions); // calls the function show, which will show all the contents of the collisions table,
    // the hash value with the most collisions, and the largest number of collisions

    return 0;
}
