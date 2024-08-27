#include <iostream>

using namespace std;

string get_ordinal(int verse);

int show_verse(int i = 1);

int main()
{
    int verse = 1;
    
    get_ordinal(verse);
    
    for (int i = 1; i <= 12; i++)
    {
    
        cout << "On the " << i << get_ordinal(i) << "day of Christmas," << endl;  // Will give the 1st,2nd etc...
    
        cout << "My true love gave to me," << endl;

        show_verse(i); //shows the verses
    
        cout << " " << endl; //blank line
    
        
    }
    
    

    return 0;
}


string get_ordinal(int i)
{

   string x;

   if (i == 1)
   {
   x = "st ";
   }

   if (i == 2)
   {
   x = "nd ";
   }

   if (i == 3)
   {
   x = "rd ";
   }

   if ( i > 3 && i <= 12)
   {
   x = "th ";
   }

       


    return x;
}

int show_verse(int i)
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


    if (i == 1)
    {
        cout << verse1 << endl;
    }
    
    if (i == 2)
    {
        cout << verse2 << endl;
        cout << "And " << verse1 << endl;
    }

    if (i == 3)
    {
        cout << verse3 << endl;
        cout << verse2 << endl;
        cout << "And " << verse1 << endl;
    }
    
    if (i == 4)
    {
        cout << verse4 << endl;
        cout << verse3 << endl;
        cout << verse2 << endl;
        cout << "And " << verse1 << endl;
    }

    if (i == 5) 
    {
        cout << verse5 << endl;
        cout << verse4 << endl;
        cout << verse3 << endl;
        cout << verse2 << endl;
        cout << "And " << verse1 << endl;
    }

    if (i == 6)
    {

        cout << verse6 << endl;
        cout << verse5 << endl;
        cout << verse4 << endl;
        cout << verse3 << endl;
        cout << verse2 << endl;
        cout << "And " << verse1 << endl;
    }

    if (i == 7)
    {
        cout << verse7 << endl;
        cout << verse6 << endl;
        cout << verse5 << endl;
        cout << verse4 << endl;
        cout << verse3 << endl;
        cout << verse2 << endl; 
        cout << "And " << verse1 << endl;
    }

    if (i == 8)
    {
        cout << verse8 << endl;
        cout << verse7 << endl;
        cout << verse6 << endl;
        cout << verse5 << endl;
        cout << verse4 << endl;
        cout << verse3 << endl;    
        cout << verse2 << endl; 
        cout << "And " << verse1 << endl;
    }

    if (i == 9)
    {
        cout << verse9 << endl;
        cout << verse8 << endl;
        cout << verse7 << endl;
        cout << verse6 << endl;
        cout << verse5 << endl;
        cout << verse4 << endl;
        cout << verse3 << endl;
        cout << verse2 << endl;
        cout << "And " << verse1 << endl;
    }

    if (i == 10)
    {
        cout << verse10 << endl;
        cout << verse9 << endl;
        cout << verse8 << endl;
        cout << verse7 << endl;
        cout << verse6 << endl;
        cout << verse5 << endl;
        cout << verse4 << endl;
        cout << verse3 << endl;
        cout << verse2 << endl;
        cout << "And " << verse1 << endl;
    }

    if (i == 11) 
    {
        cout << verse11 << endl;
        cout << verse10 << endl;
        cout << verse9 << endl;
        cout << verse8 << endl;
        cout << verse7 << endl;
        cout << verse6 << endl;
        cout << verse5 << endl;
        cout << verse4 << endl;
        cout << verse3 << endl;
        cout << verse2 << endl;
        cout << "And " << verse1 << endl;
    }

    if (i == 12)
    {
        cout << verse12 << endl;
        cout << verse11 << endl;
        cout << verse10 << endl;
        cout << verse9 << endl;
        cout << verse8 << endl;
        cout << verse7 << endl;
        cout << verse6 << endl;
        cout << verse5 << endl;
        cout << verse4 << endl;
        cout << verse3 << endl;
        cout << verse2 << endl;
        cout << "And " << verse1 << endl;
    }

return i;
}
