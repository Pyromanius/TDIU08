#include <iostream>
#include <fstream>
#include <sstream>
#include <iomanip>
#include <vector>
#include <string>
#include <algorithm>

#include "co4.h"

using namespace std;

void checkArg(int const num_arguments, string const& prog_name){
    if (num_arguments != 2)
    {
        cout << "Incorrect number of arguments!" << endl
            << "Usage: " << prog_name << " REGISTERFILE";
            exit(0);
    }
}

void registerHero(Hero_Type const new_hero, string const reg_name){
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

bool isValidInterest(vector<int> const& interests, int const new_interest){
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

void sortInterests(vector<int> & interests){
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

bool heroExists(Hero_Type const& new_hero){
    for (int i{}; i < static_cast<int>(Register_Type.size()); ++i){
        if (new_hero == Register_Type.at(i))
            return true;
        else
            continue;
    }
    return false;
}

void addHero(string const reg_name){
        Hero_Type new_hero;
        int interest;
        string interests_s;
        istringstream iss(interests_s);

    cout << "Enter hero information: " << endl;
    cin >> new_hero.name >> new_hero.year >> new_hero.weight >> new_hero.hair_clr;

    cin >> interest;
    if (isValidInterest(new_hero.interests, interest))
        new_hero.interests.push_back(interest);

    while ((cin >> interest && cin.get() != '\n') || new_hero.interests.empty()){
        if (isValidInterest(new_hero.interests, interest))
            new_hero.interests.push_back(interest);
    } 
        if (isValidInterest(new_hero.interests, interest))
            new_hero.interests.push_back(interest);

    sortInterests(new_hero.interests);

    if (!heroExists(new_hero))
        registerHero(new_hero, reg_name);
}

void printMatches(vector<Hero_Type> const matches_list){
    cout << left << setw(11) << "Hero name" 
        << left << setw(12) << "Birth year" 
        << left << setw(8) <<  "Weight" 
        << left << setw(12) << "Hair color"  
        << left << "Interests" << endl
        << setfill('=') << setw(52) << "=" << endl << setfill(' ');
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
}

bool operator == (Hero_Type const& lhs, Hero_Type const& rhs){
    if (lhs.name == rhs.name && lhs.year == rhs.year && lhs.weight == rhs.weight && lhs.hair_clr == rhs.hair_clr)
        return true;
    else
        return false;
}

vector<Hero_Type> searchMatches(int const interest, vector<Hero_Type> const& matches){
        vector<Hero_Type> new_matches_list{};
        Hero_Type new_match;

    for (int i{}; i < static_cast<int>(Register_Type.size()); ++i){
        
        if (find(Register_Type[i].interests.begin(), Register_Type[i].interests.end(), interest) != Register_Type[i].interests.end()){
            new_match = Register_Type[i];
            if (find(matches.begin(), matches.end(), new_match) != matches.end())
                continue;
            else
                new_matches_list.push_back(new_match); 
        }
    }
    return new_matches_list;
    
}

void findMatch(){
        int interest;
        vector<Hero_Type> matches{};

    cout << "Enter your interests (at least one between 1 and 15): ";
    cin >> interest;

        vector<Hero_Type> tmp_matches = searchMatches(interest, matches);

    matches.insert(matches.end(), tmp_matches.begin(), tmp_matches.end());

    while (cin.get() != '\n' && cin >> interest){
        vector<Hero_Type> tmp_matches = searchMatches(interest, matches);
        matches.insert(matches.end(), tmp_matches.begin(), tmp_matches.end());
    } 
    printMatches(matches);
}

void sortListByName(){
        Hero_Type tmp_hero;

    for (int z = 0; z < static_cast<int>(Register_Type.size()) - 1; ++z){
        for (int i = z + 1; i < static_cast<int>(Register_Type.size()); ++i){
            if (Register_Type[z].name > Register_Type[i].name){
                tmp_hero = Register_Type[z];
                Register_Type[z] = Register_Type[i];
                Register_Type[i] = tmp_hero;
            }
        }
    }
}

void updateFile(string const reg_name){
        fstream reg_file;
        string last_line;

    reg_file.open(reg_name, ios::out);

    for (int i{}; i < static_cast<int>(Register_Type.size()); ++i){
        reg_file << left << setw(11) << Register_Type[i].name
            << left << setw(12) << Register_Type[i].year
            << left << setw(8) << Register_Type[i].weight
            << left << setw(14) << Register_Type[i].hair_clr;
            for (int z{}; z < static_cast<int>(Register_Type[i].interests.size()); ++z)
            {
                reg_file << left << setw(4) << Register_Type[i].interests.at(z);
            }
        reg_file << endl;
    }

    reg_file.close(); 

}

void updateList(string const reg_name){
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
        
        if (!heroExists(new_hero) && !new_hero.name.empty())
            Register_Type.push_back(new_hero);
    }

    file_to_read.close();
    sortListByName();
    updateFile(reg_name);
    // printMatches(Register_Type);
}

int mainMenu(int & sel){
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

int main(int argc, char* arg[]){
        int sel;

    checkArg(argc, arg[0]);
    updateList(arg[1]);

    while (mainMenu(sel) != 3){
        if (sel == 1)
            addHero(arg[1]);
        else if (sel == 2){
            findMatch();
        }
        else if (sel == 3){
            cout << "Terminating Hero Matchmaker 3000!";
            return 0;
        }
}
};