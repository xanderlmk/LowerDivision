// Alexander
// Final Problem #7
// 12/9/21

#include <iostream>
#include <fstream>

using namespace std;

class Account 
{
    // use the correct access specifier below such that
    // the variables, number and balance, are available
    // to child classes of Account
    protected:
        string number;
        double balance = 0; 

};

// implement Checking class as a child of Account below

class Checking : public Account
{
    private:
        string routing;
        
        double get_trans_total()
        {
            
            double total = 0;
            ifstream fin;
            fin.open("account.txt");
            if (fin.is_open())
            {
                string activity;
                char DorC;

                double money;
                
                while (!fin.eof())
                {
                    fin >> activity >> DorC >> money;

                    if (fin.good())
                    {   
                        if (DorC == 'C')
                            total = total + money;
                        else (DorC == 'D');
                            total = total - money;
                    }

                }

                
                fin.close();
            }

            else
            {
                cout << "Unable to open file" << endl;
            }            

            return total * -1;
        }
    public:
        void create_statement()
        {
            balance = get_trans_total();

            ofstream fout;

            fout.open("statement.txt");

            if (fout.is_open())
            {
                fout << number << endl;
                fout << routing << endl;
                fout << balance << endl;
            }
        }
        Checking(string n, string r)
        {
            number = n;
            routing = r;
        }
};
int main()
{
    // ##### YOU SHOULDN'T NEED TO DO ANYTHING ELSE IN MAIN #####

    // instantiate acct object 
    // with routing and checking numbers
    Checking acct("01234567", "333444000");

    // create text file of account statement
    acct.create_statement();

    return 0;
}
