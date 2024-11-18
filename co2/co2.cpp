//Antgu873: Arbetat enskilt

#include <iostream>
#include <iomanip>
#include <cmath>
#include <cctype>

using namespace std;

int prog1_calc_Facul(int &n) 
{
    int sum {1};
  for (int i = 1; i < (n+1); i++)
  {
    sum = sum*i;   
  }

  return sum;
}	

string prog2_multi_text(string &text, int &multiplier)
{
        string multi_text;
    for (int i{}; i < multiplier; i++)
    {
        multi_text += text;
    }

    return multi_text; 
}

double conv_int(int &tmp)
{
        double conv;
    conv = tmp;
    return conv;
}

int conv_double(double &tmp)
{
        int conv;
    conv = ceil(tmp);
    return conv;
}

void prog3_switch_int_double(int &a, double &b)
{
        int tmp_1; 
        double tmp_2;
    tmp_1 = conv_double(b);
    tmp_2 = conv_int(a);
    a = tmp_1;
    b = tmp_2;

}

void prog4_calc_lengths(int &total_length, double &mean_length)
{
        string text_1;
        string text_2;
    cout << "Mata in två ord: ";
    cin >> text_1 >> text_2;
    total_length = text_1.length() + text_2.length();
    mean_length = static_cast<double>(total_length)/2;
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
        int sel, total_length, n, multiplier, a;
        double mean_length, b;
        string text;
    cout << "Huvudmeny" << endl;
    while (true)
    {   
        menu(sel);
        if (sel == 1)
        {
            cout << "Skriv in N: ";
            cin >> n;
            cout << "Fakulteten av " << n << " är " << prog1_calc_Facul(n) << endl;
        }
        else if (sel == 2)
        {
            cout << "Mata in en text och ett heltal: ";
            cin >> text >> multiplier;
            cout << "Den multiplicerade texten är " << prog2_multi_text(text, multiplier) << endl;
        }
        else if (sel == 3)
        {
            cout << "Mata in ett heltal och ett flyttal: ";
            cin >> a >> b;
            prog3_switch_int_double(a, b);
            cout << "Heltalets värde är nu " << a << endl
                << "Flyttalets värde är nu " << fixed << setprecision(1) << b << endl;
        }
        else if (sel == 4)
        {
            prog4_calc_lengths(total_length, mean_length);
            cout << "Totallängd: " << total_length << endl
                << "Medellängd: " << fixed << setprecision(1) << mean_length << endl;
        }
        else if (sel == 5)
        {
            cout << "Ha en bra dag!";
            return 0;
        }
    }
}