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

class X {};

template <typename T>
class WithChecking : IsDerivedFrom<T,X>{

};

class DX : public X {};
class Y {};

int main() {
	WithChecking<DX> x;
	//WithChecking<Y> y;
	return 0;
}