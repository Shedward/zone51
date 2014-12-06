#include <iostream>
#include <complex>
#include <vector>
#include <typeinfo>

template<typename LT, typename RT>
auto fun(LT& lhs, RT& rhs) {
    return lhs / (lhs + rhs);
}

template<typename Containaer, typename Index>
auto& authAndAccess(Containaer& c, Index i) {
    return c[i];
}

int main() {
    using namespace std::literals;
    auto a = 2;
    auto b = 3.0;
    auto c = 2.5i + 3.0;
    std::cout << fun(a, b) << std::endl;
    std::cout << fun(b, c) << std::endl;

    int d[] = {1, 2, 3, 4};
    authAndAccess(d, 2) = 10;
    std::cout << d[2] << std::endl;

    std::vector<int> e = {1, 2, 3, 4};
    authAndAccess(e, 2) = 11;
    std::cout << e[2] << std::endl;

    std::cout << typeid(fun(b,c)).name() << std::endl;

    const int f[] = {1, 2, 3, 4};
    // authAndAccess(f, 2) = 12; // Throw a compilation error
    std::cout << f[2] << std::endl;
    return 0;
}
