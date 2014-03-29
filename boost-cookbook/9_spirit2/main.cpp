#include <iostream>
#include <vector>
#include <assert.h>

#include <boost/spirit/include/qi.hpp>
#include <boost/spirit/include/phoenix_core.hpp>
#include <boost/spirit/include/phoenix_operator.hpp>
#include <boost/spirit/include/phoenix_bind.hpp>

struct datetime {
    using value_t = unsigned short;
    enum zone_offsets_t {
        OFFSET_NOT_SET,
        OFFSET_Z,
        OFFSET_UTC_PLUS,
        OFFSET_UTC_MINUS
    };
private:
    value_t year_ = 0;
    value_t month_ = 0;
    value_t day_ = 0;
    value_t hours_ = 0;
    value_t minutes_ = 0;
    value_t seconds_ = 0;
    zone_offsets_t zone_offsets_type_ = OFFSET_NOT_SET;
    unsigned int zone_offset_in_min_ = 0;

    static void dt_assert(bool v, const std::string msg) {
        if (!v) {
            throw std::logic_error("Assertion failed: " + msg);
        }
    }

public:
    datetime() = default;
    void print() {
        std::cout << hours_ << ':' << minutes_ << ':' << seconds_ << ' '
                  << day_ << '.' << month_ << '.' << year_ << ' ';
        switch (zone_offsets_type_) {
        case OFFSET_UTC_MINUS:
            std::cout << '-' << zone_offset_in_min_; break;
        case OFFSET_UTC_PLUS:
            std::cout << '+' << zone_offset_in_min_; break;
        case OFFSET_Z:
            std::cout << 'Z'; break;
        }
        std::cout << std::endl;
    }

    void set_year(value_t y) { year_ = y; }
    void set_month(value_t m) {
        dt_assert(m >= 1 && m <= 12, "Month out of range");
        month_ = m;
    }
    void set_day(value_t d) {
        dt_assert(d >= 1 && d <= 31, "Day out of range");
        day_ = d;
    }
    void set_hours(value_t h) {
        dt_assert(h <= 24, "Hours out of range");
        hours_ = h;
    }
    void set_minutes(value_t m) {
        dt_assert(m < 60, "Minutes out of range");
        minutes_ = m;
    }
    void set_seconds(value_t s) {
        dt_assert(s < 60, "Seconds out of range");
        seconds_ = s;
    }

    void set_zone_offset(char sign, value_t hours, value_t minutes) {
        zone_offsets_type_ = sign == '+' ? OFFSET_UTC_PLUS : OFFSET_UTC_MINUS;
        zone_offset_in_min_ = hours * 60 + minutes;
    }

    void set_zero_offset() {
        zone_offsets_type_ = OFFSET_Z;
        zone_offset_in_min_ = 0;
    }
};

datetime parse_datetime(const std::string& s) {
    using boost::spirit::qi::_1;
    using boost::spirit::qi::_2;
    using boost::spirit::qi::_3;
    using boost::spirit::qi::uint_parser;
    using boost::spirit::qi::char_;
    using boost::phoenix::bind;
    using boost::phoenix::ref;

    datetime ret;

    uint_parser<datetime::value_t, 10, 2, 2> u2_;
    uint_parser<datetime::value_t, 10, 4, 4> u4_;

    auto timezone_r =
        (char_('Z')[bind(&datetime::set_zero_offset, &ret)])
            |
        ((char_('+') | char_('-')) >> u2_ >> ':' >> u2_)
        [bind(&datetime::set_zone_offset, &ret, _1, _2, _3)];

    auto date_r =
        u4_[bind(&datetime::set_year,  &ret, _1)] >> '-' >>
        u2_[bind(&datetime::set_month, &ret, _1)] >> '-' >>
        u2_[bind(&datetime::set_day,   &ret, _1)];

    auto time_r =
        u2_[bind(&datetime::set_hours,   &ret, _1)] >> ':' >>
        u2_[bind(&datetime::set_minutes, &ret, _1)] >> ':' >>
        u2_[bind(&datetime::set_seconds, &ret, _1)];

    auto datetime_r =
            ((date_r >> 'T' >> time_r) | date_r | time_r)
            >> -timezone_r;

    auto iter = s.begin();

    bool success = parse(iter, s.end(), datetime_r);

    if (!success || iter != s.end()) {
        throw std::logic_error("Parssing of \"" + s + "\" failed");
    }
    return ret;
}

int main(int argc, char* argv[]) {
    datetime d;
    d.print();
    std::vector<std::string> strs = {
        "2012-10-20T10:00:00Z",
        "2012-10-20T10:00:00Z",
        "2012-10-20T10:00:00+09:15",
        "2012-10-20-09:15",
        "10:00:09+09:15"
    };

    for (const auto& str : strs) {
        try {
            parse_datetime(str).print();
        } catch (const std::logic_error& e) {
            std::cout << "Failed to parse: " << str << std::endl;
        }
    }

}

