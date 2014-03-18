#include <iostream>
#include <functional>

class TestClass {
public:
	int a;
	int b;
	void print() {
		std::cout << a << ' ' << b;
	}
	void println() {
		std::cout << a << ' ' << b << std::endl;
	}

	void printext(int x) {
		std::cout << a << ' ' <<  b << ' ' << x << std::endl;
	}

	void printilc(int i, long l, char c) {
		std::cout << i << l << c << std::endl;
	}
};

template <typename Class, typename Ret, typename... Args>
std::function<Ret(Class&)> 
mem_fn(Ret (Class::*f)(Args...), Args... args) 
{
	return [=](Class& inst) -> Ret {
		return (inst.*f)(args...);
	};
}

int main(int argc, char const *argv[])
{
	void (TestClass::*print_fn)() = nullptr;
	int TestClass::*mem;

	bool use_ln = true;
	if (use_ln) {
		print_fn = &TestClass::println;
		mem = &TestClass::a;
	} else {
		print_fn = &TestClass::print;
		mem = &TestClass::b;
	}

	TestClass test {1, 5};
	(test.*print_fn)();
	std::cout << test.*mem << std::endl;

	std::cout << "mem_fn test" << std::endl;
	auto f = mem_fn(&TestClass::printext, 12);
	auto f2 = mem_fn(&TestClass::printilc, 10, 200000002l, 'z'); // Need explicit long
	f(test);
	f2(test);
	std::cin.get();
	return 0;
}