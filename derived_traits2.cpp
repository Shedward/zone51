template <typename D, typename B>
class IsDerivedFrom {
	static void Constraits(D* p) {
		B* pb = p;
		pb = p;
	}
protected:
	IsDerivedFrom() {
		void(*p)(D*) = Constraits;
	}
};

class Clonable {};

template<typename T>
class WithChecking : IsDerivedFrom<T, Clonable> {
	// ...
};

class ClonableChild : public Clonable {};
class NonClonable {};

int main() {
	WithChecking<Clonable> x;
	WithChecking<ClonableChild> y;
	// WithChecking<NonClonable> z;
}