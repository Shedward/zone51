#include <vector>
#include <algorithm>
#include <iterator>

// 1.9.2
template <typename C, typename T>
Iter remove_val(const C &cont, const T &val){
	cont.erase(std::remove(begin, end, val), cont.end());
}

// 1.9.3
template <typename Iter>
Iter remove_nth(Iter begin, Iter end, size_t n){
	assert(std::distance(begin, end) >= n);
	std::advance(begin, n);
	if (first != last){
		Iter dest = first;
		return copy(++first, last, dest);
	}
	return last;
}