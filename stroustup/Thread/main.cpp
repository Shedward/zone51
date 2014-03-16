#include <thread>
#include <iostream>
#include <memory>
#include <vector>
#include <algorithm>

int main(int argc, char const *argv[]) {
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
    return 0;
}
