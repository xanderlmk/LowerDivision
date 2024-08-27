#include <iostream>

using namespace std;

/*
    Parent  Base        Class       Human
    Child   Derived     Subclass    Person
                                    Student
                                    GradStudent
*/

class Human
{
    protected:
        double height, weight;
};

class Person
{
    protected:
        string first, last;
    public:
        Person()
        {
            first = "";
            last = "";
        }

        Person(string f, string l)
        {
            first = f;
            last = l;
        }
};

class Student : public Person
{
    private:
        string id;
    public:
        Student(string f, string l, string i) : Person(f, l)
        {
//            first = f;
//            last = l;
            id = i;
        }
        
        Student(string i) // : Person ("", "")
        {
            id = i;
        }
};

int main ()
{
    Person p1("Assy", "Killa");
    Student s1("Janis", "Joplin", "jj01");
    return 0;
}
