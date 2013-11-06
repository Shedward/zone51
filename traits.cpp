#include <cassert>

template <typename T>
class C {
public:
	bool _have_clone() {
		T* (T::*test)() const = &T::Clone;
		test;
		return true;
	}

	~C(){
		assert(_have_clone());
	}
};

class T {
public:
	T* Clone() const {
		return 0;
	};
};

class X {

};

int main() {
	C<T> x;
	// C<X> y;
	return 0;
}