#include <iostream>

using namespace std;

void get_julian_day(int month, int day, int &julian_day);

int main()
{
    
    string months[12] = {"Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"};

    int days[12] = { 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 };

    int month, day;
    
    int julian_day = 0;

        cout << "What is the month? ";
        cin >>  month;
        cout << "What is the day? ";
        cin >> day;
    
    get_julian_day(month, day, julian_day);

    cout << months[month-1] << " " << day << " is Day " << julian_day << endl;
    
    return 0;
}

void get_julian_day(int month, int day, int &julian_day)
{
    
    if (month == 12)
    {    
        julian_day = day + 334;
    }   
    
    else if (month == 11)
    {
        julian_day = day + 304;
    }

    else if (month == 10)
    {
        julian_day = day + 273;
    }

    else if (month == 9)
    {
        julian_day = day + 243;
    }
    
    else if (month == 8)
    {
        julian_day = day + 212;
    }

    else if (month == 7)
    {
        julian_day = day + 181;
    }

    else if (month == 6)
    {
        julian_day = day + 151;
    }

    else if (month == 5)
    {
        julian_day = day + 120;
    }

    else if (month == 4)
    {
        julian_day = day + 90;
    }

    else if (month == 3)
    {
        julian_day = day + 59;
    }

    else if (month == 2)
    {
        julian_day = day + 31;
    }

    else
    {
        julian_day = day;
    }

}
