//Antgu873: Arbetat enskilt

#include <iostream>
#include <iomanip>
#include <cmath>
#include <cctype>

using namespace std;

int prog1_calc_facul(int n) 
{
    int sum{1};

    for (int i = 1; i < (n+1); i++)
    {
        sum = sum*i;   
    }

    return sum;
}	

string prog2_multi_text(string const &text, int multiplier)
{
    string multi_text{};

    for (int i{}; i < multiplier; i++)
    {
        multi_text += text;
    }

    return multi_text; 
}

void prog3_switch_int_double(int &a, double &b)
{
    int tmp_1{}; 

    tmp_1 = static_cast<int>(ceil(b));
    b = static_cast<double>(a);
    a = tmp_1;
}

void prog4_calc_lengths(string const &text_1, string const &text_2, int &total_length, double &mean_length)
{
    total_length = text_1.length() + text_2.length();
    mean_length = static_cast<double>(total_length)/2;
}

void menu(int &sel)
{
    while (true)
    {
        cout << "1. Beräkna N-fakultet.\n"
            << "2. Multiplicera en sträng.\n"
            << "3. Byta värden på ett heltal och ett flyttal.\n"
            << "4. Beräkna totala längden samt medellängden på två strängar.\n"
            << "5. Avsluta programmet.\n"
            << "Val: ";
        cin >> sel;

        if ((sel < 1) or (sel > 5))
        {
            cout << "Fel val!" << endl;
        }
        else
            break;
    }
}

void menu_sel_1()
{
    int n{};

    cout << "Mata in ett heltal: ";
    cin >> n;
    cout << "Fakulteten av " << n << " är " << prog1_calc_facul(n) << endl;
}

void menu_sel_2()
{
    int multiplier{};
    string text{};

    cout << "Mata in en text och ett heltal: ";
    cin >> text >> multiplier;
    cout << "Den multiplicerade texten är " << prog2_multi_text(text, multiplier) << endl;
}

void menu_sel_3()
{
    int a{};
    double b{};

    cout << "Mata in ett heltal och ett flyttal: ";
    cin >> a >> b;
    prog3_switch_int_double(a, b);
    cout << "Heltalets värde är nu " << a << "\n"
        << "Flyttalets värde är nu " << fixed << setprecision(1) << b << endl;
}

void menu_sel_4()
{
    int total_length{};
    double mean_length{};
    string text_1{}, text_2{};

    cout << "Mata in två ord: ";
    cin >> text_1 >> text_2;
    prog4_calc_lengths(text_1, text_2, total_length, mean_length);
    cout << "Totallängd: " << total_length << "\n"
        << "Medellängd: " << fixed << setprecision(1) << mean_length << endl;
}

int main()
{
    int sel{};

    cout << "Välkommen till huvudmenyn!" << endl;
    while (true)
    {   
        menu(sel);
        if (sel == 1)
        {
            menu_sel_1();
        }
        else if (sel == 2)
        {
            menu_sel_2();
        }
        else if (sel == 3)
        {
            menu_sel_3();
        }
        else if (sel == 4)
        {
            menu_sel_4();
        }
        else if (sel == 5)
        {
            cout << "Ha en bra dag!";
            return 0;
        }
    }
}