//Antgu873: Arbetat enskilt

#include <string>
#include <iostream>

#include "register_handling.h"
    
using namespace std;

bool is_arg_correct(int const num_arguments, string const& prog_name)
{
    if (num_arguments != 2)
    {
        cout << "Incorrect number of arguments!\n"
            << "Usage: " << prog_name << " REGISTERFILE";
        return false;
    }
    else
    {
        return true;
    }
}

int hero_matchmaker_menu(int & sel)
{
    sel = 0;

    cout << "Welcome to Hero Matchmaker 3000!" << endl 
        << "1) Add new hero to register file" << endl
        << "2) Find matching heroes" << endl
        << "3) Quit program" << endl;
        while (sel < 1 || sel > 3){
            cout << "Select: ";
            cin >> sel;
        }
        return sel;
}

int main(int argc, char* arg[])
{
    int sel{};
    Register_Type hero_register{};

    if (is_arg_correct(argc, arg[0]))
    {
        while (hero_matchmaker_menu(sel) < 4)
        {
            if (sel == 1)
            {
                register_new_hero(arg[1], hero_register);
            }
            else if (sel == 2)
            {
                find_hero_matches(arg[1], hero_register);
            }
            else if (sel == 3)
            {
                cout << "Terminating Hero Matchmaker 3000!";
                return 0;
            }
        }
    }
    else
    {
        exit(0);
    }
};