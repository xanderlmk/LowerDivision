#include <iostream>
#include <cstring>

using namespace std;

class PasswordException : public exception
{
    public:
       const char * what() const throw()
       {
           return "Password error";
       }


class PasswordNoDigits : public PasswordException
{
    public:
        const char * what() const throw()
        {
            return "Password needs digits";
        }
};

class PasswordTooShort : public PasswordException
{
    public:
        const char * what() const throw()
        {
            return "Password too short";
        }
};

class PasswordNoSymbols : public Password Exception
{
    public:
        const char * what() const throw()
        {
            return "Passwords needs symbols";
        }
};

bool has_symbols(char text[])
{
    bool result = false;
    
    for (int i = 0; i < strlen(text); i++)
    {
        if (text[i] == '!' || text[i] == '$')
        {
            result = true;
        }
    }

    return result;
}

int main()
{
    char password[100];
    
    cout << "Enter password: ";

    cin.getline(password, 100); //jpw tp receive char array input
    try
    {
        bool digits = false;

        for  (int i = 0; i < strlen(password); i++)
        {
            if (isdigit(password[i]))
                digits = true;
        }

        if (!digits)
            throw PasswordNoDigits();   // need to create
    
        if(strlen(password) < 6)
            throw PasswordTooShort();

        if (!has_symbols(password))
                throw PasswordNoSymbols();


        cout << "Your password is ok" << endl;
    }

    catch (PasswordTooShort & pts) // wide
    {
        cerr << pts.what() << endl;
    }
    catch (PasswordNoDigits & pnd) // wide
    {
        cerr << pnd.what() << endl;
    }
    catch (PasswordNoSymbols & pns) //wide
    {
         cerr << pns.what() << endl;
    }
    catch (PasswordException & pe) // wide
    {
        cerr << pe.what() << endl; // wide
    }
    catch(...) //default catch handler
    {
        cerr << "something happened. not sure. check yourpassword" << endl;
    }
    return 0;
}
