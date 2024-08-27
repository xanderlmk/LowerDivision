#include <iostream>

using namespace std;

int main() {

    /*
    int age = 6;
    string state = "California";
    //boolean
    //two possible states or false
    //

    bool canVote = true;

    int age2 = 9;
   

    bool canVote2 = false;

    if (age >=  18 )
    {
        cout << "You can vote! Hooray! 'Merica!" << endl;

    }
    
    if (age < 18 )
    {
        cout << "You can't vote yet... but maybe someday!" << endl;
    }

    if (age == 18 )
    {
        cout << "Wow! First time voting? Thst's great!" << endl;
    }

    if (age != 18 )     // ! = NOT
    {
        cout << "You aren't 18!" << endl;
    }

    // if (true of false... boolean variable or statement that evaluates to the true of false)
    // {
    // whatever we want the computer to do
    // }
    //

    if (age >= 18 && state == "California" )  
        // && is both statements  have to be true
        
    {
        cout << "You can vote AND you are from California!!!" << endl;
    }

    if (age > 40 || state == "New York" )
        // || ia one or the other statement has to be true
    
    {
        cout << "You are older than 40 OR you are from New York!" << endl;
    }
*/






    //Netflix example

    bool showHasBeenWatched = true;

    if (showHasBeenWatched)
    {
        cout << "What do you rate this show? 5 Stars? 1 Star?" << endl;
    }

    string willWatch = "";

    if (!showHasBeenWatched)
    {
        cout << "You should check this show out! It's Awesome!" << endl;
        cout << "Will you watch this show?" << endl;
        cin >> willWatch;
    }


    // true = true;
    // false = false;
    // !true = false;
    // 1false = true;

    if (showHasBeenWatched)
        cout << "What do you rate this show? 5 Stars? 1 Star?" << endl;
   //more than one life use {}, but if only one line don't use {}

    return 0;
}
