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

void Rank_Time(int runner_No, run_Time const& time)
{

        vector<run_Time>::iterator position;
        int length = runner_List[runner_No].runner_Times.size();

    for (int i{}; i < length + 1; ++i)
    {
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

    for (int i{}; i < runner_List.size(); ++i)
    {
        runner_No = i;
        cout << "Tider " << runner_List[i].runner_F_Name << ": ";
        do 
        {
            cin >> min; 
            if (min == -1)
            {
                break;
            }
            cin >> C;
            cin >> sek;

            time.run_Time_M = min;
            time.run_Time_S = sek;

            Rank_Time(runner_No, time);     
        }
        while (min != -1);
    }
}

void Print_Highscore()
{
    cout << "Efternamn" << "   Förnamn" << "           Klubb" << ":" << " Tider" << endl
        << "==========================================" << endl;

    for (int i{}; i < runner_List.size(); ++i)
    {
        cout << right << setw(9) << runner_List[i].runner_F_Name << " " << setw(9) << runner_List[i].runner_S_Name << " " << setw(15) << runner_List[i].club_Name << ": ";
        
        for (int z{}; z < runner_List[i].runner_Times.size(); ++z)
        {
            cout << runner_List[i].runner_Times[z].run_Time_M << "." << runner_List[i].runner_Times[z].run_Time_S << " ";
        }
        cout << endl;
    }  
}

int main()
{

    cout << "Mata in deltagare:" << endl;
    Add_Runner();
    // Auto_Add_Runners();
    Set_Runner_Time();
    Print_Highscore();
    
}