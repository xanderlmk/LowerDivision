#include <iostream>

using namespace std;

void dosomething();

int main()
{

    cout << "Main 1" << endl;
    dosomething();
    cout << "Main 2"<< endl;
    return 0;
}

void dosomething()
{
    cout << "Function dosomething" << endl;
}
