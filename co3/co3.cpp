#include <iostream>
#include <iomanip>
#include <vector>
#include <algorithm>
#include "co3.h"

using namespace std;

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

// void Insert_Time(run_Time time, int rem_Length)
// {
//     for (int i; i < rem_Length; ++i)
//     {
//         runner_List[i].runner_Times.push_back(runner_List[i].runner_Times[z-1]);
//         runner_List[i].runner_Times.at(z-1) = time;
//     }
// }

void Set_Runner_Time()
{

        runner_ID runner;
        run_Time time;
        int min, sek, length;
        char C;

    for (int i{}; i < runner_List.size(); ++i)
    {
        cout << "Tider " << runner_List[i].runner_F_Name << ": ";
        runner.runner_Times = {};
        // z = 0;
        do 
        {
            cin >> min; 
            if (min == -1)
            {
                break;
            }
            cin >> C;
            cin >> sek;

            if (runner_List[i].runner_Times.empty())
            {
                time.run_Time_M = min;
                time.run_Time_S = sek;
                runner_List[i].runner_Times.push_back(time);
            }

            else
            {
                length = runner_List[i].runner_Times.size();
                time.run_Time_M = min;
                time.run_Time_S = sek;
            
                for (int z{}; z < length; ++z)
                {
                    if (min < runner_List[i].runner_Times[z].run_Time_M)
                    {

                        for (int x{}; x < length - z; ++x)
                        {

                            cout << setw(8) << "z: " << runner_List[i].runner_Times[z].run_Time_M << endl
                                << setw(8) << "z + x: " << runner_List[i].runner_Times[z+x].run_Time_M << endl
                                << "length: " << length << endl;
                                //if runner_List[i].runner_Times.end() = 
                       
                            runner_List[i].runner_Times.at(length - z + x) = runner_List[i].runner_Times.at(z);
                            runner_List[i].runner_Times.at(z) = time;

                        }

                        
                        // runner_List[i].runner_Times.push_back(runner_List[i].runner_Times[z-1];
                        // runner_List[i].runner_Times.at(z) = time;

                    }
                    else if (min == runner_List[i].runner_Times[z].run_Time_M)
                    {

                    }
                }
            }

            // else
            // {
            //     if (min > runner_List[i].runner_Times[z-1].run_Time_M)
            //     {
            //         time.run_Time_M = min;
            //         time.run_Time_S = sek;
            //         runner_List[i].runner_Times.push_back(time);
            //     }
            //     else if (min == runner_List[i].runner_Times[z-1].run_Time_M)
            //     {
            //         if (sek < runner_List[i].runner_Times[z-1].run_Time_S)
            //         {
            //             time.run_Time_M = min;
            //             time.run_Time_S = sek;
            //             runner_List[i].runner_Times.push_back(runner_List[i].runner_Times[z-1]);
            //             runner_List[i].runner_Times.at(z-1) = time;
            //         }
            //         else
            //         {
            //             time.run_Time_M = min;
            //             time.run_Time_S = sek;
            //             runner_List[i].runner_Times.push_back(time);
            //         }
            //     }
            //     else
            //     {
            //         time.run_Time_M = min;
            //         time.run_Time_S = sek;
            //         runner_List[i].runner_Times.push_back(runner_List[i].runner_Times[z-1]);
            //         runner_List[i].runner_Times.at(z-1) = time;
            //     }
            // }
            //    ++z;
                
        }
        while (min != -1);
    }
}

void Rank_Runners(runner_ID runner, int &i)
{

        // runner_ID runner;

        for (int z{}; z < runner.runner_Times.size(); ++z)
        {
            if (runner_List[i+1].runner_Times.size() < z)
            {
                return;
            }

            if (runner.runner_Times[z].run_Time_M < runner_List[i+1].runner_Times[z].run_Time_M)
            {
                runner_List.at(i) = runner_List.at(i+1);
                runner_List.at(i+1) = runner;

                cout << "Passed here" << endl;
                return;
            }

        }

    
}

int main()

{

    cout << "Mata in deltagare:" << endl;
    Add_Runner();
    Set_Runner_Time();
    // for (int i{}; i < runner_List.size(); ++i)
    // {
    //     // runner = runner_List[i];
    //     Rank_Runners(runner_List[i], i);

    // }

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