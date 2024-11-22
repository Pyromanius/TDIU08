#include <string>
#ifndef co3_h
#define co3_h
    
    struct run_Time{
        int min{}, sek{};
    };
    struct runner_ID {
        std::string runner_F_Name{}, runner_S_Name{}, club_Name{};
        std::vector <run_Time> runner_Times{};
    };
    std::vector <runner_ID> runner_List{};
    void Add_Runner();
    void Sort_Time(int const runner_No, run_Time const time);
    bool Is_Time_Exist(int const runner_No, run_Time const time);
    void Add_Runner_Time();
    void Rank_Runners();
    void Print_Highscore();
#endif