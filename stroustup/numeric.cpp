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


	IntVec mat0 = {
		11, 12, 13, 14, 15,
		21, 22, 23, 24, 25,
		31, 32, 33, 34, 35,
	};
	print_mat(mat0, 3, 5);
	IntVec col2 = mat0[std::slice(1,3,5)];
	print(col2);
	IntVec row2 = mat0[std::slice(5,5,1)];
	print(row2);

	IntVec submat0 = mat0[std::gslice(5*1+1, dem{2,3}, dem{5,1})];
	print(submat0);
	print_mat(submat0, 2, 3);

	print(pv);
	std::cout << std::accumulate(std::begin(pv), std::end(pv), 0) << std::endl;
	std::cout << std::inner_product(std::begin(pv), std::end(pv), std::begin(pv),0) << std::endl;

	IntVec sums(pv.size());
	std::partial_sum(std::begin(pv), std::end(pv), std::begin(sums));
	print(sums);


	IntVec diff(pv.size());
	std::adjacent_difference(std::begin(pv), std::end(pv), std::begin(diff));
	print(diff);

	IntVec iota(pv.size());
	std::iota(std::begin(iota)+5, std::end(iota),20);
	print(iota);
	return 0;
}