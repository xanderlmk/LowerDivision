#include <iostream>
#include <cstring>

using namespace std;

int copycat(char input[], int size);

int main()
{

    char input[100];
    
    int size;
  
    do
    {

    cin.getline(input, 100);
    
    int size = strlen(input);

    copycat(input, size);
    
    
    } while (copycat(input, size) != 0);

    return 0;
}

int copycat (char input[],int size)
{

    /*  
    
    else if (i = 2)
    {
        cout << "Hey, be nice!" << endl;
    }

    else (i = 3);
    {
        cout << input << endl;
    }
*/
    return i;
}    
