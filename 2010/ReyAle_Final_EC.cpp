#include <iostream>

using namespace std;

class Degree
{
    private:
        string major;
        int NOY;
    public:
    
        Degree(string m, int n)
        {
            major = m;
            NOY = n;
        }

        string get_major()
        {
            return major;
        }

        int get_NOY()
        {
            return NOY;
        }
};
int main()
{
    Degree d1("Computer Sceince", 4);

    cout << d1.get_major() << " should be completed in " << d1.get_NOY() << " years" << endl; 

    return 0;
}

