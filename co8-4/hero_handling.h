#include <string>
#include <vector>

#ifndef hero_handling_h
#define hero_handling_h

struct Hero_Type{
    std::string name{}, hair_clr{};
    int year{};
    double weight{};
    std::vector<int> interests{};
};

bool is_valid_interest(int const interest, std::vector<int> const& new_hero_interests);
void create_new_hero(Hero_Type &new_hero);

#endif