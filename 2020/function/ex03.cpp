#include <iostream>

using namespace std;

void sumdiff(double d1, double d2, double & sum, double & diff);

int main()
{

    double x1, x2;
    double s, d;
    
    x1 = 10;
    x2 = 20.5;
    
    s = 0;
    d = 0;

    cout << "Sum = " << s << endl;
    cout << "Diff = " << d << endl;

    sumdiff(x1, x2, s, d);
    cout << "x1 = " << x1 << endl;
    cout << "x2 = " << x2 << endl;
    cout << "Sum = " << s << endl;
    cout << "Diff = " << d << endl;

    return 0;
}

void sumdiff(double d1, double d2, double & sum, double & diff)
{
    
    sum = d1 + d2;
    diff = d1 - d2;
    d1 = d1 * 2;
    d2 = d2 * 2;

    cout << "d1 = " << d1 << endl;
    cout << "d2 = " << d2 << endl;
}
