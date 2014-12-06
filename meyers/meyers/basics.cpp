#include <iostream>
#include <functional>
#include <vector>

auto fun(int x) {
    return  x;
}

auto add_one(std::vector<int> &v) {
    for (auto& it : v) {
        it += 1;
    }
    return v;
}

using namespace std;

template<typename Func, typename... Args>
void doNTimes(int n, Func&& f, Args&&... args) {
    for (int i = 0; i < n; ++i) {
        f(args...);
    }
}

template<typename Func, typename...Args>
void doNTimes2(int n, Func &&f, Args&&... args) {
    for (int i = 0; i < n; ++i) {
        f(i, args...);
    }
}

int main()
{
    doNTimes(5, [](){
        std::cout << "Hello world!\n";
    });

    auto action = [](int i) { printf("Return \n"); };

    doNTimes(5, std::bind(action, 2));

    doNTimes2(5, [](int i, std::string msg){
        std::cout << "It's " << i << " : " << msg << std::endl;
    }, "Hello world");

    return 0;
}

