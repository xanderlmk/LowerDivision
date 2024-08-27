#include <iostream>
using namespace std;

class Cart
{
    private:
        int count;
        double total;
        string descriptions[25];
        double amounts[25];
        int qty[25];

        void calc_total();
        
        bool deleted = false;


    public:

    Cart()
    {
        count = 0;
        total = 0;
    }
    
    void add_item(string description, double amount, int quantity)
        {
                
                    descriptions[count] = description;
                    amounts[count] = amount;
                    qty[count] = quantity;

                    count = count + 1;

                    deleted = false;            
                    //Cart::calc_total();  
                    calc_total();
                      
        }

        double get_total()
        {
        return total;
        }
        
        double get_count()
        {
            return count;
        }

        string delete_last()
        {       
            deleted = true;
            calc_total();

            return descriptions[count-1];
            
            //descriptions[count-1] = " ";
            //amounts[count-1] = amounts[count-1] *-1;
            //calc_total();
        }

};

void Cart::calc_total()
{   
    if (deleted == false)
        total = total + amounts[count-1];

    else 
    {
        total = total - amounts[count-1];
    }

}


int main()
{
    Cart cart;
    char input;

    string item;
    double cost;
    int num_ofitem;
    do
    {
        cout << "a - Add an item" << endl;
        cout << "d - Delete last item" << endl;
        cout << "t - Show total" << endl;
        cout << "Command: " << endl;
        cin >> input;

        switch (input)
        {
            case 'a':         // asks user for item details
                    
                if (cart.get_count() < 25)
                {
                    cout << "Item description? ";      
                    cin >> item;

                    cout << "Amount? ";
                    cin >> cost;

                    cout << "Quantity? ";
                    cin >> num_ofitem;
                    
                    cost = cost * num_ofitem;

                    cart.add_item(item, cost, num_ofitem);
                    
                  
                    // add to cart
                }

                else
                {
                    cout << "Too many items." << endl;
                }
            break;
            
            case 'd':
                    cout << cart.delete_last() << " removed from cart" <<  endl; // delete the last item
            break;

            case 't':
                    cout << "Cart total: $" << cart.get_total() << endl; // show total
            break;
        }
    
    } while (input != 'q');


    return 0;
}

