#include <algorithm>
#include <functional>
#include <stdexcept>
#include <iostream>
#include <iterator>
#include <initializer_list>

class is_nth {
	size_t current_;
public:
	is_nth(size_t n) : current_(n) {}

	template<typename... Args>
	bool operator()(Args...) { return !current_--;}
};

template<typename FwdIter>
FwdIter remove_nth(FwdIter begin, FwdIter end, size_t n) {
	size_t distance = std::distance(begin, end);
	if (n >= distance){
		throw std::out_of_range("No nth element to remove");
	}
	std::advance(begin, n);
	if (begin != end) {
		return std::copy(begin+1, end, begin);
	}
	return end;
}

template<typename Cont>
void Print(const Cont& v) {
	std::copy(v.begin(), v.end(), std::ostream_iterator<int>(std::cout, ","));
	std::cout << std::endl;
}

template<typename Iter>
void PrintIter(std::initializer_list<Iter> iters) {
	using value_type = typename Iter::value_type;
	if (iters.size() < 2) {
		throw std::out_of_range("Need two or more iterators");
	} else {
		for (auto i = iters.begin(); i+1 != iters.end(); ++i) {
			std::copy(*i, *(i+1)-1, // eww
					  std::ostream_iterator<value_type>(std::cout,","));
			std::cout << *(*(i+1)-1) << "|"; // eww
		}
		std::cout << std::endl;
	}

}

int main(int argc, char const *argv[])
{
	std::vector<int> v {1,2,3,4,5,6,7};
	Print(v);

	auto v1 = v;
	auto cur_end = remove_nth(v1.begin(), v1.end(), 2);
	PrintIter({v1.begin(), cur_end, v1.end()});
	cur_end = remove_nth(v1.begin(), cur_end, 4);
	PrintIter({v1.begin(), cur_end, v1.end()});
	PrintIter({v1.end(), cur_end, v1.begin()});
	auto v2 = v;
	return 0;
}