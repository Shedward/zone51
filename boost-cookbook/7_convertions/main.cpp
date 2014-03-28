#include <algorithm>
#include <array>
#include <assert.h>
#include <iostream>
#include <iterator>
#include <locale>
#include <vector>

#include <boost/lexical_cast.hpp>
#include <boost/numeric/conversion/cast.hpp>

template <typename T, typename ContainerT>
std::vector<T> parse(const ContainerT& cont) {
    using value_type = typename ContainerT::value_type;
    std::vector<T> result;
    auto lex_cast = &boost::lexical_cast<T, value_type>;
    std::transform(cont.begin(), cont.end(),
                   std::back_inserter(result), lex_cast);
    return result;
}

template <typename SourceT, class TargetT>
struct mythow_overflow_handler {
    void operator ()(boost::numeric::range_check_result r) {
        if (r != boost::numeric::cInRange) {
            throw std::logic_error("Not in range!");
        }
    }
};

template <typename TargetT, class SourceT>
TargetT my_numeric_cast(const SourceT& in) {
    using namespace boost;
    using conv_traits = numeric::conversion_traits<TargetT, SourceT>;
    using cast_traits = numeric::numeric_cast_traits<TargetT, SourceT>;
    using converter =
        numeric::converter<TargetT,
                           SourceT,
                           conv_traits,
                           mythow_overflow_handler<SourceT,TargetT>>;
    return converter::convert(in);

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

    std::vector<long> numbers = { 1, 2, 3, -50, 65535, -65535, 1e10 };
    unsigned num;
    for (long n : numbers) {
        try {
            num = boost::numeric_cast<unsigned>(n);
        } catch (const boost::numeric::positive_overflow &e) {
            std::cout << "Pos overflow with " << n << " " << e.what() << std::endl;
        } catch (const boost::numeric::negative_overflow &e) {
            std::cout << "Neg overflow " << n << " " << e.what() << std::endl;
        }
    }

    return 0;
}

