#include <iostream>

using namespace std;

int doubleit(int start);

int main()
{
    int x;
    cout << doubleit(10) << endl;
    x = doubleit(20) + doubleit(5) + doubleit(27);
    cout << x << endl;

return 0;
}

int doubleit(int start)
{
    return start * 2;
}
