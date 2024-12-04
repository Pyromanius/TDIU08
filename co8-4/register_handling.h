#include "hero_handling.h"

#ifndef register_handling_h
#define register_handling_h

using Register_Type = std::vector<Hero_Type>;

bool is_in_register(Hero_Type const& new_hero, Register_Type const& reg);
void read_hero_register(std::string const reg_name, Register_Type &reg);
void update_register_file(std::string const reg_file_name, Register_Type const& reg);
void register_new_hero(std::string const reg_file_name, Register_Type &reg);
Register_Type match_up_interests(Register_Type const& reg, std::vector<int> const& interests);
void find_hero_matches(std::string const reg_file_name, Register_Type & reg);
void print_hero_list(Register_Type const& reg);
bool operator < (Hero_Type const& lhs, Hero_Type const& rhs);
bool operator == (Hero_Type const& lhs, Hero_Type const& rhs);

#endif