#include <iostream>

//Polymorphism - Multiple forms/shapes

using namespace std;

class Shape
{
    protected:
        int sides;
    public:
        virtual double calc_area() = 0; //Pure Virtual function aka PVF
        friend void show(Shape & s);
};

class Rectangle : public Shape
{
    private:
    double height, width;
    public:
    Rectangle(double h, double w, int s)
    {
    height = h;
    width = w;
    sides = s;
    }    
    double calc_area()
    {
        return height * width;
    }
};

class Circle : public Shape
{
    private:
        double radius;
    public:
        Circle(double r)
        {
            radius = r;
            sides = 1;
        }
        double calc_area()
        {
            return 3.14159 * (radius * radius);
        }
};

void show(Shape & s)
{
    cout << s.sides << endl;
}

int main ()
{
    Shape * s1 = new Circle(10); //new Rectangle r1(10,20, 4);
    cout << s1->calc_area() << endl;
    show(*s1);

    delete s1;

    return 0;
}
