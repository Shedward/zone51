#include <string>
#include <algorithm>
#include <iostream>
#include <map>
#include <ctime>
#include <cstdlib>

typedef std::map<int, int> Map;

int main() {
	const std::string sym = "RGB";
	std::string comb(4, '.');
	std::string guess;

	int cc = 0, cp = 0;
	Map cm, gm;

	srand(time(0));
	std::generate(comb.begin(), comb.end(), [&sym](){
		return sym[rand() % sym.size()];
	});

	while(cp < comb.size()){
		std::cout << "\n\nguess--> ";
		std::cin >> guess;
		guess.resize(comb.size(), ' '),
		cm = gm = Map();

		std::transform(comb.begin(), comb.end(),
					   guess.begin(), guess.begin(),
					   [&cm, &gm, &cp](char c, char g){
					   	return ++cm[c],
					   		   ++gm[g],
					   		   cp += (c == g),
					   		   g;
					   });

		std::for_each(sym.begin(), sym.end(), [&cm, &gm, &cc](char c) {
			cc += std::min(cm[c], gm[c]);
		});

		std::cout << cc << ' ' << cp;
	}

	std::cout << " - solved!\n";

};