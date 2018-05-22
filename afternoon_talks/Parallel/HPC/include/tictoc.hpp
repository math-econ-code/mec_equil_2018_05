
/*
 * simple tictoc functionality
 */

using clocktime_t = std::chrono::time_point<std::chrono::system_clock>;
using comptime_t  = std::chrono::duration<double>;

inline
clocktime_t
tic()
{
    return std::chrono::system_clock::now();
}

inline
void
tictoc(clocktime_t time_inp)
{
    clocktime_t time_now = std::chrono::system_clock::now();

    comptime_t run_time = time_now - time_inp;

    //

    std::time_t end_time = std::chrono::system_clock::to_time_t(time_now);
        
    std::cout << "\nfinished computation at " << std::ctime(&end_time)
              << "total runtime: " << run_time.count() << "s\n";
}
