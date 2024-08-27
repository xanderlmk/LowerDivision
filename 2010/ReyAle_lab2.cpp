 #include <iostream>

using namespace std;

int main() {

char is_bday_input = 'n';

bool is_bday = false;

int age = 0;

int drinking_age = 21;

string drink = " ";

cout << "Welcome to Dino bar!" << endl;
cout << "How old you is?" << endl;
cin >> drinking_age;
cout << "is it your birthday today (y/n)" << endl;
cin >> is_bday_input;

    if (drinking_age == 21 && is_bday_input != 'n' )
    {       
        cout << "Less go!!Happy 21st birthday!" << endl;
        cout << "You get a free drink of your choice on the house!" << endl;
    }

    if (drinking_age < 18)
    {
        cout << "Sorry bud, you're too young to be here," << endl;
        cout << "you have to leave." << endl;
    }     
    // no underage people DINO BAR!!

    else
    {
        cout << "what would you like to drink??" << endl;
        cin >> drink;
    }
    /* Had to use else because it will still ask you for a drink even though
    you're underage */

    return 0;
}
