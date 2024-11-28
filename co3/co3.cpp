//Antgu873: Arbetat enskilt

#include <iostream>
#include <iomanip>
#include <vector>
#include <algorithm>
#include "co3.h"

using namespace std;

void Add_Runners(std::vector<Runner_ID_Type> &runner_list)
{
    Runner_ID_Type runner{};

    while (runner.runner_f_name != "KLAR")
    {    
        cin >> runner.runner_f_name;
        if(runner.runner_f_name == "KLAR")
        {
            break;
        }
        cin >> runner.runner_s_name; 
        getline(cin, runner.club_name);
        runner_list.push_back(runner);
    }
    cin.ignore(1000, '\n');
}

bool Is_Time_Exist(int const runner_no, Run_Time_Type const time, std::vector<Runner_ID_Type> const &runner_list)
{

    for (unsigned int i{}; i < runner_list[runner_no].runner_times.size(); i++)
    {
        Run_Time_Type time_to_compare = runner_list[runner_no].runner_times.at(i);

        if ((time.min == time_to_compare.min) && (time.sek == time_to_compare.sek))
        {
            return true;
        }
    }
    return false;
}

void Add_Runners_Times(std::vector<Runner_ID_Type> &runner_list)
{
    Run_Time_Type time{};
    char C{};

    for (auto i = 0u; i < runner_list.size(); ++i)
    {
        cout << "Tider " << runner_list.at(i).runner_f_name << ": ";
        do 
        {
            cin >> time.min >> C >> time.sek; 
            if (time.min == -1)
            {
                break;
            }
            if (!Is_Time_Exist(i, time, runner_list))
            {
                runner_list[i].runner_times.push_back(time);
            }
        }
        while (time.min != -1);
        cin.ignore(1000, '\n');
        sort(runner_list[i].runner_times.begin(), runner_list[i].runner_times.end());
    }
}

void Rank_Runners(std::vector<Runner_ID_Type> &runner_list)
{
    sort(runner_list.begin(), runner_list.end());
}

void Print_Highscore(std::vector<Runner_ID_Type> const &runner_list)
{
    cout << "Efternamn" << "   Förnamn" << "           Klubb" << ":" << " Tider\n"
        << "==========================================" << endl;
    for (auto i = 0u; i < runner_list.size(); ++i)
    {
        cout << right << setw(9) << runner_list.at(i).runner_s_name << " " 
            << setw(9) << runner_list.at(i).runner_f_name << " " 
            << setw(15) << runner_list.at(i).club_name << ":";
        for (auto z = 0u; z < runner_list.at(i).runner_times.size(); ++z)
        {
            cout << " " << runner_list.at(i).runner_times.at(z).min << "."; 
            if (to_string(abs(runner_list.at(i).runner_times.at(z).sek)).length() == 1) 
                cout << "0" << runner_list.at(i).runner_times.at(z).sek;
            else
                cout << runner_list.at(i).runner_times.at(z).sek;
        }
        cout << endl;
    }  
}

bool operator < (Run_Time_Type const &lhs, Run_Time_Type const &rhs)
{
    if ((lhs.min < rhs.min) || (lhs.min == rhs.min && lhs.sek < rhs.sek))
    {
        return true;
    }
    else
    {
        return false; 
    }
}

bool operator < (Runner_ID_Type const &lhs, Runner_ID_Type const &rhs)
{
    if (lhs.runner_times.at(0) < rhs.runner_times.at(0))
    {
        return true;
    }
    else
    {
        return false; 
    }
}

int main()
{
    std::vector <Runner_ID_Type> runner_list{};

    cout << "Mata in deltagare:" << endl;    
    Add_Runners(runner_list);
    Add_Runners_Times(runner_list);

    Rank_Runners(runner_list);
    Print_Highscore(runner_list);  
}