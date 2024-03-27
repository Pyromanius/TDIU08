#include <iostream>
#include <fstream>
#include <sstream>
#include <iomanip>
#include <vector>
#include <string>

#include "co4.h"

using namespace std;

void checkArg(int const num_arguments, string const& prog_name)
{
    if (num_arguments != 2)
    {
        cout << "Incorrect number of arguments!" << endl
            << "Usage: " << prog_name << " REGISTERFILE";
            exit(0);
    }
}

void registerHero(Hero_Type const new_hero, string const reg_name)
{
        fstream reg_file;

    reg_file.open(reg_name, ios::app);

    reg_file << left << setw(11) << new_hero.name
            << left << setw(12) << new_hero.year
            << left << setw(8) << new_hero.weight
            << left << setw(14) << new_hero.hair_clr;
            for (int i{}; i < static_cast<int>(new_hero.interests.size()); ++i)
            {
                reg_file << left << setw(4) << new_hero.interests.at(i);
            }
    reg_file << endl;

    reg_file.close(); 
}

bool isValidInterest(vector<int> const& interests, int const new_interest)
{
        if (new_interest > 0 && new_interest < 16){
            for (int i{}; i < static_cast<int>(interests.size()); ++i){
                if (new_interest == interests[i])
                    return false;
                else
                    continue;
            }
        }
        else
            return false;

    return true;
}

void sortInterests(vector<int> & interests)
{

        int tmp_interest;

    for (int z = 0; z < static_cast<int>(interests.size()) - 1; ++z){
        for (int i = z + 1; i < static_cast<int>(interests.size()); ++i){
            if (interests.at(z) > interests.at(i)){
                tmp_interest = interests[z];
                interests[z] = interests[i];
                interests[i] = tmp_interest;
            }
        }
    }
}

void addHero(string const reg_name)
{
        Hero_Type new_hero;
        int interest;
        string interests_s;
        istringstream iss(interests_s);

    cout << "Enter hero information: " << endl;
    // cin >> new_hero.name
    //     >> new_hero.year
    //     >> new_hero.weight
    //     >> new_hero.hair_clr;
        new_hero.name = "Hawk";
        new_hero.year = 1984;
        new_hero.weight = 85.3;
        new_hero.hair_clr = "Blonde";

    for (int i; i < 15; ++i){
        cin >> interest;

        if (isValidInterest(new_hero.interests, interest))
            new_hero.interests.push_back(interest);

        if (cin.get() == '\n')
            break;
    } 
    sortInterests(new_hero.interests);
    registerHero(new_hero, reg_name);
}

vector<Hero_Type> searchMatches(int const interest)
{

        vector<Hero_Type> matches_list;

    for (int i; i < static_cast<int>(Register_Type.size()); ++i){
        for (int z; z < static_cast<int>(Register_Type[i].interests.size()); ++z){
            if (interest == Register_Type[i].interests.at(z)){
                matches_list.push_back(Register_Type[i]);
            }
        }
    }
    return matches_list;
    
}

void printMatches(vector<Hero_Type> const matches_list){
    cout << left << setw(11) << "Hero name" 
        << left << setw(12) << "Birth year" 
        << left << setw(8) <<  "Weight" 
        << left << setw(12) << "Hair color"  
        << left << "Interests" << endl
        << setfill('=') << setw(52) << "=" << endl;
    for (int i{}; i < static_cast<int>(matches_list.size()); ++i){
        cout << setw(11) << matches_list[i].name
            << setw(12) << matches_list[i].year 
            << setw(8) <<  matches_list[i].weight 
            << setw(12) << matches_list[i].hair_clr; 
        for (int z{}; z < static_cast<int>(matches_list[i].interests.size()); ++z){
            cout << setw(3) << matches_list[i].interests.at(z);
        }
        cout << endl;
    }
    if (matches_list.empty()){
        cout << "-------------This list is empty--------------";
    }
}

void findMatch()
{
        vector<Hero_Type> matches{};
        int interest;

    cout << "Enter your interests (at least one between 1 and 15): ";
    cin >> interest;

    matches = searchMatches(interest);

    while (cin.get() != '\n'){
        cout << endl << "kom hit" << endl;
        cin >> interest;
        matches = searchMatches(interest);
    } 
    printMatches(matches);
}

void checkList(string const reg_name)
{

       ifstream file_to_read;

    file_to_read.open(reg_name);

    while (!file_to_read.eof()){
        Hero_Type new_hero{};
        string hero_interests{};
        int interest{};       
        file_to_read >> new_hero.name;
        file_to_read >> new_hero.year;
        file_to_read >> new_hero.weight;
        file_to_read >> new_hero.hair_clr;
        getline(file_to_read, hero_interests);
        istringstream s_s(hero_interests);
        while (s_s >> interest) {
            new_hero.interests.push_back(interest);
        }
        
        Register_Type.push_back(new_hero);
    }

    file_to_read.close();

    // cout << Register_Type[0].interests.at(1);
}

int mainMenu()
{

        int sel;

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

    checkArg(argc, arg[0]);

    if (mainMenu() == 1)
        addHero(arg[1]);
    else if (mainMenu() == 2){
        checkList(arg[1]);
        findMatch();
    }

//     file_to_read.open(arg[1]);
//     s_s << file_to_read.rdbuf();
//     cout << "s_s.str(): " << endl << s_s.str();
//     file_to_read.close();

// cout << endl;

//     file_to_read.open(arg[1]);
//     getline(file_to_read, s);
//     cout << "s:" << endl << s;
//     file_to_read.close();
};