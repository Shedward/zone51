#include <iostream>
#include <boost/lexical_cast.hpp>
#include <locale>
#include <vector>
#include <algorithm>
#include <assert.h>
#include <array>
#include <iterator>

template <typename T, typename ContainerT>
std::vector<T> parse(const ContainerT& cont) {
    using value_type = typename ContainerT::value_type;
    std::vector<T> result;
    auto lex_cast = &boost::lexical_cast<T, value_type>;
    std::transform(cont.begin(), cont.end(),
                   std::back_inserter(result), lex_cast);
    return result;
}

int main(int argc, char* argv[]) {
    int i = boost::lexical_cast<int>("123");
    assert(i == 123);

    char chars[] = {'1','2','3'};
    int ii = boost::lexical_cast<int>(chars, 3);
    assert(ii == 123);

    try {
        short s = boost::lexical_cast<short>("1000000000000");
        assert(false);
    } catch (const boost::bad_lexical_cast& e) {
        std::cout << "Catched: " << e.what() << std::endl;
    }

    std::locale::global(std::locale("ru_RU.UTF8"));
    float f = boost::lexical_cast<float>("1,0");
    assert(f < 1.01 && f > 0.99);

    std::vector<std::string> strs = {
        "12,2", "19", "12", "0,0", "14",
        "5", "100500", "1e6", "1E7", "1e-2"
    };

    std::vector<double> nums;
    for (const std::string& str : strs) {
        try {
            nums.push_back(boost::lexical_cast<double>(str));
        } catch (const boost::bad_lexical_cast& e) {
            std::cout << "Catched at \"" << str << "\" " << e.what() << std::endl;
        }
    }

    try {
        nums = parse<double>(strs);
    } catch (const boost::bad_lexical_cast& e) {
        std::cout << "Catched: " << e.what() << std::endl;
    }

    std::copy(nums.begin(), nums.end(),
              std::ostream_iterator<double>(std::cout,"\n"));

    return 0;
}

