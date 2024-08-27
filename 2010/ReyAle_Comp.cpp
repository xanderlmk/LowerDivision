#include <iostream>
#include <cstdlib>
#include <string>

using namespace std;

class Card
{
    private:
        // suit contains values 1-4, to represent suits below
        // 1 - Diamonds, 2 - Hearts, 3 - Clubs, 4 - Spades
        int suit; 
        // value contains values 1 - 13
        // Ace = 1, 2-10, J = 11, Q = 12, K = 13
        int value;

    public:
        Card()
        {
        }

        Card(int s, int v)
        {
            suit = s;
            value = v;
        }

        void set(int s, int v)
        {
            suit = s;
            value = v;
        }

        int get_suit()
        {
            return suit;
        }

        int get_value()
        {
            return value;
        }

        // function to return a string that describes the card
        string as_string()
        {
            string str;
            string name;

            switch (suit)
            {
                case 1:
                    name = "Diamonds";
                    break;
                case 2:
                    name = "Hearts";
                    break;
                case 3:
                    name = "Clubs";
                    break;
                case 4:
                    name = "Spades";
                    break;
            }

            if (value == 1)
                str = "Ace";
            if (value <= 10 && value > 1)
                str =  to_string(value);
            if (value == 11)
                str = "Jack";
            if (value == 12)
                str = "Queen";
            if (value == 13)
                str = "King";
            return str + " of " + name;

            // for example, if suit == 1 and value == 1
            // this function would return "Ace of Diamonds"
        } 

        bool operator<=(Card right)
        {

            bool ok;

            if (value != 1 && right.value == 1)
                ok = true;
            if (value == 1 && right.value != 1)
                ok = false;  
            if (value < right.value)
                ok = true;
            if (value > right.value)
                ok = false;
            if (value == right.value)
            {
                ok = true;
            }

            return ok;
        }

        friend ostream & operator<<(ostream & out, Card card)
        {
            out << card.as_string();
            return out;
        }

        
        ~Card()
        {
        }
};

class Deck
{
    private: 
        Card cards[52];
        // the inplay array holds a true/false value to indicate
        // if the card in the same position is currently in play
        // a card is "in play" if it has been drawn out of the deck
        bool inplay[52];

    public:
        // constructor will set suit and value for each of the 
        // card objects in the array 
        Deck()
        {
            int a = 0;

            for (int k = 1; k <= 4; k++)
            {

                for (int o = 1; o <= 13; o++)
                {
                    cards[a].set(k, o);

                    a++;    
                }

            }

        }

        void unplay()
        {
            for (int i = 0; i < 52; i++)
                inplay[i] = false;
        }

        // randomize/shuffle the deck of cards so that the 
        // cards in the array are in a random order

        void shuffle()
        {
            int random;
            Card temp;

            for (int i = 0; i < 52; i++)
            {
                // identify a card at position i
                // generate a random number between 0 and 51

                random = rand() % 52;
                temp = cards[i];
                cards[i] = cards[random];    
                cards[random] = temp;

                // use random as an index into the card array
                // swap the card values for the cards at positions i
                // and random
            }

            unplay();  // set all cards to "not in play"
        }

        Card draw()
        {
            Card drawn;

            // returns a Card object. randomly pick a card out of the 
            // deck that is not currently in play. A card is in play
            // if its corresponding value in the inplay array is true

            // Once a random card has been picked out of the deck,
            // set the corresponding inplay value to true

            int r = rand() % 52;

            while (inplay[r] == true)
            {
                r = rand() % 52;
            }

            drawn = cards[r];
            inplay[r] == true;

            return drawn;
        }

        ~Deck()
        {
        }
};

class Game
{
    private:
        Deck deck;
    public:
        // constructor will shuffle the deck
        Game()
        {
            deck.shuffle();
        }

        void deal(Card hand[], int count)
        {
            // this function will select the # of cards specified in the     
            // count parameter out of the deck using the Deck's
            // draw() function. Remember that arrays passed 
            // as parameters can be set in the function
            // and made available to the caller's scope

            for ( int i = 0; i < count; i++)
            {
                hand[i] = deck.draw();
            } 

        }
        ~Game()
        {
        }
};


class Poker : public Game
{
    public:
        // this function will determine if the 5-card hand passed
        // as the parameter is a flush. A flush is a hand where
        // all cards have the same suit
        bool is_flush(Card hand[])
        {

            bool flush = true;

            for (int i = 0; i < 5; i++)
            {

                if (hand[i].get_suit() != hand[i+1].get_suit())
                    flush = false;

            }

            return flush;
        }

        // OPTIONAL - this function will determine if the 5-card
        // hand passed as the parameter is a Four-Of-A-Kind. A FOAK
        // has 4 cards with the same value. The 5th card can be any
        // value
        bool is_foak(Card hand[])
        {
            bool foak = false;

            int count = 0;

            for (int k = 0; k < 5; k++)
            {
                int ii = 0;

                if (hand[k].get_value() == hand[ii].get_value())
                {
                    count++;
                }

                ii++;
            }

            if (count == 4)
            {
                foak = true;
            }

            return foak;
        }

};


class Blackjack: public Game
{
    public:
        // this function will determine if the 2-card hand passed
        // as the parameter is a blackjack. A blackjack is a hand where
        // the two cards add up to 21
        // Hands that work: Ace + King, Ace + Queen, Ace + Jack,
        // or Ace + 10
        bool is_blackjack(Card hand[])
        {
            int count = 0;

            bool blackjack = false;

            count = hand[0].get_value() + hand[1].get_value();

            if (hand[0].get_value() == 1 && hand[1].get_value() == 10)
                blackjack = true;
            if (hand[0].get_value() == 1 && hand[1].get_value() == 11) 
                blackjack = true;
            if (hand[0].get_value() == 1 && hand[1].get_value() == 12)
                blackjack = true;
            if (hand[0].get_value() == 1 && hand[1].get_value() == 13)
                blackjack = true;
            if (hand[0].get_value() == 10 && hand[1].get_value() == 1)
                blackjack = true;
            if (hand[0].get_value() == 11 && hand[1].get_value() == 1)
                blackjack = true;
            if (hand[0].get_value() == 12 && hand[1].get_value() == 1)
                blackjack = true;
            if (hand[0].get_value() == 13 && hand[1].get_value() == 1)
                blackjack = true;
            if (count >= 21)
            {
                blackjack = true;
            }

            return blackjack;
        }

};


int main()
{
    Poker poker;
    Card hand[5];

    srand(time(NULL));
    poker.deal(hand, 5);

    cout << "Poker hand:" << endl;

    for (int i = 0; i < 5; i++)
    {
        cout << hand[i] << endl;
    }

    if (poker.is_flush(hand))
        cout << "Your hand is a flush" << endl;
    else
        cout << "No flush" << endl;

    if (poker.is_foak(hand))
        cout << "Your hand is a four of a kind" << endl;
    else
        cout << "No four of a kind" << endl;

    Blackjack blackjack;
    Card hand2[2];

    blackjack.deal(hand2, 2);

    cout << "Blackjack hand:" << endl;

    for (int i = 0; i < 2; i++)
    {
        cout << hand2[i] << endl;
    }

    if (blackjack.is_blackjack(hand2))
        cout << "Your hand is a blackjack" << endl;
    else
        cout << "No blackjack" << endl;

    Deck deck1;  
    deck1.shuffle();
    Card card1, card2;

    card1 = deck1.draw();
    card2 = deck1.draw();

    if (card1 <= card2)
        cout << card2 << " beats or matches " << card1 << endl;
    else
        cout << card1 << " beats " << card2 << endl;

    return 0;
}

