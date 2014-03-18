#include <stdio.h>

template <typename D, typename B>
class IsDerivedFrom {
	class Yes {};
	class No { Yes yes[2]; };
	static Yes Test(B*);
	static No Test(...);

	static void Constraints(D *p){
		B* pb = p;
		pb = p;
	}

public:
	enum { Is = sizeof(Test(static_cast<D*>(0))) == sizeof(Yes) };
	IsDerivedFrom() {
		void (*p)(D*) = Constraints;
	}
};

class X {
public:
	void test() {
		printf("X::test()\n");
	}
};

class Y {
public:
	void echo() {
		printf("Y::echo()\n");
	};
};

template <typename T>
class WithChecking : IsDerivedFrom<T,X>{

};

// Default implementation.
template <typename T, int>
class PolyImpl {
public:
	void test() {
		T val;
		val.test();
	}
};

// Implementation for Y's with echo instead test
template <typename T>
class PolyImpl<T,1> {
public:
	void test() {
		T val;
		val.echo();
	}
};

template <typename T>
class Poly {
private:
	PolyImpl<T, IsDerivedFrom<T, Y>::Is > impl_;
public:
	void test() {
		impl_.test();
	}
};

class DX : public X {};
class DY : public Y {};

int main() {
	WithChecking<DX> x;
	// WithChecking<DY> y;

	Poly<DX> l;
	l.test();
	Poly<DY> m;
	m.test();
	return 0;
}