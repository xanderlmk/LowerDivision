#include <iostream>

using namespace std;

struct Car
{
    string name;
    Car * next;     //next node
};

void show(Car * h)
{
    while(h != NULL)
    {
        cout << h->name << endl;
        cout << "next: " << h->next << endl;
        h = h->next;
    }
}

bool find(Car * h, string carname)
{
    bool x = false;

    while (h != NULL)
    {
        if (h->name == carname)
            x = true;

        h = h->next;
    }
    
    return x;
}
    
int count(Car * h)
{
    int i = 0;
    while (h != NULL)
    {
        i = i+1;
        h = h->next;
    }

    return i;
}

int main()
{

    Car c1 { name : "camaro", next : NULL };
    Car c2 { name : "rogue", next : NULL };
    Car c3 { name : "civic", next : NULL };
    Car c4 { name : "accord", next : NULL };
    Car c5 { name : "challenger", next : NULL };
    Car c6 { name : "gtr", next : NULL };
    
    Car * head = NULL;

    head = &c1;
    c1.next = NULL; 

    //cout << head->name << endl;     // camaro
    //c1.next points to c2's address and c2.next points to NULL
    
    c1.next = &c2;
    c2.next = NULL;
    
    c2.next = &c3;
    c3.next = NULL;
    
    c3.next = &c6;
    c6.next = NULL;

    c6.next = &c4;
    c4.next = NULL;
    
    c4.next = &c5;
    c5.next = NULL;

    show(head);
    
    if (find(head, "camaro"))
        cout << "Found it!" << endl;

    if (find(head, "camry"))
        cout << "Found it!" << endl;
    
    else
        cout << "no car lol" << endl;

    cout << "nodes: " << count(head) << endl;

    return 0;
}
