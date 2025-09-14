#include <sstream>
#include <string>
#include <iostream>
#include <vector>
#include <algorithm>
#include <fstream>

#include "hero_handling.h"

using namespace std;


bool is_valid_interest(int const interest, 
                       vector<int> const& new_hero_interests)
{
    if (interest < 16 && interest > 0)
    {
        for (int i{}; i < static_cast<int>(new_hero_interests.size()); i++)
        {
            if (interest == new_hero_interests.at(i))
            {
                return false;
            }
        }
        return true;
    }
    else 
    {
        return false;
    }
}

void create_new_hero(Hero_Type &new_hero)
{
    int interest;
    vector<int> interests;

    cout << "Enter hero information:" << endl;
    cin >> new_hero.name >> new_hero.year >> new_hero.weight >> new_hero.hair_clr;
    do
    {
        cin >> interest;
        if (is_valid_interest(interest, new_hero.interests))
        {
            new_hero.interests.push_back(interest);
        }
    } 
    while (cin.get() != '\n' || new_hero.interests.empty());

    sort(begin(new_hero.interests), end(new_hero.interests));
}

vector<int> read_hero_interests(string const& interests_s)
{
    vector<int> interests{};
    int interest{};
    istringstream s_s(interests_s);

    interests.clear();
    while (s_s >> interest)
    {
        interests.push_back(interest);
    } 
    return interests;
}

bool read_hero_details(istream &file_to_read,
                       Hero_Type &new_hero) 
{
    string interests_s{};

    if (!(file_to_read >> new_hero.name >> new_hero.year >> new_hero.weight >> new_hero.hair_clr))
    {
        return false;
    }
    else
    {
        getline(file_to_read, interests_s);
        new_hero.interests = read_hero_interests(interests_s);
        return true;
    }
}

bool is_interests_match(Hero_Type const& hero, 
                        vector<int> const& entered_interests)
{
    for (int i{}; i < static_cast<int>(entered_interests.size()); i++)
    {
        for (int z{}; z < static_cast<int>(hero.interests.size()); z++)
        {
            if (hero.interests.at(z) == entered_interests.at(i))
            {
                return true;
            }
        }
    }
    return false;
}

bool operator < (Hero_Type const& lhs, 
                 Hero_Type const& rhs)
{
    return lhs.name < rhs.name;
}

bool operator == (Hero_Type const& lhs, 
                  Hero_Type const& rhs)
{
    return lhs.name == rhs.name;
}
