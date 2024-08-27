#include <iostream>

using namespace std;

class Car
{
    private:
    string make;
    string model;
    int year;
    public:

    //constructor - public,no return type, has name as class
    Car() //default ctor
    {
        make = "";
        model = "";
        year = 0;
    }
    
    Car(string mk, string md, int yr) // overloaded ctor
    {
        make = mk;
        model = md;
        year = yr;
    }

    Car(string make, string model, int year)
    {
        this->make = make;
        this->model = model;
        this->year = year;
    }

    Car(int yr, string mk, string md)
    {
        make = mk;
        model = md;
        year = yr;
    }

    ~Car() //destructor
    {
    //cout << "Destructor" << endl;
    }

    void set_make(string mk) // setter/mutator
    {
        make = mk;
    }

    void set_model(string md) { model = md; }

    void set_info(string mk, string md, int y);
    string get_make() // getter/accessor
    {
        return make;
    }

    string get_info()
    {
        return to_string(year) + " " + make + " " + model;
    }

    friend void show(Car c)
    {
    cout << c.year << " " << c.make << " " << c.model << endl;
    } 

};

/*void show(Car c)
{
    cout << c.year << " " << c.make << " " << c.model << endl;
}
*/

void Car::set_info(string mk, string md, int y)
{    
        make = mk;
        model = md;
        year = y;
}

int main ()
{
    int sum;
    Car car1; //{ make : "Tesla", model: "Model 3", year: 2000 };
    Car car2("Ford", "Focus", 1999);
    Car car3(1989, "Toyota", "Camry");
    //car1.set_make("Tesla");
    //car1.set_model("Model 3");
    
    car1.set_info("Tesla", "Model 3", 2021);

    cout << car1.get_info() << endl;
    cout << car2.get_info() << endl;
    cout << car3.get_info() << endl;
    
    show(car3);

    return 0;
}
