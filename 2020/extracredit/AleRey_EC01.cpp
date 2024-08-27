#include <iostream>
#include <cstring>

using namespace std;

template <typename T>
struct ValueNode
{
    T val;
    ValueNode * next;
};

template <typename T>
class Stack
{
    private:
        ValueNode <T> * head;
        ValueNode <T> * create(T newval)
        {
            ValueNode <T> * newnode;
            try
            {
                newnode = new ValueNode<T>;
                newnode->val = newval;
            }
            catch (bad_alloc)
            {
                newnode = NULL;
            }
            return newnode;
        }
    public:
        Stack () 
        {
            head = NULL;
        }

        void push(T newvalue)
        {
            ValueNode <T> * item = create(newvalue);
            if (head == NULL)
            {
                head = item;
                item->next = NULL;
            }
            else
            {
                ValueNode <T> * temp = head;
                head = item;
                item->next = temp;
            }
        }

        bool pop(T & popped)
        {
            ValueNode <T> * temp = head;
            bool success = false;
            if (temp != NULL)
            {
                popped = temp->val;
                head = temp->next;
                delete temp;
                success = true;
            }

            return success;
        }

        // You will need to create a destructor
        // to make sure you don't get random segfaults

        friend void show(Stack &s)
        {
            ValueNode <T> * h = s.head;
            while (h != NULL)
            {
                cout << h->val << " ";
                h = h->next;
            }
            cout << endl;
        }

};

bool is_op(char * token)
{
    bool op = false;

    if (strlen(token) == 1)
    {
        char ops[] = "+-x/^";
        op = strstr(ops, token) != NULL;
    }
    
    return op;
}

template <typename T>
double calc(T operand1, T operand2, char op[])
{
    double result;

    char c = op[0];

    switch (c)
    {
        case '+': result = operand1 + operand2;
                  break;

        // Add the remaining operations
        // Additionally, we are designing the caret ^ operator
        // as exponentiation
        // For example a ^ b => a raised to power b
        //
        // NOTE: we'll use the x to represent multiplication
        // rather than the asterisk * as that causes problems 
        // when used on the command line
    }

    return result;
}

double solve_rpn(int count, char * tokens[])
{
    double result;
    Stack <double> stack;

    // this sample FOR loop shows how to use
    // - is_op() function
    // - atof() function
    // As an example, this loop currently only pushes the tokens detected as non-operators
    // 
    // YOU WILL HAVE TO MODIFY THE LOOP TO FUNCTION 
    // AS AN RPN TOKEN CALCULATOR

    for (int i = 1; i < count; i++)
    {
        if (!is_op(tokens[i]))
        {
            double number = atof(tokens[i]);        // converts a token into number
            stack.push(number);
        }
    
        // this is how you might use the calc() function
        double test = calc<double>(100, 200, tokens[i]);     // where tokens[i] is an operator

        // this is how to pop from the stack
        double popped;
        if (stack.pop(popped))
        {
            cout << popped << endl;
        }
    }

    return result;
}

int main(int argc, char *argv[])
{
    // Feel free to add more code to main()

    cout << solve_rpn(argc, argv) << endl;

    return 0;
}
