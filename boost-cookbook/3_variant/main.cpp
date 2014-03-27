#include <iostream>
#include <boost/variant.hpp>
#include <vector>
#include <string>

int main(int argc, char* argv[]) {
    typedef boost::variant<boost::blank,int, const char*, std::string>
            my_varr_t;
    std::vector<my_varr_t> some_values;
    some_values.push_back(10);
    const char* c_str = "Hello there!";
    some_values.push_back(c_str);
    some_values.push_back(std::string("Wow!"));
    std::string& s =
            boost::get<std::string>(some_values.back());
    s += " That's great!\n";
    std::cout << s;
    return 0;
}

