#include <iostream>
#include <iomanip>
#include <algorithm>
#include "co3.h"

using namespace std;

void add_runners(vector<Runner_ID_Type> &runner_list)
{
    Runner_ID_Type runner{};

    do
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
    while (true);

    cin.ignore(1000, '\n');
}

bool is_time_exist(int const runner_no, 
                    Run_Time_Type const time, 
                    vector<Runner_ID_Type> const &runner_list)
{

    for (unsigned int i{}; i < runner_list.at(runner_no).runner_times.size(); i++)
    {
        Run_Time_Type time_to_compare = runner_list.at(runner_no).runner_times.at(i);

        if ((time.min == time_to_compare.min) && (time.sek == time_to_compare.sek))
        {
            return true;
        }
    }
    return false;
}

void add_runners_times(vector<Runner_ID_Type> &runner_list)
{
    Run_Time_Type time{};
    char C{};

    for (unsigned int i{}; i < runner_list.size(); ++i)
    {
        cout << "Tider " << runner_list.at(i).runner_f_name << ": ";
        do 
        {
            cin >> time.min >> C >> time.sek; 
            if (time.min == -1)
            {
                break;
            }
            if (!is_time_exist(i, time, runner_list))
            {
                runner_list.at(i).runner_times.push_back(time);
            }
        }
        while (time.min != -1);
        cin.ignore(1000, '\n');

        sort(begin(runner_list.at(i).runner_times), end(runner_list.at(i).runner_times));
    }
}

void rank_runners(vector<Runner_ID_Type> &runner_list)
{
    sort(begin(runner_list), end(runner_list));
}

void print_highscore(vector<Runner_ID_Type> const &runner_list)
{
    cout << setfill(' ') << right << "Efternamn" 
        << setw(11) << "Förnamn" 
        << setw(16) << "Klubb" << ":" 
        << setw(7) << "Tider\n"
        << setfill('=') << setw(42) << "=" << endl;
    for (unsigned int i{}; i < runner_list.size(); ++i)
    {
        cout << setfill(' ') << setw(9) << runner_list.at(i).runner_s_name << " " 
            << setw(9) << runner_list.at(i).runner_f_name << " " 
            << setw(15) << runner_list.at(i).club_name << ":";
        for (unsigned int z{}; z < runner_list.at(i).runner_times.size(); ++z)
        {
            cout << " " << runner_list.at(i).runner_times.at(z).min << "."
                << setw(2) << setfill('0') << runner_list.at(i).runner_times.at(z).sek;
        }
        cout << endl;
    }  
}

bool operator < (Run_Time_Type const &lhs, 
                Run_Time_Type const &rhs)
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

bool operator < (Runner_ID_Type const &lhs, 
                Runner_ID_Type const &rhs)
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