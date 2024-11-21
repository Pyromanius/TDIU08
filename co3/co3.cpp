//Antgu873: Arbetat enskilt

#include <iostream>
#include <iomanip>
#include <vector>
#include <algorithm>
#include "co3.h"

using namespace std;

// void Auto_Add_Times()
// {
//         run_Time tmpTime = {};
//         int noTimes;
//     cout << "How many runtimes would you like?: ";
//     cin >> noTimes;
//     for (auto i = 0u; i < runner_List.size(); ++i)
//     {
//         for (int z{}; z < noTimes; ++z)
//         {
//             tmpTime.run_Time_M = 10 - i + z;
//             tmpTime.run_Time_S = 25 - i + z;
//             runner_List[i].runner_Times.push_back(tmpTime);
//             // Rank_Time(i, tmpTime);
//         }
//     }
// }

// void Auto_Add_Runners()
// {
//         runner_ID activeRunner, runner1, runner2, runner3, runner4;
//         runner1.runner_F_Name = "John";
//         runner1.runner_S_Name = "Doe";
//         runner1.club_Name = "Running Club";
//         runner2.runner_F_Name = "Jake";
//         runner2.runner_S_Name = "Dogface";
//         runner2.club_Name = "Proper LC";
//         runner3.runner_F_Name = "RunFast";
//         runner3.runner_S_Name = "OnWinds";
//         runner3.club_Name = "RunnyFast";
//         runner4.runner_F_Name = "Martin";
//         runner4.runner_S_Name = "Seafarer";
//         runner4.club_Name = "Hoppetihopp";
//         std::vector<runner_ID> tempList = {runner1, runner2, runner3, runner4};
//         int noRunners;
//     cout << "How many runners would you like? (Max 4): ";
//     cin >> noRunners;    
//     for (int i{}; i < noRunners; ++i)
//     {    
//         activeRunner = tempList.at(i);
//         runner_List.push_back(activeRunner);
//     }
// }

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

void Rank_Time(int const runner_No, run_Time const time)
{
        vector<run_Time>::iterator position;
        unsigned int length = runner_List[runner_No].runner_Times.size();
    for (auto i = 0u; i < length + 1; ++i)
    {
        if (time.run_Time_M == -1)
            break;
        if (i == runner_List[runner_No].runner_Times.size())
        {
            runner_List[runner_No].runner_Times.push_back(time);
        }
        else
        {
            if (time.run_Time_M > runner_List[runner_No].runner_Times.at(i).run_Time_M)
            {
                continue;
            }
            else if (time.run_Time_M < runner_List[runner_No].runner_Times.at(i).run_Time_M)
            {
                position = runner_List[runner_No].runner_Times.begin() + i;
                runner_List[runner_No].runner_Times.insert(position, time);
                break;
            }
        }
    }
}

void Set_Runner_Time()
{
        run_Time time;
        int min, sek, runner_No;
        char C;
    for (auto i = 0u; i < runner_List.size(); ++i)
    {
        runner_No = i;
        cout << "Tider " << runner_List[i].runner_F_Name << ": ";
        do 
        {
            cin >> min; 
            cin >> C;
            cin >> sek;
            time.run_Time_M = min;
            time.run_Time_S = sek;
            Rank_Time(runner_No, time);
        }
        while (min != -1);
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
            if (runner_List[z].runner_Times[0].run_Time_M > runner_List[i].runner_Times[0].run_Time_M)
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
            cout << " " << runner_List[i].runner_Times[z].run_Time_M << "."; 
            if (to_string(abs(runner_List[i].runner_Times[z].run_Time_S)).length() == 1) 
                cout << "0" << runner_List[i].runner_Times[z].run_Time_S;
            else
                cout << runner_List[i].runner_Times[z].run_Time_S;
        }
        cout << endl;
    }  
}

int main()
{
    cout << "Mata in deltagare:" << endl;
        // Auto_Add_Runners();
        // Auto_Add_Times();
    Add_Runner();
    Set_Runner_Time();
    Rank_Runners();
    Print_Highscore();  
}