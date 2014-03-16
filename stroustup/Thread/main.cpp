#include <thread>
#include <iostream>
#include <memory>
#include <vector>
#include <algorithm>
#include <mutex>

void thread_test() {
    auto result = std::make_shared<std::vector<int>>();
    std::vector<std::thread> threads;
    for (int i = 0; i < 10; ++i) {
        threads.emplace_back([result]{
            for (int j = 0; j < 20; ++j) {
                std::cout << "Add " << j << " from "
                          << std::this_thread::get_id()
                          << std::endl;
                std::this_thread::sleep_for(std::chrono::microseconds(10));
                result->push_back(j);
            }
        });
    }

    std::for_each(threads.begin(), threads.end(),
                  std::mem_fn(&std::thread::join));

    for (auto val : *result){
        std::cout << val << ' ';
    }
    std::cout << std::endl;
}

void writeln() {
    std::cout << std::endl;
}

std::recursive_mutex cout_mutex;
template<typename Arg, typename... Args>
void writeln(Arg a, Args... tail) {
    cout_mutex.lock();
    std::cout << a;
    writeln(tail...);
    cout_mutex.unlock();
}


int main(int argc, char const *argv[]) {
    //thread_test();
    std::vector<std::thread> threads;
    auto writechln = &writeln<std::string,char,char,char,char,char,char,int>;
    for (int i = 0; i < 10; ++i) {
        threads.emplace_back(writechln, "Hell",'o',' ','w','o','r','l',12);
    }
    std::for_each(threads.begin(), threads.end(),
                  std::mem_fn(&std::thread::join));
    return 0;
}
