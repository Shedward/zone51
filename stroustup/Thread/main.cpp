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
    std::lock_guard<std::recursive_mutex> l(cout_mutex);
    std::cout << a;
    writeln(tail...);
}

class TestClass {
private:
    std::once_flag initialized;
    void Init() { a = 0; b = 9; }
    int a;
    int b;
    int z;
public:
    TestClass(int z) : z(z) {
        std::call_once(initialized,std::mem_fn(&TestClass::Init), this);
    }
    TestClass(TestClass&&) = default;
};


int main(int argc, char const *argv[]) {
    //thread_test();
    std::vector<std::thread> threads;
    auto test_classes = std::make_shared<std::vector<TestClass>>();
    auto writechln = &writeln<std::string,char,char,char,char,char,char,int>;
    for (int i = 0; i < 10; ++i) {
        threads.emplace_back(writechln, "Hell",'o',' ','w','o','r','l',12);
        threads.emplace_back([test_classes] {
            test_classes->emplace_back();
        });
    }
    std::cout << test_classes->size() << std::endl;
    std::for_each(threads.begin(), threads.end(),
                  std::mem_fn(&std::thread::join));
    return 0;
}
