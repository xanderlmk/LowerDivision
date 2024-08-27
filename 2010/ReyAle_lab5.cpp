#include <iostream>

#include <iomanip>

using namespace std;

int main () {
    
    cout << fixed << setprecision (2);
    
    
    double income = 0.01; //the intitial amount of pay

    double total_earning = 0; //adds up all the earnings.

    for (int day = 1 ; day <= 30 ; day++ ) /* the initialize is int day = 1
                                              the test is day <= 30
                                              the update is day ++ */
           
    {

        if ( day == 1 ) // had to use in if in order to make value stay 0.01
        {    
      
        income = 0.01;
        cout << "On day" << " " << day << " " << "You made $" << income << endl;
      
        }
        
        else //after day 2, it doubles each day
        {

        income = (income * 2);
        cout << "On day" << " " << day << " " << "You made $" << income << endl;    
      
        }

        total_earning = total_earning + income; // keeps adding the income of each day.

        }

    cout << "After 30 days, you made $" << total_earning << endl; //the last message hehe.

    return 0;
}
