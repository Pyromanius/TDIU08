//Antgu873: Arbetat enskilt

#include <iostream>
#include <iomanip>
#include <vector>
#include <algorithm>
#include "co3.h"

using namespace std;

void Auto_Add_Runners()
{
        runner_ID activeRunner, runner1, runner2, runner3, runner4;
        runner1.runner_F_Name = "John";
        runner1.runner_S_Name = "Doe";
        runner1.club_Name = "Running Club";
        runner2.runner_F_Name = "Jake";
        runner2.runner_S_Name = "Dogface";
        runner2.club_Name = "Proper LC";
        runner3.runner_F_Name = "RunFast";
        runner3.runner_S_Name = "OnWinds";
        runner3.club_Name = "RunnyFast";
        runner4.runner_F_Name = "Martin";
        runner4.runner_S_Name = "Seafarer";
        runner4.club_Name = "Hoppetihopp";
        std::vector<runner_ID> tempList = {runner1, runner2, runner3, runner4};
        int noRunners;
    cout << "How many runners would you like? (Max 4): ";
    cin >> noRunners;    
    for (int i{}; i < noRunners; ++i)
    {    
        activeRunner = tempList.at(i);
        runner_List.push_back(activeRunner);
    }
}

void Add_Runner()
{
        runner_ID runner;
    while (runner.runner_F_Name != "KLAR")
    {    
        cin >> runner.runner_F_Name;
        if(runner.runner_F_Name == "KLAR")
        {
            break;
        }
        cin >> runner.runner_S_Name; 
        getline(cin, runner.club_Name);
        runner_List.push_back(runner);
    }
}

bool Rank_Time(int const runner_No, run_Time const time, int const position)
{
    if (time.min < runner_List[runner_No].runner_Times.at(position).min)
    {
        return true;
    }
    else if (time.min == runner_List[runner_No].runner_Times.at(position).min)
    {
        if (time.sek < runner_List[runner_No].runner_Times.at(position).sek)
        {
            return true;
        }
    }
    return false;
}

void Sort_Time(int const runner_No, run_Time const time)
{
        run_Time tmpTime = time;
        int length = runner_List[runner_No].runner_Times.size();
    for (int z = 0; z < length - 1; ++z)
    {
        for (int i = z + 1; i < length; ++i)
        {
            if ((runner_List[runner_No].runner_Times[z].min > runner_List[runner_No].runner_Times[i].min) || ((runner_List[runner_No].runner_Times[z].min == runner_List[runner_No].runner_Times[i].min) && (runner_List[runner_No].runner_Times[z].sek > runner_List[runner_No].runner_Times[i].sek)))
            {
                tmpTime.min = runner_List[runner_No].runner_Times[z].min;
                tmpTime.sek = runner_List[runner_No].runner_Times[z].sek;

                runner_List[runner_No].runner_Times[z].min = runner_List[runner_No].runner_Times[i].min;
                runner_List[runner_No].runner_Times[z].sek = runner_List[runner_No].runner_Times[i].sek;

                runner_List[runner_No].runner_Times[i].min = tmpTime.min;
                runner_List[runner_No].runner_Times[i].sek = tmpTime.sek;
            }
        }
    }
}

bool Is_Time_Exist(int const runner_No, run_Time const time)
{
    for (unsigned int i{}; i < runner_List[runner_No].runner_Times.size(); i++)
    {
        if ((time.min == runner_List[runner_No].runner_Times.at(i).min) && (time.sek == runner_List[runner_No].runner_Times.at(i).sek))
        {
            return true;
        }
    }
    return false;
}

void Add_Runner_Time()
{
        run_Time time{};
        char C{};

    for (auto i = 0u; i < runner_List.size(); ++i)
    {
        cout << "Tider " << runner_List[i].runner_F_Name << ": ";
        do 
        {
            cin >> time.min >> C >> time.sek; 
            if (time.min == -1)
            {
                break;
            }
            if (not Is_Time_Exist(i, time))
            {
                runner_List[i].runner_Times.push_back(time);
                Sort_Time(i, time);
            }
        }
        while (true);
    }
}

void Rank_Runners()
{
        runner_ID tmpRunner;
        int length = runner_List.size();
    for (int z = 0; z < length - 1; ++z)
    {
        for (int i = z + 1; i < length; ++i)
        {
            if (runner_List[z].runner_Times[0].min > runner_List[i].runner_Times[0].min)
            {
                tmpRunner = runner_List[z];
                runner_List[z] = runner_List[i];
                runner_List[i] = tmpRunner;
            }
        }
    }
}

void Print_Highscore()
{
    cout << "Efternamn" << "   Förnamn" << "           Klubb" << ":" << " Tider\n"
        << "==========================================" << endl;
    for (auto i = 0u; i < runner_List.size(); ++i)
    {
        cout << right << setw(9) << runner_List[i].runner_S_Name << " " << setw(9) << runner_List[i].runner_F_Name << " " << setw(15) << runner_List[i].club_Name << ":";
        for (auto z = 0u; z < runner_List[i].runner_Times.size(); ++z)
        {
            cout << " " << runner_List[i].runner_Times[z].min << "."; 
            if (to_string(abs(runner_List[i].runner_Times[z].sek)).length() == 1) 
                cout << "0" << runner_List[i].runner_Times[z].sek;
            else
                cout << runner_List[i].runner_Times[z].sek;
        }
        cout << endl;
    }  
}

int main()
{
    cout << "Mata in deltagare:" << endl;
        Auto_Add_Runners();
    //    Auto_Add_Times();
    // Add_Runner();
    Add_Runner_Time();
    Rank_Runners();
    
    Print_Highscore();  
}