#include <string>
#ifndef co3_h
#define co3_h

    struct run_Time{
        int run_Time_M, run_Time_S;
    };

    struct runner_ID {
        std::string runner_F_Name{}, runner_S_Name{}, club_Name{};
        std::vector <run_Time> runner_Times{};
    };

    std::vector <runner_ID> runner_List{};

    

    void Add_Runner();

    void Set_Runner_Time();

    void Print_Highscore();

    void Set_Runner_Time();

    void Rank_Time(int const runner_No, run_Time const time);
        

#endif