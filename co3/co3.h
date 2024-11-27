#include <string>
#ifndef co3_h
#define co3_h
    
    struct Run_Time_Type{
        int min{}, sek{};
    };
    struct Runner_ID_Type { 
        std::string runner_f_name{}, runner_s_name{}, club_name{};
        std::vector <Run_Time_Type> runner_times{};
    };

    void Add_Runner(Runner_ID_Type &runner, std::vector<Runner_ID_Type> &runner_list);
    void Insert_Time(int const runner_no, Run_Time_Type const time, std::vector<Runner_ID_Type> &runner_list, int const z, int const i);
    void Sort_Time(int const runner_No, Run_Time_Type const time, std::vector<Runner_ID_Type> &runner_list);
    bool Is_Time_Exist(int const runner_No, Run_Time_Type const time, std::vector<Runner_ID_Type> const &runner_list);
    void Add_Runner_Time(std::vector<Runner_ID_Type> &runner_list);
    void Rank_Runners(std::vector<Runner_ID_Type> &runner_list);
    void Print_Highscore(std::vector<Runner_ID_Type> const &runner_list);
#endif