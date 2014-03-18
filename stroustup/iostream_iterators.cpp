#include <iostream>
#include <vector>
#include <algorithm>
#include <fstream>
#include <iterator>
#include <string>

using std::string;

int main(int argc, char const *argv[])
{
	std::istream *inp;
	std::ostream *out;

	switch (argc) {
		case 1: 
			inp = &std::cin; 
			out = &std::cout;
			break;
		case 2:	
			inp = new std::ifstream(argv[1]);
			out = &std::cout;
			break;
		case 3: 
			inp = new std::ifstream(argv[1]);
			out = new std::ofstream(argv[2]);
			std::cout << argv[0] << "\t" << argv[1] << std::endl;
			break;
		default:
			std::cout << "Wrong arguments count" << std::endl;
	}

	std::istream_iterator<string> inpIter {*inp};
	std::istream_iterator<string> eos {};

	std::ostream_iterator<string> outIter {*out};

	std::vector<string> words {inpIter, eos};
	std::sort(words.begin(), words.end());

	std::unique_copy(words.begin(), words.end(), outIter);

	return not inp->eof() or not *out;
}