#include <iostream>
#include <chrono>

int main(int argc, char const *argv[])
{
	using namespace std::chrono;
	auto t = steady_clock::now();
	int total = 0;
	for (int i = 0; i < 300000000; ++i) { total *= 2;};
	auto d = steady_clock::now() - t;

	using fseconds = duration<float>;
	std::cout << duration_cast<fseconds>(d).count() << std::endl;

	std::cout << (high_resolution_clock::is_steady ? "is steady" : "not steady") << std::endl;
	auto t2 = high_resolution_clock::now();
	auto d2 = high_resolution_clock::now() - t2;
	std::cout << duration_cast<nanoseconds>(d2).count() << std::endl;
	return 0;
}