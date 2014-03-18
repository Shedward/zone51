template <typename T>
class HasClone {
public:
	static void Constraints() {
		T* (T::*test)() const = &T::Clone;
		test;
	}
	HasClone() { void (*p)() = Constraints; }
};

template <typename T>
class Test : HasClone <T> {
};

class WithClone {
public:
	WithClone* Clone() const {
		return 0;
	};
};

class WithoutClone {

};

int main() {
	Test<WithClone> x;
	// Test<WithoutClone> y;
}