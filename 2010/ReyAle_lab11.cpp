#include <iostream>
#include <fstream>


using namespace std;

int read_airports(string cities[], int threshold);

int main()
{
    string cities[20];
    int count, threshold;
    
    cout << "Enter a threshold number: ";
    cin >> threshold;

    count = read_airports(cities, threshold);
    
    cout << "The following airports have at least " << threshold << " terminals:" << endl;
    
    for (int i = 0; i < count; i++)
    {
        cout << cities[i] << endl;
    }

    return 0;
}

int read_airports(string cities[], int threshold)
{

int j = 0;
    
    //step 1 - delcare our file variable
    
    ifstream fin;
        
    // step 2 - Open the file

    fin.open("airports.txt");
    
    // step 3, check if file opened successfully

    if (fin.is_open())
    {
        // step 4 - read from the file
        // .eof() checks if you are at the end of the file
        string abbre;
        string city;
        int terminal;
    // step 5, make sure the read was "Successful"
     while (!fin.eof())
     {
         fin >> abbre >> city >> terminal;
        
         if (fin.good())
        {   
            if (terminal >= threshold)
            {
                cities[j] = city;
                j++;
            }
        }
     }

        //step 6
        fin.close();

    }

    else
    {
        cout << "Didn't work lol" << endl;
    }

    return j; 
}
