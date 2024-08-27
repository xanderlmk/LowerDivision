#include <iostream>

#include <iomanip>

using namespace std;

int main () {

    int weeks;
    
    double hours;

    int days_in_week = 7;

    double total_hours_worked = 0.0;
    
    double hourly_rate = 15.99;
    
    double total_wages = 0.0;
    
    cout << fixed << setprecision (2);
   
    do
    {
     cout <<  "-- WAGES CALCULATOR --" << endl; 
     cout << "Hw many weeks of work would you like to enter? ";
     cin >> weeks;

         if (weeks == 0)
         {
             cout << "Please enter a valid number of weeks" << endl;
         }
         
    } while (weeks <= 0); //a valid week cannot be negative or 0
   
    for (int i = 1; i <= weeks; i++) // i adds up until you reach the number of weeks you entered. 
    {
        cout << "Week " << i << ":" << endl;

        for (int j = 1; j <= days_in_week; j++) // j adds up until 7, the number of days in a week. Then it keeps going until you reach the total weeks you worked.
        {

            cout << "\tDay " << j << ": ";
            cin >> hours;
            total_hours_worked = total_hours_worked + hours; // adding the total number of hours...
            total_wages = total_hours_worked * hourly_rate; // multiplies the total hours by hourly rate.
        }
    }


   cout << "TOTAL HOURS WORKED: " << total_hours_worked << endl;
   cout << "TOTAL WAGES EARNED: $" << total_wages << endl;
   
   return 0;
}
