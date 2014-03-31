#include <algorithm>
#include <string>
#include <cstring>

#include <boost/algorithm/string/predicate.hpp>
#include <boost/algorithm/string/compare.hpp>

#include <assert.h>

std::string str1 = "Thanks for reading me!";
std::string str2 = "THanKS FOR reading ME!";

bool is_equals(const std::string& s1, const std::string& s2) {
    return s1.size() == s2.size() &&
            std::equal(s1.begin(), s1.end(), s2.begin(), boost::is_iequal());
}

bool is_equals2(const std::string &s1, const std::string &s2) {
    return s1.size() == s2.size() &&
            std::equal(s1.begin(), s1.end(), s2.begin(), [](char c1, char c2){
        return std::tolower(c1) == std::tolower(c2);
    });
}

int main(int argc, char *argv[]) {
    assert(boost::iequals(str1, str2));
    assert(is_equals(str1, str2));
    assert(is_equals2(str1, str2));
    return 0;
}

