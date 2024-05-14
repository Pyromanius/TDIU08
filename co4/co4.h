#include <string>
#ifndef co4_h
#define co4_h

struct Hero_Type{
    std::string name{}, hair_clr{};
    int year{};
    double weight{};
    std::vector<int> interests{};
};

std::vector <Hero_Type> Register_Type{};

void checkArg(int const num_arguments, std::string const& prog_name);
void registerHero(Hero_Type const new_hero, std::string const reg_name);
bool isValidInterest(std::vector<int> const& interests, int const new_interest);
void sortInterests(std::vector<int> & interests);
bool heroExists(Hero_Type const& new_hero);
void addHero(std::string const reg_name);
void printList(std::vector<Hero_Type> const matches_list);
bool operator == (Hero_Type const& lhs, Hero_Type const& rhs);
std::vector<Hero_Type> searchMatches(int const interest, std::vector<Hero_Type> const& matches);
void findMatch();
void sortListByName();
void updateFile(std::string const reg_name);
void updateList(std::string const reg_name);
int mainMenu(int & sel);


#endif