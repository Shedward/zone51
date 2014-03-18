#include <iostream>
#include <functional>

template<typename... Args>
void PrintLn(Args... args);

template<typename T, typename... Args>
void PrintLn(T val, Args... args){
	std::cout << val << " ";
	PrintLn(args...);
}

template<>
void PrintLn() {
	std::cout << std::endl;
}

int main(int argc, char const *argv[])
{
	PrintLn(1, 2, 3, 4, 5);
	PrintLn("Hello", 'c', 'r', 'u', 'e', 1.1, "world");

	using namespace std::placeholders;
	void(*fun)(int,int,int) = PrintLn;
	fun(1,2,3);
	auto nuf = std::bind(fun,_3,_2,_1);
	nuf(1,2,3);
	return 0;
}