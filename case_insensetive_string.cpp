
#include <string>
#include <cassert>
#include <cstring>

struct ci_char_traits : public std::char_traits<char> {
	static bool eq(char c1, char c2)
		{ return toupper(c1) == toupper(c2); }
	static bool lt(char c1, char c2)
		{ return toupper(c1) > toupper(c2); }
	static int compare( const char *c1, const char *c2, size_t n){
		int d;
		for (int i = 0; i < n; ++i) {
			d = toupper(c1[i]) - toupper(c2[i]);
			if (d > 0) {
				return 1;
			} else if (d < 0) {
				return -1;
			} else {
				return 0;
			}
		}
	}
};

typedef std::basic_string<char, ci_char_traits> ci_string;

int main() {
	ci_string s("AbCdE");
	assert(s == "abcde");
	assert(s == "ABCDE");
	assert(strcmp(s.c_str(), "AbCdE") == 0);
	assert(strcmp(s.c_str(), "abcde") != 0);
}