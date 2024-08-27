#include <iostream>

using namespace std;

int main () {
    int score;

    char discharged = 'y';
   
    char bankruptcy = 'n';

    double rate = 0.0;

    cout << "--Thank you for applying to ASSY'S loan--" << endl;

    cout << "What is your credit score?" << endl;

    cin >> score;

    cout << "Have you had a bankruptcy? (y/n)" << endl;

    cin >> bankruptcy;


    if (bankruptcy != 'n') //If you been bankrupt, aka broke
    {
        cout << "Has your bankruptcy been discharged? (y/n)" << endl;
        cin >> discharged;
        if (discharged != 'y') //if your bankruptcy is still therre 
        {
            cout << "Your application has been denied" << endl;
            cout << "Try again in 6 months" << endl;
        }
        else if (discharged == 'y' && score < 650)
        {
            cout << "Your application has been denied" << endl;
            cout << "try again in 6 months" << endl;
        }
        else if ( discharged == 'y' && score >= 721)
        {
            cout << "You're application has been APPROVED!" << endl;
            cout << "Your rate is " << rate + 4.9 << "%." << endl;  
        }
        else
        {
             cout << "You're application has been APPROVED!" << endl;
             cout << "Your rate is " << rate + 6.5 << "%." << endl;
        }

    }
    
    else  // if you've never had bankruptcy, aka never been broke
    {
        if ( score < 650)
        {
            cout << "Your application has been denied" << endl;
            cout << "Try again in 6 months" << endl;
        } 
        else if ( score >= 721)
        {
            cout << "You're application has been APPROVED!" << endl;
            cout << "Your rate is " << rate + 1.9 << "%." << endl;
        }
        else
        {
            cout << "You're application has been APPROVED!" << endl;
            cout << "Your rate is " << rate + 3.5 << "%." << endl;
        }
    }
    return 0;
}
