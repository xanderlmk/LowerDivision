#include <iostream>

using namespace std;

class Car
{
    private:

        string objname;
    public:

        Car(string on)
        {
            objname = on;
        }

        ~Car()
        {
            cout << objname << " destructor" << endl;
        }

};

int main ()
{
    Car c1("c1");
    Car c2("c2");
    Car c3("c3");

    return 0;
}
