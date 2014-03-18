#include <string>
#include <cassert>
#include <cstring>
#include <iostream>

struct ci_char_traits : public std::char_traits<char> {
	static bool eq(char lhs, char rhs) {
		return toupper(lhs) == toupper(rhs);
	}
	static bool lt(char lhs, char rhs) {
		return toupper(lhs) < toupper(rhs);
	}
	static const char* find(const char* s, int n, char a) {
		while (n-- > 0 && toupper(*s) != toupper(a)) {
			++s;
		}
		return n >= 0 ? s : 0;
	}
	static int compare(const char* p, const char* q, size_t n) {
		while (n--) {
			if (!eq(*p, *q)) return lt(*p,*q); 
			++p;
			++q;
		}
		return 0;
	}
};

using ci_string = std::basic_string<char, ci_char_traits>;

int main() {
	ci_string s("AbCdE");
	assert(s == "abcde");
	assert(s == "ABCDE");
	assert(strcmp(s.c_str(), "AbCdE") == 0);
	assert(strcmp(s.c_str(), "abcde") != 0);

	// std::cout << ci_string << std::endl;  // no operator<< for ci_string
	std::string a = "str";
	// string c = a + s;  // no operator+
}