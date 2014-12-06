#include <tuple>
#include <string>
#include <iostream>
#include <vector>

using Info =
    std::tuple<std::string, std::string, std::size_t>;
using Task = void (*)();

template<typename... Args>
using Consumer = void (*)(Args...);

enum InfoField : int {
    Name, Address, Id
};

template <typename Collection, typename... Args>
void consume(Collection c, Consumer<Args...> fun) {
    for (auto it : c) {
        fun(it);
    }
}

int main() {
    Info x = std::make_tuple("Adam", "New York", 4);
    std::cout << std::get<Name>(x) << std::endl;

    Task z = []() {
      std::cout << "Hello world" << std::endl;
    };

    z();

    Consumer<int> f = [](int x) {
      std::cout << "Consumed: " << x << std::endl;
    };

    std::vector<float> vec = {1.0, 2, 3, 4};
    consume(vec, Consumer<float>([](float x) {
        std::cout << "Hello " << x << std::endl;
    }));
}
