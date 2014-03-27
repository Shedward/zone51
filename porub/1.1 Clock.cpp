#include <iostream>

int main(int argc, char const *argv[])
{
	int h, m;
	std::cin >> h >> m;
	int t = 11 * (60*h + m) % 720;
	if (t != 0) {
		t = 720 - t;
	}
	std::cout << t / 11;
	return 0;
}
