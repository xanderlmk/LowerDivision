//Alexander Reyes
#include <iostream>
using namespace std;

struct Node
{
double value;
Node * next;
};

Node * find_largest(Node * head)
{
    if (head != NULL)
    {
        Node * tmp = head;
        double value = tmp->value;


        while(tmp != NULL)
        {
            if (value < tmp->value)
            {
                value = tmp->value;
        
            }

            tmp = tmp->next;

        }

        tmp = head;
        while(tmp != NULL)
        {
            if (tmp->value == value)
            {
                return tmp;
            }

            tmp = tmp->next;
        }
    }

    return NULL;
}

int main()
{
    Node n1, n2, n3, n4, n5;
    Node * head = NULL;
       
    n1.value = 20;
    n1.next = &n2;

    n2.value = 33;
    n2.next = &n3;
    
    n3.value = 22;
    n3.next = &n4;

    n4.value = 38;
    n4.next = &n5;

    n5.value = 17;
    n5.next = NULL;
    
    head = &n1;

    if(find_largest(head) != NULL)
        cout << "The largest is: " << find_largest(head)->value << endl;
    

    return 0;
}
