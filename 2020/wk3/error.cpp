#include <iostream>
#include <cmath>

using namespace std;

class SquareRootException : public exception
{
    public:
        const char * what() const throw()
        {
            return "Exception - sqrt of neg value";
        }
};

double safesqrt(double v)
{
    if (v < 0)
        throw SquareRootException();
        //throw "Cannot calc sqrt of neg number"; //const char *
    else
        return sqrt(v);

}

double calc(double a, double b)
{

    double result;
    result = safesqrt(a) + safesqrt(b);
/*
    try
    {
    result = safesqrt(a) + safesqrt(b);
    }
    catch (const char * msg)
    {
        return 0;
    }
*/
    return result;
}

int main()
{
    double input;
    
    cout << "Enter value: ";
    cin >> input;

    try
    {
       // cout << safesqrt(input) << endl;
        cout << calc(-10,10) << endl;
        cout << "DONE" << endl;
    }
    catch(SquareRootException & sre)
    {
        cerr << sre.what() << endl;
    }
    catch(const char * msg)
    {
        cerr << "ERROR: " << msg << endl;
    }
    return 0;
}
