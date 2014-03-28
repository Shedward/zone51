#include <iostream>
#include <assert.h>

#include <boost/spirit/include/qi.hpp>
#include <boost/spirit/include/phoenix_core.hpp>
#include <boost/spirit/include/phoenix_operator.hpp>

struct date {
    unsigned short year;
    unsigned short month;
    unsigned short day;
};

date parse_date_time(const std::string& s) {
    using boost::spirit::qi::_1;
    using boost::spirit::qi::ushort_;
    using boost::spirit::qi::char_;
    using boost::phoenix::ref;

    date res;
    auto iter = s.begin();
    bool success = boost::spirit::qi::parse(iter, s.end(),
        ushort_[ref(res.year) = _1] >> char('-') >>
        ushort_[ref(res.month) = _1] >> char('-') >>
        ushort_[ref(res.day) = _1]);

    if (!success || iter != s.end()) {
        throw std::logic_error("Parsing failed");
    }
    return res;
}

int main(int argc, char* argv[]) {
    date d = parse_date_time("2012-12-31");
    std::cout << d.day << "." << d.month << "." << d.year << std::endl;
    return 0;
}

