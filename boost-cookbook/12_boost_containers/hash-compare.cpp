#include <string>

#include <boost/functional/hash.hpp>

struct string_hash_fast {
    typedef std::size_t comp_type;

    const comp_type    comparasion_;
    const std::string  str_;

    explicit string_hash_fast(const std::string& s)
        : comparasion_(boost::hash<std::string>()(s)),
          str_(s)
    {}
};

inline bool operator ==(const string_hash_fast& s1,
                        const string_hash_fast& s2) {
    return s1.comparasion_ == s2.comparasion_
            && s1.str_ == s2.str_;
}

inline bool operator !=(const string_hash_fast& s1,
                        const string_hash_fast& s2) {
    return !(s1 == s2);
}

template <typename T>
std::size_t test_default() {
    const std::size_t ii_max = 20000000;
    const std::string s(
                "Long long long string that "
                "will be used in tests io compare "
                "speed of equality comparations.");

    const T data[] = {
        T(s),
        T(s + s),
        T(s + "Whooohooo"),
        T(std::string(""))
    };

    const std::size_t data_dimensions
            = sizeof(data) / sizeof(data[0]);

    std::size_t matches = 0u;
    for (std::size_t ii = 0; ii < ii_max; ++ii) {
        for (std::size_t i = 0; i < data_dimensions; ++i) {
            for (std::size_t j = 0; i < data_dimensions; ++j) {
                if (data[i] == data[j]) {
                    ++matches;
                }
            }
        }
    }

    return matches;
}

int main(int argc, char* argv[])
{
    if (argc < 2) {
        assert(test_default<string_hash_fast>()
               ==
               test_default<std::string>());
        return 0;
    }

    switch (argv[1][0]) {
    case 'h':
        std::cout << "HASH matched: "
                  << test_default<string_hash_fast>();
        break;
    case 's':
        std::cout << "STD matched: "
                  << test_default<std::string>();
        break;
    default:
        assert(false);
        break;
    }
    return 0;
}

