#include <iostream>

#include <iomanip>

using namespace std;

void show_time(int start_hour, int end_hour, string period);

int main()
{
    show_time(6, 8, "AM");

    return 0;
}

void show_time(int start_hour, int end_hour, string period)
{
    int minutes;

    for (int i = start_hour; i < end_hour; i++)
    {   
        minutes = 0;

        for (int ii = 0; ii < 60; ii++)
        {   
            cout << i << ":" << setfill('0') << setw(2) << minutes << period << endl;
            minutes++;
        }

    }
    minutes = 0;
    cout << end_hour << ":" << setfill('0') << setw(2) << minutes << period << endl;

}
