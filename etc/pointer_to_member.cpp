#include <iostream>

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
};

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
	return 0;
}