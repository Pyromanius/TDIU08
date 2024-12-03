//Antgu873: Arbetat enskilt

#include <iostream>
#include "co3.h"

using namespace std;

int main()
{
    runner_vec runner_list{};

    cout << "Mata in deltagare:" << endl;    
    add_runners(runner_list);
    add_runners_times(runner_list);

    rank_runners(runner_list);
    print_highscore(runner_list);  

    return 0;
}