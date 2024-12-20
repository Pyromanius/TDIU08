#include <iostream>
#include <string>
#include <iomanip>
#include <fstream>
#include <vector>
#include <sstream>
#include <algorithm>

#include "register_handling.h"

using namespace std;

bool is_in_register(Hero_Type const& new_hero, 
                    Register_Type const& reg)
{
    for (int i{}; i < static_cast<int>(reg.size()); ++i)
    {
        if (new_hero == reg.at(i))
        {
            return true;
        }
    }

    return false;
}

void load_register_file(string const& reg_file_name, 
                        Register_Type &reg)
{
    ifstream file_to_read{reg_file_name, ios::in};
    Hero_Type new_hero{};

    reg.clear();
    do 
    {
        if (!is_in_register(new_hero, reg))
        {
            reg.push_back(new_hero);
        }
    }
    while (read_hero_details(file_to_read, new_hero));
}

void update_register_file(string const& reg_file_name, 
                          Register_Type const& reg)
{
    fstream reg_file{reg_file_name, ios::out};

    for (int i{}; i < static_cast<int>(reg.size()); ++i)
    {
        reg_file << left << setw(11) << reg.at(i).name
            << setw(12) << reg.at(i).year
            << setw(8) << reg.at(i).weight
            << setw(14) << reg.at(i).hair_clr;
            for (int z{}; z < static_cast<int>(reg.at(i).interests.size()); ++z)
            {
                reg_file << setw(4) << reg.at(i).interests.at(z);
            }
        reg_file << endl;
    }
    cout << "The hero was added to the register on file " << reg_file_name << endl;
    reg_file.close(); 
}

void register_new_hero(string const& reg_file_name, 
                       Register_Type &reg)
{
    Hero_Type new_hero{};

    load_register_file(reg_file_name, reg);
    do
    {
        create_new_hero(new_hero);
        if (is_in_register(new_hero, reg))
        {
            cout << "Hero already in register.";
        }
    }
    while (is_in_register(new_hero, reg));

    reg.push_back(new_hero);
    sort(begin(reg), end(reg));
    update_register_file(reg_file_name, reg);
}

Register_Type match_up_interests(Register_Type const& reg, 
                                 vector<int> const& interests)
{
    Register_Type new_matches_list{};
    Hero_Type potential_match{};
    
    for (int i{}; i < static_cast<int>(reg.size()); i++)
    {
        potential_match = reg.at(i);

        if (is_in_register(potential_match, new_matches_list))
        {
            continue;
        }
        else if (is_interests_match(potential_match, interests))
        {
            new_matches_list.push_back(potential_match); 
        }
            
    }
    return new_matches_list;
}

void find_hero_matches(string const& reg_file_name, 
                       Register_Type &reg)
{
    int interest{};
    Register_Type matches_list{};
    vector<int> interests{};

    load_register_file(reg_file_name, reg);

    cout << "Enter your interests (at least one between 1 and 15): ";
    do
    {
        cin >> interest;
        if (is_valid_interest(interest, interests))
        {
            interests.push_back(interest);
        }
    }
    while (cin.get() != '\n' || interests.empty());

    matches_list = match_up_interests(reg, interests);
    sort(begin(matches_list), end(matches_list));
    
    cout << "There are " << static_cast<int>(matches_list.size()) << " matching heroes." << endl;
    print_hero_list(matches_list);
}

void print_hero_list(Register_Type const& reg)
{
    cout << left << setw(11) << "Hero name" 
        << setw(12) << "Birth year" 
        << setw(8) <<  "Weight" 
        << setw(12) << "Hair color"  
        << "Interests\n"
        << setfill('=') << setw(52) << "=" << endl << setfill(' ');

    for (int curr_hero{}; curr_hero < static_cast<int>(reg.size()); ++curr_hero)
    {
        cout << left << setw(11) << reg.at(curr_hero).name
            << setw(12) << reg.at(curr_hero).year 
            << setw(8) << fixed << setprecision(2) <<  reg.at(curr_hero).weight 
            << setw(12) << reg.at(curr_hero).hair_clr; 
        for (int curr_interest{}; curr_interest < static_cast<int>(reg.at(curr_hero).interests.size()); ++curr_interest)
        {
            cout << setw(3) << right << reg.at(curr_hero).interests.at(curr_interest);
        }
        cout << endl;
    }
}
