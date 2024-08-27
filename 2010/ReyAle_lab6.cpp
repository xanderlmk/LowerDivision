#include <iostream>

using namespace std;

int main () {
    
    int limit;
    
    int divisor;
    
    cout << "Enter limit value: " << endl;
    cin >> limit;
    

    do
    {

    cout << "Enter divisor value: " << endl;
    cin >> divisor;

        if (divisor == 0)
        {
        cout << "Divisor range cannot include zero" << endl;
        }

    }while (divisor == 0); // in order to break out this loop, the divisor can't equal 0
   
    int i = 1;

    while (i <= limit)
    {

        do
        { 
        cout << i << " is divisble by 1" << endl;
        
        if ( i % divisor == 0 )
        
        {
        cout << i << " is divible by " << divisor << endl; 
        }
        
        i = i + 1;

        }while ( i % divisor == 0 && i <= limit); /* this checks if the number is divisible by the divisor, if not it'll keep subtracting till it reaches a number that is divisble
                                                     and the number does not surpass the limit*/
       

    } 


    return 0;
}
