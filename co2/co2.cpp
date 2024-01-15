//Antgu873: Arbetat enskilt

#include <iostream>
#include <iomanip>
#include <cmath>
#include <cctype>

using namespace std;

int calc_Facul(int &n) 
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
    cout << "Fakulteten av " << n << " är " << calc_Facul(n) << endl;
}

void prog2()
{
    string text;
    int multiplier;

    cout << "Mata in en text och ett heltal: ";
    cin >> text;
    cin >> multiplier;

    cout << "Den multiplicerade texten är ";
    for (int i{}; i < multiplier; i++)
    {
        cout << text;
    }
    cout << endl; 
}

double conv_Int(int &tmp)
{
    double conv;

    conv = tmp;
    return conv;
}

int conv_Double(double &tmp)
{
    int conv;

    conv = ceil(tmp);
    return conv;
}

void prog3()
{
    int a;
    double b;

    cout << "Mata in ett heltal och ett flyttal: ";
    cin >> a;
    cin >> b;

    cout << "Heltalets värde är nu " << conv_Double(b) << endl;
    cout << "Flyttalets värde är nu " << fixed << setprecision(1) << conv_Int(a) << endl;
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
            cout << "Fel val!" << endl;
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
    else if (sel == 2)
    {
        prog2();
    }
    else if (sel == 3)
    {
        prog3();
    }
    else if (sel == 4)
    {
        prog4();
    }
}
}