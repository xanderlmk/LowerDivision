#include <iostream>

using namespace std;

struct Node
{
    int data;
    int count = 1;
    Node * next;
};

int insert(Node *& head, int data)
{
    int c;
    if (head == NULL)
    {
        Node * newnode = new Node;
        newnode->data = data;
        newnode->next = NULL;
        head = newnode;
        c = 1;

    }

    else
    {
        Node * front = head;
        Node * back = head;
        while (front->next != NULL && front->data < data)
        {
            back = front;
            front = front->next;
        }

        if (front->data == data)
        {
            front->count = front->count + 1;
            c = front->count;
            return c;
        }

        if ( front->data > data )
        {
            Node * newnode = new Node;
            newnode->next = head;
            newnode->data = data;
            head = newnode;
            c = 1;
           // cout << "front < data" << endl;
        }

        else if ( back->data > data && front->data < data)
        {

            Node * newnode = new Node;
            newnode->next = front;
            newnode->data = data;
            back->next = newnode;
            c = 1;
           // cout << "front > data , back < data" << endl;

        }

        else
        {
            Node * newnode = new Node;
            newnode->next = NULL;
            newnode->data = data;
            front->next = newnode;
            c = 1;
           // cout << "front > data" << endl;
        }

    }

    return c;

}

void show(Node * head)
{
    Node * tmp = head;

    while (tmp != NULL)
    {
        if (tmp->count > 1)
            cout << tmp->data << "(" << tmp->count << ") - ";
        else
            cout << tmp->data << " - ";

        tmp = tmp->next;
    }
    cout << endl;
}

int main()
{
    Node * head = NULL;
    insert(head, 20);
    show(head);

    insert(head, 10);
    show(head);

    insert(head, 20);
    show(head);

    insert(head, 30);
    show(head);
   
    return 0;
}
