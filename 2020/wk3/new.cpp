#include <iostream>

using namespace std;
// TEMPLATES or GENERICS

/*
double bigger(double x, double y)
{
    return (x > y ? x : y);
}

string bigger(string x, string y)
{
    return (x > y ? x : y);
}

int bigger(int x, int y)
{
    return (x > y ? x : y);
}
*/

struct State
{
    string name;
    int pop;

};

template <typename T>
T bigger(T x, T y)
{
    return (x > y ? x : y);
}

// templete specialization overrides the template
template <>
State bigger(State x, State y)
{
    return (x.pop > y.pop ? x : y);
}

// Used on line 66 and 74
ostream & operator<<(ostream & out, State rhs)
{
    out << rhs.name;
    return out;
}

template <class T, class U>
class Collection
{
    private:
        T data[100];
        U other;
    public:
        Collection(T initial)
        {
            for (int i = 0; i < 100; i++)
                {
                    data[i] = initial;
                }
        }

        void set(int index, T value)
        {
            data[index] = value;
        }
};

int main()
{

    int a = 10;
    int b = 20;

    State s1 { name : "California", pop : 100000 };
    State s2 { name : "Texas", pop : 200000 };
    
    cout << bigger<int>(a, b) << endl;
    cout << bigger<double>(19.99, 19.98) << endl;
    cout << bigger<string>("david", "adam") << endl;


    State bigstate = bigger<State>(s1, s2);
    cout << bigstate.name << endl;
    cout << bigstate << endl;

    // ERROR : no match for operator<<
    // CMPS 2010 Review - Operator Overloading
    //  cout << State;
    //  LHS << RHS
    //  operator<<(LHS, RHS)
    //  
    cout << bigger<State>(s1, s2) << endl;
  
    Collection <int, string>ic(0);
    ic.set(10,1000); // set data[10] to 1000
    Collection <string, bool>sc("-");  
    sc.set(99, "!!"); // set data[99] to !! 
            
    return 0;
}

