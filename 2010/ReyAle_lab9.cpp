#include <iostream>
#include <cstring>
#include <cctype>

using namespace std;

int get_int(char prompt[], int min, int max);

int validate_password(char pwd[], int min_uppers, int min_lowers, int min_length);

int main()
{
    
    char pwd[20];
    int min_uppers, min_lowers, min_length;
  

    cout << "How many upper case characters are required?" << endl;

    min_uppers = get_int(pwd, 1, 3);
    
    
    cout << "How many lower case characters are required?" << endl;
    

    min_lowers = get_int(pwd, 1, 3);
    

    do
    {
        cout << "What is the minimum length(6-8)? ";
        cin >> min_length;

            if (min_length < 6 || min_length > 8)
            {
                cout << ": NUMBER MUST BE WITHIN RANGE" << endl;
            }

    } while (min_length < 6 || min_length > 8);
    

    cout << "OK" << endl;
   
    
    int val;
    
   val = validate_password(pwd, min_uppers, min_lowers, min_length);
   
   while (val != 0)
        {
            cout << "Enter your password: " << endl;

            cin.getline(pwd, 20);
            
         val = validate_password(pwd, min_uppers, min_lowers, min_length);
   

         switch (val)
            {
            case 1: cout << "Password invalid - Password too short\n";
                   
                    break;
            
            case 2: cout << "Password invalid - Password too long\n";
                    
                    break;
            
            case 3: cout << "Password invalid - Needs at least " << min_lowers << " lower(s)\n";
                    break;
            
            case 4: cout << "Password invalid - Needs at least " << min_uppers << " upper(s)\n";
                    
                    break;
            }                
        }

            

        cout << "That passwrd is OK\n";

    return 0;
}

int get_int(char prompt[], int min, int max)
{
    int i;
    
    do
    {
    cin >> i;
    } while (i < min || i > max);
    
    prompt[i];

    return i;
}


int validate_password(char pwd[], int min_uppers, int min_lowers, int min_length)
{
    int i;
    
    int size = strlen(pwd);
    
    int low = 0;
    int up = 0;


    // this for loop checks for any upper case letters. if there's the min. i = 0
    for ( int a = 0; a < size; a++)
    {
        isupper(pwd[a]);
        
        
        if(isupper(pwd[a]) > 0)
        {
           
           up = up + 1; 
           
        }

        
        if (up >= min_uppers)
        {
            i = 0;
        }
    }


    // this for loop checks for lower case letters, if there's the min, i = 0
    for ( int b = 0; b < size; b++)
    {
        islower(pwd[b]);
        
        if(islower(pwd[b]) > 0)
        {
            low = low + 1;
        }

        if (low >= min_lowers)
        {
            i = 0;
        }
    }

    if (size < min_length)
    {
        i = 1;
    }

    else if (size > 12)
    {
        i = 2;
    }
    
    else if (low < min_lowers)
    {
        i = 3;
    }

    else if (up < min_uppers)
    {
        i = 4;
    }

    else 
    {
        i = 0;
    }

   return i;
}
