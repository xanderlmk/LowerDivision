#include <iostream>
#include <cstring>
#include <cctype>
#include <fstream>

using namespace std;

void parse_name(char full[], char first[], char last[]);

void create_timecard(double hours[], char first[], char last[]);

int main()
{
    char full[40], first[20], last[20];
    double hours[5];

    cout << "Enter you're full name: ";

    cin.getline(full, 40);

    parse_name(full, first, last);
   
    for ( int i = 0; i < 5; i ++)
    { 
       cout << "Enter hours for day " << i + 1 << " : ";
       cin >>  hours[i];
    }

    create_timecard(hours, first, last);    

    cout << "Timecard is ready. See timecard.txt" << endl;

    return 0;
}

void parse_name(char full[], char first[], char last[])
{
    
    int size = strlen(full);

       int i = 0;

       while (!isspace(full[i]))
       {
           first[i] = full[i];
           i++;
       }
        first[i] = '\0';

        i++;

        int j = 0;

        while(i <= size)
        {
            last[j] = full[i];
            i++;
            j++;
        }
       
        

}   

void create_timecard(double hours[], char first[], char last[])
{
    // step 1, DECLARE OUR FILE VARIABLE
   ofstream fout;

    // step 2, TYPE OF FILE WE WANT TO WORK WITH

   fout.open("timecard.txt");
    
   // step 3, CHECK IF FILE SUCCESSFULLY OPENED

   if (fout.is_open())
   {

       //step 4, FILE WRITING
       double total = 0;
       fout << "First Name: " << first << endl;
       fout << "Last Name: " << last << endl;

       for (int k = 0; k < 5; k++)
       {
       fout << "Day " << k+1 << " : " << hours[k] << endl;
       
       total = total + hours[k];
       }
       fout << "Total : " << total << endl;
       

       //step 5, CLOSE FILE
       fout.close();
   }
   
   else 
   {
       cout << "Unable to open the file." << endl;
   }






}
