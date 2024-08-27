#include <iostream>

using namespace std;

string get_sign_name(int value);

int main()
{

    int value;

    cout << "Enter a single number: ";
    cin >> value;
    
    
    get_sign_name(value);

    cout << get_sign_name(value) << endl;

    return 0;
}


string get_sign_name(int value)
{
    string sign;

    if (value > 0)
    {
        sign = "Positive";
    }

    else if (value == 0)
    {
        sign = "Zero";
    }

    else
    {
        sign = "Negative";
    }
    return sign;
}
