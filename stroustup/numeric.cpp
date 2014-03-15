#include <valarray>
#include <algorithm>
#include <iterator>
#include <iostream>

template<typename T>
void print(const T& arr) {
	std::cout << "{ ";
	for (const auto& val : arr) {
		std::cout.width(4);
		std::cout << val << ' ';
	}
	std::cout << "}" << std::endl;
}

template<typename T>
void print_mat(const T& mat, size_t rows, size_t cols) {
	for (int r = 0; r < rows; ++r) {
		std::cout << "[";
		for (int c = 0; c < cols; ++c) {
			std::cout.width(4);
			std::cout << mat[r*cols + c] << ' ';
		}
		std::cout << "]\n";
	}
}

int main(int argc, char const *argv[])
{
	using IntVec = std::valarray<int>;
	using dem = std::valarray<size_t>;
	using mask = std::valarray<bool>;

	IntVec pv(20);
	std::generate(std::begin(pv), std::end(pv), []{
		static int i = 0;
		return ++i;
	});

	IntVec mv = -pv;
	print(mv);

	IntVec res1 = 0x2252 % (mv*mv + abs(pv));
	print(res1);

	res1[std::slice(0,res1.size(),2)] -= pv;
	print(res1);

	auto res2 = pv;
	res2[std::gslice(0,dem{2,3},dem{7,2})] = 0;
	print(res2);

	IntVec res3 = pv.apply([](int i){ static int j = 0; return i - (j+=3); });
	print(res3);

	IntVec res4 = pv[mask{0,0,0,1,1,1,0,0,1}];
	print(res4);

	return 0; 
}