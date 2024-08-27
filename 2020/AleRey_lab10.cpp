#include <iostream>

using namespace std;

struct Location
{
    string name;
    string address;
};

struct VisitNode
{
    Location loc;
    VisitNode * next;
};

class Stack
{
    private:
        VisitNode * head;

        VisitNode * create()
        {
            VisitNode * newnode;
            try
            {
                newnode = new VisitNode;
            }
            catch (bad_alloc)
            {
                newnode = NULL;
            }
            return newnode;
        }

        void deallocate(VisitNode * node)
        {
            VisitNode * tmp;
            if (node != NULL)
            {
                tmp = node;
                delete tmp;
                deallocate(node->next); //keeps deleting a node, then calls the next one after until it reaches NULL
            }
        }
    public:
        Stack()
        {
            head = NULL;
        }

        bool push(string name, string address)
        {
            VisitNode * newnode = create();
            newnode->loc.name = name;
            newnode->loc.address = address;
            
            bool success = false;
            //newnode->next = head;
            if (head == NULL)
            {
            head = newnode;
            newnode->next = NULL;
            }

            else
            {
                newnode->next = head;
                head = newnode;
            }

            if (newnode != NULL)
                success = true;

            return success;
        }

        string pop()
        {
            string i;

            VisitNode * tmp;
            tmp = head;
            
            if (head != NULL)
            {

                head = head->next;
                i = tmp->loc.name;
                
            }

            else
            {
                i = "";
                head = NULL;
            }
            
            delete tmp;

            return i;
        }
                
        friend void show(Stack & S);
        
        ~Stack()
        {
            deallocate(head);
            head = NULL;
        }
};

void shownode(VisitNode * node)
{
    if (node != NULL)
    {
         cout << node->loc.name << " ";
         shownode(node->next); //keeps going till node is NULL
    }
}

void show(Stack & S)
{
    shownode(S.head);
}


int main()
{
    
     Stack browser;

  // simulate a browser history
  browser.push("Google", "https://google.com");
  browser.push("Amazon", "https://amazon.com");
  browser.push("LinkedIn", "https://LinkedIn.com");
  browser.push("Reddit", "https://reddit.com");

  show(browser);   // this should show the entire history
  cout << endl;
  /*
  // simulate clicking Back button
  string top = browser.pop();
  if (top != "")
    cout << endl << "Clicked back from " << top << endl;
  show(browser);

  // simulate clicking Back button
  top = browser.pop();
  if (top != "")
    cout << endl << "Clicked back from " << top << endl;
  show(browser);

  // simulate clicking Back button
  top = browser.pop();
  if (top != "")
    cout << endl << "Clicked back from " << top << endl;
  show(browser);
  cout << endl;
*/


return 0;
}

