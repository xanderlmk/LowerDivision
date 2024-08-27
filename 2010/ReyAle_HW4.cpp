#include <iostream>

#include <iomanip>

using namespace std;

double get_money(string prompt);

double get_money_min(string prompt, double minimum);

void calc_change(double change, int &quarters, int &dimes, int &nickels, int &pennies);

int main()
{
    cout << fixed << setprecision(2);

    double total;
    
    string prompt;

    int quarters = 0;
    int dimes = 0;
    int nickels = 0;
    int pennies = 0;

    total = get_money(prompt);

    double tendered = get_money_min("Enter amount tendered: ", total);

    double change = tendered - total;
    
    cout << "Your change is $" << change << endl;    

    calc_change(change, quarters, dimes, nickels, pennies);
    
    cout << "You should have " << quarters << " quarter(s), " << dimes << " dime(s), " << nickels << " nickel(s), and " << pennies << " penny/ies." << endl;  
        return 0;
}

double get_money(string propt)
{
    double total;

    cout << "Enter a total: ";

    cin >> total;

    return total;
}



double get_money_min(string prompt, double total)
{

    double minimum;
    
    while (minimum < total) //this loops makes sure the user enters a higher amount than the total
    {
    cout << "Enter amount tendered: ";
    
    cin >> minimum;
    
    if (minimum < total)
        {
        cout << "*** Amount must be atleast " << total << endl;
        }

    }

    return minimum;
}

void calc_change(double change, int &quarters, int &dimes, int &nickels, int &pennies)
{

    int cents = change*100; // to make sure change becomes whole number, aka cents is now whole

    int splitup = change; //will give the whole number without change
    splitup = splitup*100; 
    
    cents = cents-splitup; // will give exact change left.
    
    if (cents >= 25)
    {
        quarters = cents/25;
        cents = cents - (quarters*25);
    }

    if (cents >= 10)
    {
        dimes = cents/10;
        cents = cents - (dimes*10);
    }

    if (cents >= 5)
    {
        nickels = cents/5;
        cents = cents-5;
    }

    if (cents >= 1)
    {
        pennies = cents;
    }

}



