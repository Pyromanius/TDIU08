//Antgu873: Arbetat enskilt

#include <iostream>
#include <iomanip>
#include <cmath>
#include <cctype>

using namespace std;

int fakul(int &n) 
{
  int sum {1};
  for (int i = 1; i < (n+1); i++)
  {
    sum = sum*i;   
  }
  return sum;
}	

void prog1()
{
    int n;
    cout << "Skriv in N: ";
    cin >> n;
    cout << "Fakulteten av " << n << " är " << fakul(n) << endl;
}

void menu(int &sel)
{
    while (true)
    {
        cout << "1. Beräkna N-fakultet." << endl <<
        "2. Multiplicera en sträng." << endl << 
        "3. Byta värden på ett heltal och ett flyttal." << endl <<
        "4. Beräkna totala längden samt medellängden på två strängar." << endl <<
        "5. Avsluta programmet." << endl << "Val: ";
        cin >> sel;

        if ((sel <1) or (sel > 5))
        {
            cout << "Felaktigt val!" << endl;
        }
        else
        {
            break;
        }
    }
}

int main()
{

    int sel;

cout << "Huvudmeny" << endl;
while (true)
{   
    menu(sel);

    if (sel == 1)
    {
        prog1();
    }
}
}