#include <iostream>

using namespace std;

int sum( int n)
{
    if (n == 0)
        return 0;
    else
        n + sum(n-1);


}

/*
void fn()
{
    cout << "in fn()" << endl;
    fn();
}
*/

int main()
{
    //fn();

    cout << sum(5) << endl;

    return 0;
}
