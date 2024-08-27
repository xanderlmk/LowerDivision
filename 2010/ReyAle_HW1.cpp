#include <iostream>

#include <iomanip>

using namespace std;

int main () {

    string firstname = " ";

    string lastname = " ";

    int age = 0;

    char bedsize = ' ';

    int nights = 0;

    char roomtype = ' ';

    double cost = 100;
    
    cout << fixed << setprecision (2) ;

    cout << "It's a lovely day at the Assy Hotel!" << endl;

    cout << "Please enter your first name to begin your reservation." << endl;
    cin >> firstname;

    cout << "And your last name." << endl;
    cin >> lastname;

    cout << "Thank you " << firstname << " " << lastname << " " << endl;

    cout << "How old are you?" << endl;
    cin >> age;

    if ( age >= 18)
    {
        cout << "Great! We have rooms with different types of beds" << endl;
        cout << "We have King (K), Queen (Q), and Twin (T)." << endl;
        cout << "What's your prefernce?" << endl;
        cin >> bedsize;
        switch (bedsize)
        {
            case 'K':
                cout << "Awesome! Our king size beds are amazing!" << endl;
                cout << "How many nights will you be staying?" << endl;
               break;
            case 'Q':
                cout << "Awesome! Our queen size beds are amazing!" << endl;
                cout << "How many nights will you be staying?" << endl;
              break;
            default:
                cout << "Awesome! Our twin size beds are amazing!" << endl;
                cout << "How many nights will you be staying?" << endl;
              break;
        }
        cin >> nights;
        cout << "What type of room would you like?";
        cout << " We have (B)each view, (C)ity view, and (G)arden view." << endl;
        cin >> roomtype;

        if (bedsize == 'K' && roomtype == 'B') //beach view with king bedsize
        {

            cost = (cost + 35) * nights;
            cost = (cost * 0.05) + cost;
            cout << firstname << ", you room is reserved for " << nights << " nights. Your Beach View room with a king size bed will be ready. Please pay $" << cost << endl; 
       
        }

        else if (bedsize == 'K' && roomtype == 'G') // garden view with king bedsize
           {
               
           cost = (cost + 10) * nights;
           cost = (cost * 0.05) + cost;
           cout << firstname << ", you room is reserved for " << nights << " nights. Your Garden View room with a king size bed will be ready. Please pay $" << cost << endl;
  
        }

        else if (bedsize == 'K' && roomtype == 'C') //city view with king bedsize
        {

            cost = (cost + 10) * nights;
            cost = (cost * 0.05) + cost;
            cout << firstname << ", you room is reserved for " << nights << " nights. Your City View room with a king size bed will be ready. Please pay $" << cost << endl;
        
        }

        else if (roomtype == 'B') // beach view with queen or twin bedsize
        {

            cost = (cost + 25) * nights;
            cost = (cost * 0.05) + cost;
          
            if (bedsize == 'Q') 
            {

                cout << firstname << ", you room is reserved for " << nights << " nights. Your Beach View room with a queen size bed will be ready. Please pay $" << cost << endl;
            }

            else
                cout << firstname << ", you room is reserved for " << nights << " nights. Your Beach View room with a twin size bed will be ready. Please pay $" << cost << endl;
        } //This bracket is if roomtype is beach view and bedsize is queen or twin

        else if (roomtype == 'C') // for city view and bedsize queen or twin
        {
            cost = cost * nights;
            cost = (cost * 0.05) + cost;

            if (bedsize == 'Q')
            {

            cout << firstname << ", you room is reserved for " << nights << " nights. Your City View room with a queen size bed will be ready. Please pay $" << cost << endl;    
            
            }

            else
            {
           
            cout << firstname << ", you room is reserved for " << nights << " nights. Your City View room with a twin size bed will be ready. Please pay $" << cost << endl;
           
            }

        } //This bracket is if roomtype is city view and bedsize is queen or twin
       
        else        // for Garden view and bedzie is queen or twin
        {
            cost = cost * nights;
            cost = (cost * 0.05) + cost;

            if (bedsize == 'Q')
            {
           
            cout << firstname << ", you room is reserved for " << nights << " nights. Your Garden View room with a queen size bed will be ready. Please pay $" << cost << endl;
           
            }

            else
            {
           
            cout << firstname << ", you room is reserved for " << nights << " nights. Your Garden View room with a twin size bed will be ready. Please pay $" << cost << endl;
           
            }

        }  //bracket for garden view.

            }        // This is the ending bracket for the nested IF stamement , if (age >= 18).
       
        else  //if you're not 18, not hotel room.
        {

        cout << "Sorry you must be atleast 18 years old to make a reservation." << endl;
      
        }

    return 0;
    }
