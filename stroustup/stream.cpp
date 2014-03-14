#include <iostream>
#include <stdexcept>
#include <ios>

template<typename T1, typename T2>
void read_pair(T1& first, T2& second) {
	char open_brkt, comma, close_brkt;
	std::cin >> open_brkt >> first >> comma >> close_brkt;
	if (open_brkt != '{' || comma != ',' || close_brkt != '}') {
		std::cin.setstate(std::ios_base::badbit);
		throw std::runtime_error("bad read of pair.");
	}
}

class MyTypeBase {
protected:
	virtual std::ostream& put(std::ostream& s) const = 0;
	friend std::ostream& operator<<(std::ostream& s, const MyTypeBase& v);
};

std::ostream& operator<<(std::ostream& s, const MyTypeBase& v) {
	return v.put(s);
};

class MyTypeI : public MyTypeBase {
public:
	MyTypeI(int a, int b) : a(a), b(b) {};
	int a;
	int b;
protected:
	std::ostream& put(std::ostream& s) const override {
		s << '{' << a << ',' << b << '}';
		return s;
	}
};

class MyTypeII : public MyTypeBase {
public:
	MyTypeII(float a, float b) : a(a), b(b) {};
	float a;
	float b;
protected:
	std::ostream& put(std::ostream& s) const override {
		s << '['<< a << ',' << b << ']';
		return s;
	}
};

int main(int argc, char const *argv[])
{
	std::ios_base::sync_with_stdio(false);
	MyTypeI i {1, 2};
	MyTypeII ii {3.5, 4.5};
	std::cout << i << '\n' << ii;

	MyTypeBase &bi = i;
	MyTypeBase &bii = ii;
	std::cout << bi << bii << std::endl;
	return 0;
}