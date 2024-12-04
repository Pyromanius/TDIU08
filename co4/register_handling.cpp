#include <iostream>
#include <string>
#include <iomanip>
#include <fstream>
#include <vector>
#include <sstream>
#include <algorithm>

#include "register_handling.h"

using namespace std;

bool is_in_register(Hero_Type const& new_hero, Register_Type const& reg)
{
    for (int i{}; i < static_cast<int>(reg.size()); ++i)
    {
        if (new_hero == reg.at(i))
            return true;
        else
            continue;
    }

    return false;
}

void read_hero_register(string const reg_file_name, Register_Type &reg)
{
    ifstream file_to_read;

    file_to_read.open(reg_file_name);
    while (!file_to_read.eof())
    {
        Hero_Type new_hero{};
        string hero_interests{};
        int interest{}; 

        file_to_read >> new_hero.name >> new_hero.year >> new_hero.weight >> new_hero.hair_clr;
        getline(file_to_read, hero_interests);
        istringstream s_s(hero_interests);
        while (s_s >> interest) 
        {
            new_hero.interests.push_back(interest);
        }
        if (!is_in_register(new_hero, reg) && !new_hero.name.empty())
            reg.push_back(new_hero);
    }
    file_to_read.close();
}

void update_register_file(string const reg_file_name, Register_Type const& reg)
{
    fstream reg_file;
    string last_line;

    reg_file.open(reg_file_name, ios::out);
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

void register_new_hero(string const reg_file_name, Register_Type &reg)
{
    Hero_Type new_hero;

    read_hero_register(reg_file_name, reg);
    create_new_hero(new_hero);

    if (!is_in_register(new_hero, reg))
    {
        reg.push_back(new_hero);
        sort(begin(reg), end(reg));
        update_register_file(reg_file_name, reg);
    }
}

Register_Type match_interests_w_heros(Register_Type const& reg, vector<int> const& interests)
{
    Register_Type new_matches_list{};
    Hero_Type new_match{};
    
    for (int i{}; i < static_cast<int>(interests.size()); i++)
    {
        for (int z{}; z < static_cast<int>(reg.size()); z++)
        {
            if (find(reg.at(z).interests.begin(), reg.at(z).interests.end(), interests.at(i)) != reg.at(z).interests.end())
            {
                new_match = reg.at(z);
                if (find(new_matches_list.begin(), new_matches_list.end(), new_match) != new_matches_list.end())
                    continue;
                else
                    new_matches_list.push_back(new_match); 
            }
        }
    }
    return new_matches_list;
}

void find_hero_matches(string const reg_file_name, Register_Type &reg)
{
    int interest{};
    Register_Type matches_list{};
    vector<int> interests{};

    read_hero_register(reg_file_name, reg);

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

    matches_list = match_interests_w_heros(reg, interests);
    
    cout << "There are " << static_cast<int>(matches_list.size()) << " matching heroes." << endl;
    print_hero_list(matches_list);
}

void print_hero_list(Register_Type const& reg)
{
    cout << left << setw(11) << "Hero name" 
        << left << setw(12) << "Birth year" 
        << left << setw(8) <<  "Weight" 
        << left << setw(12) << "Hair color"  
        << left << "Interests" << endl
        << setfill('=') << setw(52) << "=" << endl << setfill(' ');

    for (int curr_hero{}; curr_hero < static_cast<int>(reg.size()); ++curr_hero)
    {
        cout << left << setw(11) << reg.at(curr_hero).name
            << setw(12) << reg.at(curr_hero).year 
            << setw(8) << fixed << setprecision(2) <<  reg.at(curr_hero).weight 
            << setw(14) << reg.at(curr_hero).hair_clr; 
        for (int curr_interest{}; curr_interest < static_cast<int>(reg.at(curr_hero).interests.size()); ++curr_interest)
        {
            cout << setw(3) << right << reg.at(curr_hero).interests.at(curr_interest);
        }
        cout << endl;
    }
}

bool operator < (Hero_Type const& lhs, Hero_Type const& rhs)
{
    for (int i{}; i < static_cast<int>(lhs.name.length()) && i < static_cast<int>(rhs.name.length()); i++)
    {
        if (lhs.name.at(i) < rhs.name.at(i))
        {
            cout << lhs.name << " < " << rhs.name << endl
                << "Because: " << lhs.name.at(i) << " < " << rhs.name.at(i) << endl;
            return true;
        }
        else if (lhs.name.at(i) > rhs.name.at(i))
        {
            return false;
        }
    }
    return lhs.name.length() < rhs.name.length();
}

bool operator == (Hero_Type const& lhs, Hero_Type const& rhs)
{
    if (lhs.name == rhs.name)
    {
        return true;
    }
    else
    {
        return false;
    }
}