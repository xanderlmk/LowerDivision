#include <iostream>
using namespace std;
int  main () {

    //if-else
    //this or that

int score = 120;
bool is_passing = true;
/*if (score >= 60)
    {
        //if it's true
        //do this in here
        //
     cout << "you passed lol" << endl;
    }
else
    {
        //if it's false
        //do this
        //
     cout << "lol no pass" << endl;
    }

    //if-else if-else
    //this or that or that
*/
    if (score >= 90)
    {
        cout << "you passed with an A lol." << endl;
    }
    else if (score >= 80)
    {
        cout << "you have a B lol." << endl;
    }
    else if (score >= 70)
    {
        cout << "you got a C, lol." << endl;
    }
    else if (score >= 60)
    {
        cout << "you have a D lol." << endl;
    }
    else //if (score < 60)
    {
        cout << "F for fantastic failing." << endl;
    }

    if (score >= 90)
    {
        cout << "A" << endl;
        if (score > 100)
        {
            cout << "wow over-achiever... lol" << endl;
       }
    }

    return 0;

