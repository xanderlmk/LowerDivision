#include <iostream>

using namespace std;

string get_ordinal(int &verse);

int show_verse(int &x);

int main()
{
    string verse;
    
    int x = 1;

    get_ordinal(verse);
    
    show_verse(x);

    

    return 0;
}


string get_ordinal(int verse)
{

   string ordinal = " ";

   if (verse == 1)
   {
   ordinal = verse + "st ";
   }

   if (verse == 2)
   {
   ordinal = verse + "nd ";
   }

   if (verse == 3)
   {
   ordinal = verse + "rd ";
   }

   else
   {
   ordinal = verse + "th ";
   }

       


    return x;
}

int show_verse(int x)
{
    


    string verse1 = "a partridge in a pear tree.";

    string verse2 = "2 turtle doves,";
    
    string verse3 = "3 french hens,";
    
    string verse4 = "4 colly birds,";

    string verse5 = "5 golden rings,";

    string verse6 = "6 geese-a-laying,";
    
    string verse7 = "7 swans-a-swimming,";
    
    string verse8 = "8 maids-a-milking,";
    
    string verse9 = "9 ladies dancing,";
    
    string verse10 = "10 lords-a-leaping,";
    
    string verse11 = "11 pipers piping,"; 
    
    string verse12 = "12 drummers drumming,";

    for (int i = 1; i <= 12; i++)
    {
        cout << "On the 12th day of Christmas," << endl;
        cout << "My true love gave to me," << endl;
       
        if (i == 1)
        {
            cout << verse12 << endl;
        }

        if (i == 2)
        {
            cout << verse11 << endl;
        }

        if (i == 3)
        {
            cout << verse10 << endl;
        
        }
        if (i == 4)
        {
            cout<< verse9 << endl;
        }

        if (i == 5)
        {
            cout << verse8 << endl;
        }

        if (i == 6)
        {
            cout << verse7 << endl;
        }

        if (i == 7)
        { 
            cout << verse6 << endl;
        }

        if (i == 8)
        {
            cout << verse5 << endl;
        }

        if (i == 9)
        {
            cout << verse4 << endl;
        }

        if (i == 10)
        {
            cout << verse3 << endl;
        }

        if (i == 11)
        {
            cout << verse2 << endl;
        }

        if (i == 12)
        {
            cout << "And " << verse1 << endl;
        }


    }

return x;
}
