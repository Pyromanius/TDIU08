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
std::vector<int> read_hero_interests(std::string const& interests_s);
bool read_hero_details(std::istream &file_to_read,
                       Hero_Type &new_hero);
bool is_interests_match(Hero_Type const& hero, 
                        std::vector<int> const& entered_interests);
bool operator < (Hero_Type const& lhs, Hero_Type const& rhs);
bool operator == (Hero_Type const& lhs, Hero_Type const& rhs);


#endif