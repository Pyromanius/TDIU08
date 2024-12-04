#include <string>
#include <vector>
#ifndef co3_h
#define co3_h
    
    struct Run_Time_Type{
        int min{}, sek{};
    };
    struct Runner_ID_Type { 
        std::string runner_f_name{}, runner_s_name{}, club_name{};
        std::vector <Run_Time_Type> runner_times{};
    };

    using runner_vec = std::vector <Runner_ID_Type>;

    void add_runners(std::vector<Runner_ID_Type> &runner_list);
    bool is_time_exist(int const runner_no, 
                        Run_Time_Type const time, 
                        std::vector<Runner_ID_Type> const &runner_list);
    void add_runners_times(std::vector<Runner_ID_Type> &runner_list);
    void rank_runners(std::vector<Runner_ID_Type> &runner_list);
    void print_highscore(std::vector<Runner_ID_Type> const &runner_list);
    bool operator < (Run_Time_Type const &lhs, 
                    Run_Time_Type const &rhs);
    bool operator < (Runner_ID_Type const &lhs, 
                    Runner_ID_Type const &rhs);

#endif