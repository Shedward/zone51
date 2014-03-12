#include <array>
#include <algorithm>
#include <functional>
#include <bitset>
#include <iostream>
#include <iterator>
#include <utility>

template<typename Cont>
void print(const Cont &cont) {
	std::ostream_iterator<decltype(*cont.begin())> out_iter(std::cout, ", ");
	std::cout << "{";
	std::copy(cont.begin(), cont.end()-1, out_iter);
	std::cout << *(cont.end()-1) << "}";
}

template<typename T, T Begin = T{0}, T Step = T{1}>
class count {
public:
	count() : curr_{Begin} {}
	T operator()() { return curr_++; }
private:
	T curr_;
};

int main(int argc, char const *argv[])
{
	std::array<short, 10> arr;
	std::generate(arr.begin(), arr.end(), count<short,1>());
	print(arr);

	std::bitset<32> thousand("01000010010101000101010001011111010000110");
	std::cout << "\n" << thousand;
	std::cout << "\n" << thousand.flip();
	std::cout << "\n" << thousand.to_string('+','-');
	thousand.flip();
	std::cout << "\n" << thousand.to_string('+','-');
	std::cout << "\n" << std::hash<decltype(thousand)>()(thousand);
	thousand.set(3,false);
	std::cout << "\n" << std::hash<decltype(thousand)>()(thousand);

	auto t = std::make_tuple(2.1828, "Experimental", 25l, std::make_tuple(1, 2, 3));
	float fl;
	std::string str;
	long ln;
	std::tuple<int,int,int> tup;

	std::tie(fl,str,std::ignore,tup) = t;
	std::cout << '\n' << fl << ' ' << str << ' ' << std::get<2>(tup);
	return 0;
}