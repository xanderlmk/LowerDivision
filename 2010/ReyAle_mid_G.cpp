#include <iostream>
#include <cstring>
#include <cctype>

using namespace std;

void as_title_case(char source[], char dest[]);

int main()
{
    
    char input[128];
    char titlecase[128];

    cout << "Emter a string (all in lowercase): ";

    cin.getline(input, 128);

    as_title_case(input, titlecase);
    
    cout << "Title case version: " << titlecase << endl;

    return 0;
}

void as_title_case(char source[], char dest[])
{
        // title case has every first char
    for (int i = 0; i < strlen(source); i++)
    {
        if (i == 0)
        {
            dest[i] = toupper(source[i]);
        }

        else if (source[i-1] == ' ')
        {
            dest[i] = toupper(source[i]);
        }
        else
        {
            dest[i] = source[i];
        }
    }

}

