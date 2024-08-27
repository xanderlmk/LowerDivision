#include <iostream>
#include <cstring>
#include <cctype>

using namespace std;

int main()
{

    char sentence[127];

    cout << "Enter a sentence with 127 characters or less." << endl;
    cin.getline(sentence,127);
    
    int size = strlen(sentence);

    int amount_e = 0;

    for (int i = 0; i < size; i++)
    {   
        if (sentence[i] == 'e')
        {
            amount_e = amount_e + 1;
        }
    }

    cout << amount_e << " amount of e's are displayed in this sentence" << endl;    
        
    return 0;
}

