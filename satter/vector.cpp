#include <vector>
#include <iostream>
#include <algorithm>

using std::vector;

int main() {
	vector<int> v1(10000000, 0);
	for (auto i = v1.begin()+1; i != v1.end(); ++i){
		*i = *(i-1) + 1;
	}

	v1.erase(v1.begin(), v1.begin()+50000);
	vector<int>(c).swap(c);

	return 0;
}