#include <cassert>

template <typename D, typename B>
class IsDerivedFrom {
	class No {};
	class Yes { No no[2]; };
	static Yes Test(B*);
	static No Test(...);
public:
	enum {
		Is = sizeof(Test(static_cast<D*>(0))) == sizeof(Yes)
	};
};

class Clonable {

};

class NotClonable {

};

template <typename T>
class WithChecking {
	bool ValidateTypes() const {
		typedef IsDerivedFrom<T, Clonable> Y;
		assert(Y::Is);
		return true;
	}
public:
	~WithChecking(){
		assert(ValidateTypes());
	}
};

int main() {
	WithChecking<Clonable> x;
	WithChecking<NotClonable> y; // This not work
}