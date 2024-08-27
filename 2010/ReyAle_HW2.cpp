#include <iostream>

#include <iomanip>

using namespace std;
    
double menu(char input, int &entrees, int &side_item, int &drink_reg, int &drink_large);


int main () {
    /*
    const double MAIN_ENTREE = 4.99;
    
    const double SIDE_ITEM = 0.99;
    
    const double DRINK_REG = 1.99;
    
    const double DRINK_LARGE = 2.49;
   */
    char input;


    int entrees = 0;

    int side_item = 0;

    int drink_reg = 0;

    int drink_large = 0;
    
    
    cout << fixed << setprecision (2);
    
    menu(input, entrees, side_item, drink_reg, drink_large);
    
    /*
       
    do
    {
    cout << "1 - Main Entree Burrito" << endl;
    cout << "2 - Side Item - Taco" << endl;
    cout << "3 - Side Item - Flauta" << endl;
    cout << "4 - Regular drink" << endl;
    cout << "5 - Large drink" << endl;
    cout << "C - Check out" << endl;
    cout << "S - Start over" << endl;
    cin >> input;

        switch (input)
        {
        case '1':
        cost = cost + MAIN_ENTREE; //The cost plus 4.99
        entrees = 1 + entrees; // adds up 1 more entree
        break;
        case '2':
        cost = cost  + SIDE_ITEM; // the cost plus 0.99
        side_item = side_item + 1; // adds up 1 more side item
        break;
        case '3':
        cost = cost + SIDE_ITEM; // the cost plus 0.99
        side_item = side_item + 1; //adds up 1 more side item
        break;
        case '4':
        cost = cost + DRINK_REG; // the cost plus 1.99
        drink_reg = drink_reg + 1; // adds up 1 more regular drink
        break;

        case '5':
        cost = cost + DRINK_LARGE; // the cost plus 2.49
        drink_large = drink_large + 1; // adds up 1 more large drink
        break;

        case 'C':
        cout << "Thank you. Your total is $" << cost << endl;
        // this breaks the loop .
        break;

        case 'S':
        cout << "You can now start over on your order." << endl;
        entrees = 0;
        side_item = 0;
        drink_reg = 0;
        drink_large = 0;
        cost = 0;           //this reinitiates everything, including the cost.
        break;

        default:
        cout << "Please choose an actual order." << endl;
        break;
        }

    cout << "You have " << entrees << " Main Entree(s), " << side_item << " Side(s), " << drink_reg << " Reg Drink(s), " << drink_large << " Lg Drink(s)" << endl;

    } while (input != 'C');
       */

    return 0;
}  

double menu(char input, int &entrees, int &side_item, int &drink_reg, int &drink_large)
{

    double cost = 0;

    const double MAIN_ENTREE = 4.99;
    
    const double SIDE_ITEM = 0.99;
    
    const double DRINK_REG = 1.99;

    const double DRINK_LARGE = 2.49;

    do
    {
        cout << "1 - Main Entree Burrito" << endl;
        cout << "2 - Side Item - Taco" << endl;
        cout << "3 - Side Item - Flauta" << endl;
        cout << "4 - Regular drink" << endl;
        cout << "5 - Large drink" << endl;
        cout << "C - Check out" << endl;
        cout << "S - Start over" << endl;
        
        cin >> input;
        
        switch (input)
        {
            case '1':
            cost = cost + MAIN_ENTREE;
            entrees = 1 + entrees;
            break;

            case '2':
            cost = cost  + SIDE_ITEM;
            side_item = side_item + 1;
            break;

            case '3':
            cost = cost + SIDE_ITEM;
            side_item = side_item + 1;
            break;

            case '4':
            cost = cost + DRINK_REG;
            drink_reg = drink_reg + 1;
            break;
            
            case '5':
            cost = cost + DRINK_LARGE;
            drink_large = drink_large + 1;
            break;

            case 'C':
            cout << "Thank you. Your total is $" << cost << endl;
            break;

            case 'S':
            cout << "You can now start over on your order." << endl;
            entrees = 0;
            side_item = 0;
            drink_reg = 0;
            drink_large = 0;
            cost = 0;
            break;
        }
        
         cout << "You have " << entrees << " Main Entree(s), " << side_item << "Side(s), " << drink_reg << " Reg Drink(s), " << drink_large << " Lg Drink(s)" << endl;

    } while (input != 'C');
    
    return cost;
}
