#include <iostream>

using namespace std;

class Phone
{
    protected: 
        string number;
    public:
        Phone()
        {

        }
        Phone(string number)
        {
        this->number = number;
        }

        string get_phone() { return number; }
        

        void call(string target)
        {
            cout << "calling " << target << endl;
        }
};

class iPhone : public Phone
{
    public:
        iPhone(string n) : Phone(n)
        {
        }

        virtual void call(string target)
        {
            cout << "iPhone "<< number << " calling " << target << endl;
        }
};



int main()
{
    Phone p1("6618316670");  //instanchiate an object from a class
    //Phone * p2 = new Phone("6612927760");    el papa
    //iPhone * p2 = new iPhone("6612927760");
    iPhone * p2 = new iPhone("6612927760");

    cout << p1.get_phone() << endl;
    cout << p2->get_phone() << endl;

    p1.call("9096969420");

    p2->call("911");
    
    delete p2;

    return 0;
}
