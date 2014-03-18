#include <locale>
#include <iostream>
#include <ios>
#include <chrono>

class one_piece;

class MyPunct : public std::numpunct<char> {
public:
	explicit MyPunct(size_t r = 0) : std::numpunct<char>(r) {}
protected:
	char do_decimal_point() const override { return '|'; }
	char do_thousands_sep() const override { return '\''; }
	std::string do_grouping() const override { return "\005"; }
	std::string do_truename() const override { return "yes"; }
	std::string do_falsename() const override { return "no"; }
};

int main(int argc, char const *argv[])
{
	auto l0 = std::locale{};
	auto l1 = std::locale{"en_US.UTF-8"};
	auto l2 = std::locale{"ru_RU.UTF-8"};
	std::cout << l0.name() << std::endl
			  << l1.name() << std::endl
			  << l2.name() << std::endl;

	auto pritn_test = []{
		long ln = 123456789;
		double d = 123456789.987654;
		std::cout << std::cout.getloc().name() << ": \n"
				  << "\t" << ln << '\n'
				  << "\t" << std::fixed << d << '\n'
				  << "\t" << std::boolalpha << true << ',' << false << std::endl;

		std::cout.unsetf(std::ios::fixed);
	};

	pritn_test();

	std::cout.imbue(l1);
	pritn_test();

	std::cout.imbue(l2);
	pritn_test();

	std::locale l3(std::locale(), new MyPunct);
	std::cout.imbue(l3);
	pritn_test();


	// const auto& tmput = std::use_facet<std::time_put<char>>(l0);
	// std::tm now = std::chrono::system_clock::to_time_t(std::chrono::system_clock::now());
	// std::string pattern("Now it's: %I:%M%p\n");
	// tmput.put(std::cout, std::cout, ' ', now, pattern.begin(), pattern.end());
	return 0;
}