#include <iostream>
#include <boost/any.hpp>
#include <vector>
#include <string>
#include <typeinfo>
#include <algorithm>

typedef boost::variant cell_t;
typedef std::vector<cell_t> db_row_t;

db_row_t get_row(const char* /*query*/) {
    db_row_t row;
    row.push_back(10);
    row.push_back(10.1f);
    row.push_back(std::string("hello again"));
    return row;
}

struct db_sum: public std::unary_function<boost::any, void> {
private:
    double& sum_;
public:
    explicit db_sum(double& sum)
        : sum_(sum)
    {}

    void operator()(const cell_t& value) {
        const auto& ti = value.type();
        if (ti == typeid(int)) {
            sum_ += boost::any_cast<int>(value);
        } else if (ti == typeid(float)) {
            sum_ += boost::any_cast<float>(value);
        }
    }
};

int main(int argc, char* argv[]) {
    db_row_t row = get_row("SELECT *");
    double res = 0.0;
    std::for_each(row.begin(), row.end(), db_sum(res));
    std::cout << "Sum: " << res << std::endl;
    return 0;
}

