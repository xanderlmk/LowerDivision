#include <iostream>

using namespace std;

string get_date(int day);



int main()
{
    
    int day;
    
    do
    {

    cout << "Enter the nth day of the year: ";
    cin >> day;
    
    } while (day > 365 || day < 0);  //days can't be 0 or more then 365 or else it'll loop
    
    get_date(day);
    
    cout << get_date(day) << endl;

    return 0;
}


string get_date(int day)
{
    
    int day_of_month, month;
    
    string months[12] = {"Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"};

    int days[12] = {31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};
        
    if (day <= 31) // this is Jan
    {
        month = 0; //arrays always start at 0...
        day_of_month = day;
        months[month];
    }

    else if (day <= 59) // Feb
    {
        month = 1;
        day_of_month = day - 31;
    }
    
    else if (day <= 90) //Mar
    {
        month = 2;
        day_of_month = day - 59;
    }
    
    else if (day <= 120) // Apr
    {
        month = 3;
        day_of_month = day - 90;
    }

    else if (day <= 151) // May
    {
        month = 4;
        day_of_month = day - 120;
    }
    
    else if (day <= 181) //Jun
    {
        month = 5;
        day_of_month = day - 151;
    }

    else if (day <= 212) //Jul
    {
        month = 6;
        day_of_month = day - 181;
    }
    
    else if (day <= 243) //Aug
    {
        month = 7;
        day_of_month = day - 212;
    }
    
    else if (day <= 273) //Sep
    {
        month = 8;
        day_of_month = day - 243;
    }
    
    else if (day <= 304) //Oct
    {
        month = 9;
        day_of_month = day - 273;
    }

    else if (day <= 334) //Nov
    {
        month = 10;
        day_of_month = day - 304;
    }

    else //Dec
    {
        month = 11;
        day_of_month = day - 334;
    }

    return months[month] + " " + to_string(day_of_month);
}
