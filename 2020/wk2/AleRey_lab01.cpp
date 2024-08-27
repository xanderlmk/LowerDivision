// Alexander Reyes
// Lab 1
// 2/3/2022

#include <iostream>
#include <bits/stdc++.h>

using namespace std;

class CreditCard
{
    protected:
        string number;
        string type;
        int expmo, expyear;

        bool check_luhn(const string& number)
        {
            // Google/Lookup how the LUHN algorithm works
            // and implement here using number property
            int nDigits = number.length();
            int nSum = 0, isSecond = false; // isSeconds starts off as false because 1 is odd.

            for (int i = nDigits - 1; i >= 0; i--) 
            {

                int d =  number[i] - '0';

                if (isSecond == true)
                {
                    d = d * 2; 
                }

                nSum += d / 10; // will eventuallt add the total sum of the digits and check if the product of 
                nSum += d % 10; // doubling the second number is greater than 10. If it is it will add the numbers,
                                // ex 9*2 = 18, 1+8.

                isSecond = !isSecond; // will skip to every second number to double it.
            }

            return (nSum % 10 == 0); // checks if the total ends in a zero, meaning there shouldn't be any remainder.

        }
    public:
        CreditCard(string num, int exm, int exy)
        {
            number = num;
            expmo = exm;
            expyear = exy;
        }

        virtual bool validate(int curmo, int cury, string code) = 0;

};

class Visa : public CreditCard
{
    public:
        Visa(string num, int m, int y) : CreditCard(num, m, y)
    {
        type = "Visa";
    }

        bool validate(int cm, int cy, string code)
        {
            int stored = expyear * 100 + expmo; // 202211
            int curr = cy * 100 + cm;            // 202202

            return (curr <= stored) && number.length() == 16 && code.length() == 3 && number[0] == '4' && check_luhn(number);
        }

};
/*
 * Validation rules
 * --------
 * Amex => 15 chars, starts with a '3', code = length 4
 * MC => 16 char, starts with a '5', code = length 3
 * EXTRA CREDIT
 * --------
 *
 */

class Amex : public CreditCard
{
    public:
        Amex(string num, int m, int y) : CreditCard(num, m, y)
    {
        type = "Amex";
    }

        bool validate(int cm, int cy, string code)
        {
            int stored = expyear * 100 + expmo;
            int curr = cy * 100 + cm;

            return (curr <= stored) && number.length() == 15 && code.length() == 4 && number[0] == '3' && check_luhn(number);
        }

};

class Mastercard : public CreditCard
{
    public:
        Mastercard(string num, int m, int y) : CreditCard(num, m, y)
    {
        type = "Mastercard";
    }

        bool validate(int cm, int cy, string code)
        {
            int stored = expyear * 100 + expmo;
            int curr = cy * 100 + cm;
            return (curr <= stored) && number.length() == 16 && code.length() == 3 && number[0] == '5' && check_luhn(number);
        }
};
CreditCard * create()
{   
    string ccno;
    int ccmo, ccyr;

    cout << "Enter credit card number: ";
    cin >> ccno;

    cout << "Enter card exp month and year: ";
    cin >> ccmo >> ccyr;

    if (ccno[0] == '4')     // factory pattern, can make different objects based on conditions
    {
        return new Visa(ccno, ccmo,ccyr);
    }
    else if (ccno[0] == '3') // Amex
    {
        return new Amex(ccno, ccmo, ccyr);
    }
    else if (ccno[0] == '5') // Mastercard
    {
        return new Mastercard(ccno, ccmo, ccyr);
    }
    else
    { 
        return NULL;
    }
}

int main()
{
    int valmo= 2, valyear = 2022;
    string valcode;

    CreditCard * cc = create();

    if (cc != NULL)
    {
        cout << "Enter validation code: ";
        cin >> valcode;

        if (cc->validate(valmo, valyear, valcode))
        {
            cout << "Approved" << endl;
        }
        else
        {
            cout << "Declined" << endl;
        }
    }
    else
        cout << "Invalid credit card" << endl;

    delete cc;

    return 0;
}
