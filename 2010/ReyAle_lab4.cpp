#include <iostream>

using namespace std;

int main (){

    int counter = 1;

    string text = "tru";

    int repititions;

    cout << "Choose a number and text will be shown the amount of # you choose." << endl;

    cin >> repititions;

    while (repititions > 0)
    {
        cout << text << endl;

        repititions--;
    }

    cout << "Now I'll show 1-20." << endl;

    while (counter <= 20)
    {
        cout << counter << endl;
        counter++;
    }
    
    int number;

    cout << "Enter a number larger than 100 and divisible by 10." << endl;
    cin >> number;

    while (number > 100)
    {

        if (number % 10 == 0)
        {
            cout << number << endl;
       
        }

        number--;
    }

    int input;

    cout << "Enter a positive number" << endl;
    cin >> input;

    while ( input > 0 ) 
    {
        cout << input << " * 2 =  " << input * 2 << endl;
        cout << "Another postive number, put negative number if you want to quit the loop." << endl;
        cin >> input;
    }

    string exit_word = "allosaurus"; // you won't exit unless it's the right answer...
    string user_word;

    cout << "Enter the exit word, (Hints it's a dinosaur and it starts with an 'a')." << endl;
    cin >> user_word;

    while (user_word != exit_word)
    {
        cout << "Wrong, try again" << endl;
        cin >> user_word;
    }

    return 0;
}
