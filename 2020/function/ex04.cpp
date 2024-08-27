#include <iostream>

using namespace std;

void showdate(int m, int y);

void showdate(int m,int d, int y);

int main()
{

    showdate(5, 2001);
    showdate(12,25,2020);

    return 0;
}

void showdate(int m, int y)
{
   string months[13] = {"", "Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "aug", "Sep", "Oct", "Nov", "Dec" };

    cout << months[m] << " " << y << endl;
}

void showdate(int m,int d, int y)
{
    cout << m << "/" << d << "/" << y << endl;
}
