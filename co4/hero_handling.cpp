#include <sstream>
#include <string>
#include <iostream>
#include <vector>
#include <algorithm>

#include "hero_handling.h"

using namespace std;


bool is_valid_interest(int const interest, vector<int> const& new_hero_interests)
{
        if (interest < 16 && interest > 0)
        {
            for (int i{}; i < static_cast<int>(new_hero_interests.size()); i++)
            {
                if (interest == new_hero_interests.at(i))
                {
                    return false;
                }
                else
                {
                    continue;
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

    cout << "Enter hero information: " << endl;
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
