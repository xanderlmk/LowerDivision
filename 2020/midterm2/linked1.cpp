#include <iostream>

using namespace std;

struct Node
{
    int data;
    Node *next;
    Node *prev;
};

class Linked
{
    private:
        Node *head, *tail;
        Node * create(int data)
        {
            try
            {
                Node *newnode = new Node;
                newnode->data = data;
                newnode->next = NULL;
                newnode->prev = NULL;
                return newnode;
            }
            catch (bad_alloc)
            {
                return NULL;
            }
        }
 
        char map_to_letter(int value)
        {
            // this function converts any positive integer into a lower-case letter
            // Nothing to do here
            return (char)((value % 26) + 97);
        }
        
    public:
        Linked()
        {
            head = NULL;
            tail = NULL;
        }

        void add(int value)
        {
            Node * newnode = create(value);
            if (head == NULL)
            {
                head = newnode;
                tail = newnode;
            }
            else
            {
                // TODO: add the new node at the tail
                // DO NOT wire up ->prev pointers in this function
                // 1 pt
            }
        }

        void linkprev()
        {
            // TODO: This function will wire up the nodes using the ->prev pointer
            // at this point, the entire node has been connected using ->next
            //
            // After this function has been called, then you can use the tail
            // pointer to traverse this list in the reverse direction
            // 7 pts
            
        }
       
        string encode()
        {
            // TODO: traverse all the nodes from head and create an encoded string
            // converting each node's value to a lower case letter
            // using the private map_to_letter() function
            // The result of this function is a single string comprising of all the 
            // nodes' encoded values concatenated together
            // 5 pts

            string encoded = "";

            return encoded;
        }

        int count_freq(int value)
        {
            // TODO: return the number of times 'value' occurs in the list
            // 5 pts
            return 0;
        }

        friend void showreverse(Linked & linked)
        {
            linked.linkprev();

            // TODO: show the list starting from tail
            // traversing in the opposite direction
            // using prev pointer
            // Don't worry about displaying the leading "3."
            // Don't worry about reversing the digits in the nodes
            //   - if two adjacent nodes are 37 and 12, displaying in reverse
            //     will simply show 12 then 37 (NOT 21 73)
            // 5 pts
 
        }
        
        friend void show(Linked & linked)
        {
            Node * node = linked.head;
            cout << "3.";
            while (node != NULL)
            {
                cout << node->data;
                node = node->next;
            }
            cout << endl;
        }

        ~Linked()
        {
            // deallocate the nodes. You don't need to make a separate deallocate function
            // you can do it all here in the destructor
            // 5 pts
        }

        // ### EXTRA CREDIT ###
        void compact()
        {
            // TODO: compact the list by merging pairs of nodes into one
            //       and combining their respective values
            //
            // First 10 nodes are 1 41 59 26 53 58 97 93 23 84
            // After compacting, these 10 nodes will become 5 nodes, as below:
            //                    141 5926 5358 9793 2384
            // 
            // Notice that not all nodes contain 2-digit numbers
            //
            // If there is a left-over node because there is an odd number of nodes,
            // then that node will not be merged. It will remain in the linked list
            // as just another node with its original value. 
            //
            // 10 pts
        }

};

int main()
{
    int value;
    int values[45] = {1, 41, 59, 26, 53, 58, 97, 93, 23, 84, 62, 64, 33, 83, 27, 
                      950, 2, 88, 41, 97, 16, 93, 99, 37, 510, 5, 820, 9, 74, 94,
                      45, 92, 30, 78, 16, 40, 62, 86, 20, 89, 98, 62, 80, 34, 82};
    Linked pi;

    // TODO: fill the list with all items from the values array
    // 1 pt
 
  

    cout << "Forward: " << endl;
    show(pi);
    cout << endl;

    cout << "Reverse: " << endl;
    showreverse(pi);
    cout << endl;

    cout << "Encoded: " << pi.encode() << endl;

    cout << "Find value: ";
    cin >> value;
    // TODO: display frequency of value
    //       97 occurs twice in this list
    // 1 pt
    cout << value << " occurs " << 0 << " times " << endl;

    // EXTRA CREDIT SECTION - uncomment if you will be attempting this challenge
    // pi.compact();
    // show(pi);            // this should show exactly the same as it was before compacting

    return 0;
}
