#include <iostream>

using namespace std;

int main()
{

    for (int i = 1; i <= 3; i++)
    {
        cout << "ITERATION " << i << endl;

        for (int j = 8; j >= 0; j--)
        {
            cout << j << " ";
        }
    
        cout << " " << endl;

        for (int p = 1; p <= 10; p++)
        {         
             cout << p * 10 << " ";
        }
        cout << " " << endl;           
    }


    return 0;
}

