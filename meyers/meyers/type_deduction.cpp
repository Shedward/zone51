#include <cstddef>
#include <iostream>

template<typename T, std::size_t N>
constexpr std::size_t arraySize(T (&)[N]) noexcept {
    return N;
}

template<typename T>
void showSize(T val) {
    std::cout << "Size of " << val
              << " " << arraySize(val)
              << std::endl;
}

const char name[] = "J. P. Briggs";
const int keyVals[] = {1, 2, 3, 4, 5};

int main() {
//    showSize(name);
//    showSize(keyVals);
    return 0;
}
