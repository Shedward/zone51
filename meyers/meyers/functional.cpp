#include <functional>
#include <vector>
#include <initializer_list>
#include <string>
#include <sstream>
#include <iostream>
#include <stack>
#include <assert.h>

struct Book {
    std::string Title;
    std::string Author;
    int Year;
};

namespace Specifications {

template <typename T>
using predicat = std::function<bool(T)>;

template <typename T>
predicat<T> operator&& (predicat<T> lhs, predicat<T> rhs) {
    return [lhs, rhs](const T& b) { return lhs(b) && rhs(b); };
}

template <typename T>
predicat<T> operator|| (predicat<T> lhs, predicat<T> rhs) {
    return [lhs, rhs](const T& b) { return lhs(b) || rhs(b); };
}

template <typename T>
predicat<T> operator! (predicat<T> lhs) {
    return [lhs](const T& b) { return ! lhs(b); };
}

template <typename T>
class Specification {
public:
    using type = T;
    using predicat = std::function<bool(type)>;
};

#define PRED_By(name)\
    static predicat By##name(decltype(type::name) value) {\
        return [value](const type& el) {\
            return el.name == value;\
        };\
    }

class BookSpec : public Specification<Book> {
public:

    PRED_By(Title)
    PRED_By(Author)
    PRED_By(Year)

    static predicat InCentury(int cent) {
        return [cent](const type& el) {
            return (el.Year / 100) - 1 == cent;
        };
    }
};
}

int main() {
    using namespace Specifications;

    auto pureQuery = ! BookSpec::ByTitle("Of Mice and Men") && BookSpec::ByYear(1934);

    std::vector<Book> testBooks = {
        { "Ulysses", "James Joyce", 1934 },
        { "To kill a mockingbird", "Harper Lee",  1960 },
        { "Of Mice and Men", "John Stelnbeck", 1934 }
    };

    for (const auto& b : testBooks) {
        if (pureQuery(b)) {
            std::cout << b.Title << std::endl;
        }
    }
}
