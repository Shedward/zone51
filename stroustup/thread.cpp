#include <thread>
#include <iostream>

int main(int argc, char const *argv[]) {
	int i = 0;
	auto inc_task = [&i]{ for(int j = 0; j < 100; ++i, ++j) ; };
	auto dec_task = [&i]{ for(int j = 0; j < 100; --i, ++j) ; };
	auto print_task = [&i]{ for(int j = 0; j < 100; ++j ) std::cout << i; };

	std::thread one(print_task);
	std::thread two(inc_task);
	std::thread three(dec_task);

	one.join();
	two.join();
	three.join();
	return 0;
}